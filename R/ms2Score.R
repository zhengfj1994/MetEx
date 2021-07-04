#' Title
#' Give MSMS Score.
#'
#' @param ms2Act, measured ms2
#' @param ms2DB, ms2 in database
#' @param ms2DeltaMZ, the tolerence between ms2Act and ms2DB
#' @param scoreMode, the mode of score, obverse, reverse or average
#' @param sn.threshold The S/N threshold of MS2 spectrum.
#' @param noise.intensity The intensity of noise of MS2 spectrum.
#' @param missing.value.padding The missing value padding method of MS2.
#'
#' @return scoreOfMS2
#' @export ms2Score
#'
#' @examples
#' load(system.file("extdata/testData", "ms2ActTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "ms2DBTest.rda", package = "MetEx"))
#' scoreOfMS2 <- ms2Score(ms2Act = ms2ActTest,
#'                        ms2DB = ms2DBTest,
#'                        ms2DeltaMZ=0.02,
#'                        sn.threshold = 3,
#'                        missing.value.padding = "minimal.value",
#'                        scoreMode='average')

ms2Score <- function(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = 3, noise.intensity = "minimum", missing.value.padding, scoreMode){

  if (noise.intensity == "minimum"){
    noise.intensity <- min(ms2Act$intensity)
  }
  else if (is.numeric(noise.intensity)){
    noise.intensity <- noise.intensity
  }
  else {
    stop(simpleError("The parameter 'noise.intensity' must be 'minimum' or a number!"))
  }

  ms2ActNormalization <- ms2Act[which(ms2Act$intensity > sn.threshold * noise.intensity), ]
  if (nrow(ms2ActNormalization) == 0){
    ms2ActNormalization <- ms2Act[0,]
  }
  else {
    ms2ActNormalization[,2] <- ms2ActNormalization[,2]/max(ms2ActNormalization[,2])
  }

  ###################################################
  if (length(which.min(ms2DB$intensity)) > 5){
    ms2ActNormalization <- ms2DB[which(ms2DB$intensity > sn.threshold * noise.intensity), ]
    if (nrow(ms2DBNormalization) == 0){
      ms2ActNormalization <- ms2Act[0,]
    }
    else {
      ms2DBNormalization[,2] <- ms2DBNormalization[,2]/max(ms2DBNormalization[,2])
    }
  }
  else {
    ms2DBNormalization <- ms2DB
    ms2DBNormalization[,2] <- ms2DBNormalization[,2]/max(ms2DBNormalization[,2])
  }
  ###################################################
  if (missing.value.padding == "half"){
    intDB2Act <- ms2ActNormalization[, 2]/2
  }
  else if (missing.value.padding == "minimal.value"){
    intDB2Act <- rep(0.001,nrow(ms2ActNormalization))
  }

  matched.count <- 0
  for (i in c(1:length(ms2ActNormalization[,1]))){
    mzActi <- ms2ActNormalization[i,1]
    intActi <- ms2ActNormalization[i,2]
    posi <- which(abs(mzActi - ms2DBNormalization[,1]) < ms2DeltaMZ)

    if (length(posi) > 0){
      matched.count <- matched.count + 1
      intDB2Act[i] <- ms2DBNormalization[which.min(abs(mzActi - ms2DBNormalization[,1])),2]
    }
  }
  ms2Actlib <- cbind(ms2ActNormalization[,2],intDB2Act)
  w_act <- 1/(1+(ms2Actlib[,1]/(sum(ms2Actlib[,1])-0.5)))*ms2Actlib[,1]
  w_lib <- 1/(1+(ms2Actlib[,2]/(sum(ms2Actlib[,2])-0.5)))*ms2Actlib[,2]
  obverseDotProduct <- (w_act %*% w_lib)^2/((w_act %*% w_act) * (w_lib %*% w_lib)) # dot product

  if (missing.value.padding == "half"){
    intAct2DB <- ms2DBNormalization[, 2]/2
  }
  else if (missing.value.padding == "minimal.value"){
    intAct2DB <- rep(0.001,nrow(ms2DBNormalization))
  }

  for (i in c(1:length(ms2DBNormalization[,1]))){
    mzDBj <- ms2DBNormalization[i,1]
    intDBj <- ms2DBNormalization[i,2]
    posi <- which(abs(mzDBj - ms2ActNormalization[,1]) < ms2DeltaMZ)
    if (length(posi) > 0){
      intAct2DB[i] <- ms2ActNormalization[which.min(abs(mzDBj - ms2ActNormalization[,1])),2]
    }
  }
  ms2DBact <- cbind(ms2DBNormalization[,2],intAct2DB)
  w_lib <- 1/(1+(ms2DBact[,1]/(sum(ms2DBact[,1])-0.5)))*ms2DBact[,1]
  w_act <- 1/(1+(ms2DBact[,2]/(sum(ms2DBact[,2])-0.5)))*ms2DBact[,2]
  reverseDotProduct <- (w_lib %*% w_act)^2/((w_lib %*% w_lib) * (w_act %*% w_act))# reverse Dot Product

  if (scoreMode =='obverse'){
    if (matched.count == 0){
      scoreOfMS2 <- 0
    }
    else {
      scoreOfMS2 <- obverseDotProduct
    }
  }
  else if (scoreMode == 'reverse'){
    if (matched.count == 0){
      scoreOfMS2 <- 0
    }
    else {
      scoreOfMS2 <- reverseDotProduct
    }
  }
  else if (scoreMode == 'matched.fragments.ratio'){
    scoreOfMS2 <- matched.count/nrow(ms2ActNormalization)
  }
  else if (scoreMode == 'average'){
    if (matched.count == 0){
      scoreOfMS2 <- 0
    }
    else {
      scoreOfMS2 <- (obverseDotProduct+reverseDotProduct+matched.count/nrow(ms2ActNormalization))/3
    }
  }
  if (is.na(scoreOfMS2)){
    scoreOfMS2 <- 0
  }
  return(scoreOfMS2)
}
