#' Title batchMS2Score.QQQ
#'
#' @param ms1Info the result of extracResFliter
#' @param ms1DeltaMZ the difference of m/z between ms1Info and mgf files
#' @param ms2DeltaMZ the difference of m/z between mgf and database of MS2
#' @param deltaTR the difference of retention time between ms1Info and mgf
#' @param intThre Intensity threshold
#' @param mgfMatrix the mgf mateix that created by importMgf
#' @param mgfData the mgf data that created by inportMgf
#'
#' @return ms2ScoreResult
#' @export batchMS2Score.QQQ
#' @importFrom tcltk tkProgressBar setTkProgressBar
#'
#' @examples
#' load(system.file("extdata/testData", "ms1InfoQQQTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "mgfMatrixTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "mgfDataTest.rda", package = "MetEx"))
#' ms2ScoreResult <- batchMS2Score.QQQ(ms1Info = ms1InfoQQQTest,
#'                                     ms1DeltaMZ = 0.01,
#'                                     ms2DeltaMZ = 0.02,
#'                                     deltaTR = 15,
#'                                     intThre = 270,
#'                                     mgfMatrix = mgfMatrixTest,
#'                                     mgfData = mgfDataTest)
batchMS2Score.QQQ <- function(ms1Info,
                              ms1DeltaMZ,
                              ms2DeltaMZ,
                              deltaTR,
                              intThre,
                              mgfMatrix,
                              mgfData) {
  # require("stringr")
  # require("tcltk")

  MSMS.Exp <- vector(mode="character",length = nrow(ms1Info))
  score <- vector(mode="character",length = nrow(ms1Info))
  pb <- tkProgressBar("batchMS2Score","Rate of progress %", 0, 100)
  product.ion.position <- grep(pattern="Product.ion",colnames(ms1Info))

  mzinmgf <- as.matrix(mgfMatrix[ , 'pepmassNum'])
  trinmgf <- as.matrix(mgfMatrix[ , 'trNum'])
  for (i in c(1:nrow(ms1Info))){
    info<- sprintf("Rate of progress %d%%", round(i*100/nrow(ms1Info)))
    setTkProgressBar(pb, i*100/nrow(ms1Info), sprintf("batchMS2Score (%s)", info),info)

    mzi <- ms1Info$m.z[i]
    tri <- ms1Info$trOfPeak[i]
    ms2ActInRaw <- ms1ms2Match(mzi,tri,ms1DeltaMZ,deltaTR,mgfMatrix,mgfData,ms2Mode = 'ida',diaMethod = "NA")
    if (length(ms2ActInRaw) == 0){
      score[i] <- "Can't find MS2"
      MSMS.Exp[i] <- NA
    }
    else if (length(ms2ActInRaw) == 1){
      ms2Act <- ms2ActInRaw[[1]]
      ms2Act <- strsplit(ms2Act, " ", fixed=TRUE)
      ms2Act <- list2dataframe(ms2Act)
      ms2Act <- na.omit(ms2Act)
      ms2ActNormalization <- cbind(ms2Act[,1], ms2Act[,2]/max(ms2Act[,2]))
      ms2Act[which(ms2ActNormalization[,2] > intThre),]
      ms2DB <- ms1Info[i,product.ion.position]
      if (nrow(ms2Act)==0){
        score[i] <- 0
        MSMS.Exp[i] <- NA
      }else{
        count.matched <- 0
        for (ms2DB.i in c(1:length(ms2DB))){
          product.ion.ms2DB.i <-  which(abs(ms2Act$mz - as.numeric(ms2DB[ms2DB.i])) < ms2DeltaMZ)
          if (length(product.ion.ms2DB.i) == 0){
            count.matched <- count.matched + 0
          }
          else if (length(product.ion.ms2DB.i) > 0){
            count.matched <- count.matched + 1
          }
        }
        score[i] <- count.matched/length(product.ion.position)
        MSMS.Exp[i] <- paste(ms2ActInRaw[[1]],collapse=";")
      }
    }
    else{
      candidateScore <- vector(mode="character",length = length(ms2ActInRaw))
      for (j in c(1:length(ms2ActInRaw))){
        ms2Act <- ms2ActInRaw[[j]]
        ms2Act <- strsplit(as.character(ms2Act), " ", fixed=TRUE)
        ms2Act <- list2dataframe(ms2Act)
        ms2Act <- na.omit(ms2Act)
        ms2ActNormalization <- cbind(ms2Act[,1], ms2Act[,2]/max(ms2Act[,2]))
        ms2Act[which(ms2ActNormalization[,2] > intThre),]
        ms2DB <- ms1Info[i,product.ion.position]
        if (nrow(ms2Act)==0){
          candidateScore[j] <- 0
        }else{
          count.matched <- 0
          for (ms2DB.i in c(1:length(ms2DB))){
            product.ion.ms2DB.i <-  which(abs(ms2Act$mz - as.numeric(ms2DB[ms2DB.i])) < ms2DeltaMZ)
            if (length(product.ion.ms2DB.i) == 0){
              count.matched <- count.matched + 0
            }
            else if (length(product.ion.ms2DB.i) > 0){
              count.matched <- count.matched + 1
            }
          }
          candidateScore[j] <- count.matched/length(product.ion.position)
        }
      }
      score[i] <- max(candidateScore)
      MSMS.Exp[i] <- paste(ms2ActInRaw[[which.max(candidateScore)]],collapse=";")
    }
  }
  close(pb)
  ms2ScoreResult <- cbind(ms1Info,MSMS.Exp,score)
  return(ms2ScoreResult)
}
