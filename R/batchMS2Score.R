#' Title batchMS2Score
#'
#' @param ms1Info the result of extracResFliter
#' @param ms1DeltaMZ the difference of m/z between ms1Info and mgf files
#' @param ms2DeltaMZ the difference of m/z between mgf and database of MS2
#' @param deltaTR the difference of retention time between ms1Info and mgf
#' @param mgfMatrix the mgf mateix that created by importMgf
#' @param mgfData the mgf data that created by inportMgf
#' @param MS2.sn.threshold The S/N threshold of MS2.
#' @param MS2.noise.intensity The intensity of noise of MS2 spectrum.
#' @param MS2.missing.value.padding The MS2 missing value padding method, "half" or "minimal.value"
#' @param ms2Mode MS2 acquisition mode, there are two selection for this parameter, 'ida' and 'dia'
#' @param scoreMode MS2 score mode, 'obverse','reverse' and 'average'
#' @param diaMethod if the MS2 acquisition mode is dia, a diaMethod is necessary. If is ida, diaMethod can be set as "NA"
#'
#' @return ms2ScoreResult
#' @export batchMS2Score
#' @importFrom tcltk tkProgressBar setTkProgressBar
#' @importFrom utils read.table
#'
#' @examples
#' load(system.file("extdata/testData", "ms1InfoTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "mgfMatrixTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "mgfDataTest.rda", package = "MetEx"))
#' ms2ScoreResult <- batchMS2Score(ms1Info = ms1InfoTest,
#'                                 ms1DeltaMZ = 0.01,
#'                                 ms2DeltaMZ = 0.02,
#'                                 deltaTR = 15,
#'                                 mgfMatrix = mgfMatrixTest,
#'                                 mgfData = mgfDataTest)
#' @references
#' Tsugawa, Hiroshi , et al. "MS-DIAL: data-independent MS/MS deconvolution for comprehensive metabolome analysis." Nature Methods 12.6(2015):523-526.
batchMS2Score <- function(ms1Info,
                          ms1DeltaMZ,
                          ms2DeltaMZ,
                          deltaTR,
                          mgfMatrix,
                          mgfData,
                          MS2.sn.threshold = 3,
                          MS2.noise.intensity = "minimum",
                          MS2.missing.value.padding = "half",
                          ms2Mode = 'ida',
                          scoreMode = 'average',
                          diaMethod = 'NA') {

  # require("stringr")
  # require("tcltk")

  MSMS.Exp <- vector(mode="character",length = nrow(ms1Info))
  DP <- vector(mode="character",length = nrow(ms1Info))
  RDP <- vector(mode="character",length = nrow(ms1Info))
  frag.ratio <- vector(mode="character",length = nrow(ms1Info))
  score <- vector(mode="character",length = nrow(ms1Info))
  epeaksPosiStart <- which("extractedPeaks" == names(ms1Info))
  epeaksPosiEnd <- ncol(ms1Info)
  pb <- tkProgressBar("batchMS2Score","Rate of progress %", 0, 100)
  if (ms2Mode=='dia'){
    diaMethodmatrix <- read.table(diaMethod)
  }
  mzinmgf <- as.matrix(mgfMatrix[ , 'pepmassNum'])
  trinmgf <- as.matrix(mgfMatrix[ , 'trNum'])
  for (i in c(1:nrow(ms1Info))){
    info <- sprintf("Rate of progress %d%%", round(i*100/nrow(ms1Info)))
    setTkProgressBar(pb, i*100/nrow(ms1Info), sprintf("batchMS2Score (%s)", info),info)

    mzi <- ms1Info$'m/z'[i]
    tri <- ms1Info$trOfPeak[i]

    ms2DB <- as.character(ms1Info$MSMS[i])
    ms2DB <- strsplit(ms2DB, ";", fixed=TRUE)
    ms2DB <- strsplit(unlist(ms2DB), " ", fixed=TRUE)
    ms2DB <- list2dataframe(ms2DB)
    ms2DB <- na.omit(ms2DB)
    ms2DB <- ms2DB[which(ms2DB[,1] < (mzi+ms2DeltaMZ)),]
    if (nrow(ms2DB)==0){
      next()
    }

    ms2ActInRaw <- ms1ms2Match(mzi,tri,ms1DeltaMZ,deltaTR,mgfMatrix,mgfData,ms2Mode,diaMethod)
    if (length(ms2ActInRaw) == 0){
      DP[i] <- NA
      RDP[i] <- NA
      frag.ratio[i] <- NA
      score[i] <- "Can't find MS2"
      MSMS.Exp[i] <- NA
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
        DP[i] <- NA
        RDP[i] <- NA
        frag.ratio[i] <- NA
        score[i] <- 0
        MSMS.Exp[i] <- NA
      }else{
        DP[i] <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "obverse")
        RDP[i] <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "reverse")
        frag.ratio[i] <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "matched.fragments.ratio")
        score[i] <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode)
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
          candidateScore[j] <- ms2Score(ms2Act, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode)
        }
      }
      ms2DB.DPs <- ms2ActInRaw[[which.max(candidateScore)]]
      ms2DB.DPs <- strsplit(ms2DB.DPs, " ", fixed=TRUE)
      ms2DB.DPs <- list2dataframe(ms2DB.DPs)
      ms2DB.DPs <- na.omit(ms2DB.DPs)
      DP[i] <- ms2Score(ms2DB.DPs, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "obverse")
      RDP[i] <- ms2Score(ms2DB.DPs, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "reverse")
      frag.ratio[i] <- ms2Score(ms2DB.DPs, ms2DB, ms2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "matched.fragments.ratio")
      score[i] = max(candidateScore)
      MSMS.Exp[i] <- paste(ms2ActInRaw[[which.max(candidateScore)]],collapse=";")
    }
  }
  close(pb)
  ms2ScoreResult <- cbind(ms1Info,MSMS.Exp,DP,RDP,frag.ratio,score)
  return(ms2ScoreResult)
}
