#' Title batchMS2Score.parallel
#'
#' @param ms1Info the result of extracResFliter
#' @param ms1DeltaMZ the difference of m/z between ms1Info and mgf files
#' @param ms2DeltaMZ the difference of m/z between mgf and database of MS2
#' @param deltaTR the difference of retention time between ms1Info and mgf
#' @param mgfMatrix the mgf mateix that created by importMgf
#' @param mgfData the mgf mateix that created by importMgf
#' @param MS2.sn.threshold The S/N threshold of MS2.
#' @param MS2.noise.intensity The intensity of noise of MS2 spectrum.
#' @param MS2.missing.value.padding The MS2 missing value padding method, "half" or "minimal.value"
#' @param ms2Mode MS2 acquisition mode, 'ida' or 'dia', the default value is 'ida'
#' @param scoreMode The MS2 score mode, default is "average".
#' @param diaMethod If MS2 acquisition mode is "dia", a file save dia method should be provided.
#' @param cores The number of CPU cores when computing.
#'
#' @return ms2ScoreResult
#' @export batchMS2Score.parallel
#' @importFrom snow makeSOCKcluster stopCluster
#' @importFrom progress progress_bar
#' @importFrom doSNOW registerDoSNOW
#' @importFrom utils read.table
#' @import foreach
#'
#' @examples
#' load(system.file("extdata/testData", "ms1InfoTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "mgfMatrixTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "mgfDataTest.rda", package = "MetEx"))
#' ms2ScoreResult <- batchMS2Score.parallel(ms1Info = ms1InfoTest,
#'                                          ms1DeltaMZ = 0.01,
#'                                          ms2DeltaMZ = 0.02,
#'                                          deltaTR = 15,
#'                                          mgfMatrix = mgfMatrixTest,
#'                                          mgfData = mgfDataTest,
#'                                          cores = 1)
#' @references
#' Tsugawa, Hiroshi , et al. "MS-DIAL: data-independent MS/MS deconvolution for comprehensive metabolome analysis." Nature Methods 12.6(2015):523-526.
batchMS2Score.parallel <- function(ms1Info,
                                   ms1DeltaMZ,
                                   ms2DeltaMZ,
                                   deltaTR,
                                   mgfMatrix,
                                   mgfData,
                                   MS2.sn.threshold = 3,
                                   MS2.noise.intensity = "minimum",
                                   MS2.missing.value.padding = "minimal.value",
                                   ms2Mode = 'ida',
                                   scoreMode = 'average',
                                   diaMethod = 'NA',
                                   cores = 4) {

  # require("stringr")
  # require("tcltk")
  # require("doSNOW")
  # require("progress")

  # cores <- parallel::detectCores()
  cl <- makeSOCKcluster(cores)
  registerDoSNOW(cl)

  if (ms2Mode=='dia'){
    diaMethodmatrix <- read.table(diaMethod)
  }
  mzinmgf <- as.matrix(mgfMatrix[ , 'pepmassNum'])
  trinmgf <- as.matrix(mgfMatrix[ , 'trNum'])

  ptm <- proc.time()

  # progress bar ------------------------------------------------------------
  iterations <- nrow(ms1Info)
  pb <- progress_bar$new(
    format = ":letter [:bar] :elapsed | Remaining time: :eta <br>",
    total = iterations,
    width = 120)
  # allowing progress bar to be used in foreach -----------------------------
  progress <- function(n){
    pb$tick(tokens = list(letter = "Progress of MS2 score"))
  }
  opts <- list(progress = progress)

  i <- NULL
  func <- function(i){
    df.batchMS2Score <- data.frame(MSMS.Exp = c(NA), DP = c(NA), RDP = c(NA), frag.ratio = c(NA), score = c(NA))
    batchMS2ScoreRes.i <- cbind(ms1Info[i,],df.batchMS2Score)

    ms2DB <- as.character(ms1Info$MSMS[i])
    ms2DB <- strsplit(ms2DB, ";", fixed=TRUE)
    ms2DB <- strsplit(unlist(ms2DB), " ", fixed=TRUE)
    ms2DB <- list2dataframe(ms2DB)
    ms2DB <- na.omit(ms2DB)

    mzi <- ms1Info$m.z[i]
    tri <- ms1Info$trOfPeak[i]

    ms2DB <- ms2DB[which(ms2DB[,1] < (mzi+ms2DeltaMZ)),]
    if (nrow(ms2DB)==0){
      batchMS2ScoreRes.i$DP <- NA
      batchMS2ScoreRes.i$RDP <- NA
      batchMS2ScoreRes.i$frag.ratio <- NA
      batchMS2ScoreRes.i$score <- "Can't find MS2 in Database"
      batchMS2ScoreRes.i$MSMS.Exp <- NA
    }

    else {
      ms2ActInRaw <- ms1ms2Match(mzi,tri,ms1DeltaMZ,deltaTR,mgfMatrix,mgfData,ms2Mode,diaMethod)
      if (length(ms2ActInRaw) == 0){
        batchMS2ScoreRes.i$DP <- NA
        batchMS2ScoreRes.i$RDP <- NA
        batchMS2ScoreRes.i$frag.ratio <- NA
        batchMS2ScoreRes.i$score <- "Can't find MS2"
        batchMS2ScoreRes.i$MSMS.Exp <- NA
      }
      else if (length(ms2ActInRaw) == 1){
        ms2Act <- ms2ActInRaw[[1]]
        ms2Act <- strsplit(ms2Act, " ", fixed=TRUE)
        ms2Act <- list2dataframe(ms2Act)
        ms2Act <- na.omit(ms2Act)
        ms2Act <- ms2Act[which(ms2Act[,1] < (mzi+ms2DeltaMZ)),]

        ms2DB <- as.character(ms1Info$MSMS[i])
        ms2DB <- strsplit(ms2DB, ";", fixed=TRUE)
        ms2DB <- strsplit(unlist(ms2DB), " ", fixed=TRUE)
        ms2DB <- list2dataframe(ms2DB)
        ms2DB <- na.omit(ms2DB)
        ms2DB <- ms2DB[which(ms2DB[,1] < (mzi+ms2DeltaMZ)),]
        if (nrow(ms2Act)==0){
          batchMS2ScoreRes.i$DP <- NA
          batchMS2ScoreRes.i$RDP <- NA
          batchMS2ScoreRes.i$frag.ratio <- NA
          batchMS2ScoreRes.i$score <- 0
          batchMS2ScoreRes.i$MSMS.Exp <- NA
        }else{
          batchMS2ScoreRes.i$DP <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "obverse")
          batchMS2ScoreRes.i$RDP <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "reverse")
          batchMS2ScoreRes.i$frag.ratio <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "matched.fragments.ratio")
          batchMS2ScoreRes.i$score <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode)
          batchMS2ScoreRes.i$MSMS.Exp <- paste(ms2ActInRaw[[1]],collapse=";")
        }
      }
      else{
        candidateScore <- vector(mode="character",length = length(ms2ActInRaw))
        for (j in c(1:length(ms2ActInRaw))){
          ms2Act <- ms2ActInRaw[[j]]
          ms2Act <- strsplit(as.character(ms2Act), " ", fixed=TRUE)
          ms2Act <- list2dataframe(ms2Act)
          ms2Act <- na.omit(ms2Act)
          ms2Act <- ms2Act[which(ms2Act[,1] < (mzi+ms2DeltaMZ)),]

          ms2DB <- as.character(ms1Info$MSMS[i])
          ms2DB <- strsplit(ms2DB, ";", fixed=TRUE)
          ms2DB <- strsplit(unlist(ms2DB), " ", fixed=TRUE)
          ms2DB <- list2dataframe(ms2DB)
          ms2DB <- na.omit(ms2DB)
          ms2DB <- ms2DB[which(ms2DB[,1] < (mzi+ms2DeltaMZ)),]
          if (nrow(ms2Act)==0){
            candidateScore[j] <- 0
          }else{
            candidateScore[j] <- ms2Score(ms2Act, ms2DB, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, ms2DeltaMZ, scoreMode)
          }
        }
        ms2DB.DPs <- ms2ActInRaw[[which.max(candidateScore)]]
        ms2DB.DPs <- strsplit(ms2DB.DPs, " ", fixed=TRUE)
        ms2DB.DPs <- list2dataframe(ms2DB.DPs)
        ms2DB.DPs <- na.omit(ms2DB.DPs)
        batchMS2ScoreRes.i$DP <- ms2Score(ms2DB.DPs, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "obverse")
        batchMS2ScoreRes.i$RDP <- ms2Score(ms2DB.DPs, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "reverse")
        batchMS2ScoreRes.i$frag.ratio <- ms2Score(ms2DB.DPs, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "matched.fragments.ratio")
        batchMS2ScoreRes.i$score = max(candidateScore)
        batchMS2ScoreRes.i$MSMS.Exp <- paste(ms2ActInRaw[[which.max(candidateScore)]],collapse=";")
      }
    }

    return(batchMS2ScoreRes.i)
  }
  ms2ScoreResult <- foreach(i=1:nrow(ms1Info), .options.snow=opts, .combine='rbind') %dopar% func(i)
  # targExtracRes <- foreach(i=1:nrow(dbData), .combine= 'rbind') %dopar% func(i)
  stopCluster(cl)

  print(proc.time()-ptm)
  packageStartupMessage("MS2 spectral similarity calculation is finished")
  # write.table(targExtracRes, file = "mydata.csv", col.names = NA, sep = ",", dec = ".", qmethod = "double")
  return(ms2ScoreResult)
}

