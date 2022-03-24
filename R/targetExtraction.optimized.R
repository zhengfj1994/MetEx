#' Title
#' Targeted extraction from untargeted metabolomics data by using the screen result of dbImporter
#'
#' @param msRawData, the MS data which have a XCMS-support filetype (such as mzXML)
#' @param dbData, the metabolomics database which first processed by dbImporter
#' @param deltaMZ, the m/z tolerence of MS1 between database and raw data
#' @param deltaTR, the retention time tolerence of MS1 between database and raw data
#' @param trRange retention time range for extraction.
#' @param m parameter of peak detection.
#'
#' @return targExtracRes
#' @export targetExtraction.optimized
#' @importFrom tcltk tkProgressBar setTkProgressBar
#' @importFrom xcms xcmsRaw getEIC
#'
#' @examples
#' load(system.file("extdata/testData", "dbDataTest.rda", package = "MetEx"))
#' targExtracRes <- targetExtraction.optimized(
#'                  msRawData = system.file("extdata/mzXML", "example.mzXML", package = "MetEx"),
#'                  dbData = dbDataTest,
#'                  deltaMZ=0.01,
#'                  deltaTR=60)

targetExtraction.optimized <- function(msRawData,
                             dbData,
                             deltaMZ,
                             deltaTR,
                             trRange = 30,
                             m = 200){

  # require("tcltk")
  # require("xcms")
  ptm <- proc.time()
  rawData <- xcmsRaw(msRawData)

  mzmed <- dbData$`m/z`
  rtmed <- dbData$tr
  mzAndRt <- as.data.frame(cbind(c(1:length(mzmed)),paste(mzmed, rtmed)))
  colnames(mzAndRt) <- c("ID","mzAndRt")
  mzAndRt$ID <- as.numeric(mzAndRt$ID)

  uniqueMzAndRtID <- which(!duplicated(mzAndRt$mzAndRt))
  uniqueMzAndRt <- mzAndRt[uniqueMzAndRtID,]
  uniqueMzAndRt$ID <- c(1:nrow(uniqueMzAndRt))
  colnames(uniqueMzAndRt) <- c("uniqueID", "mzAndRt")

  mergeData <- merge(mzAndRt,uniqueMzAndRt,by="mzAndRt")
  mergeData <- mergeData[order(mergeData$ID),]

  mzmed <- mzmed[uniqueMzAndRtID]
  rtmed <- rtmed[uniqueMzAndRtID]

  mzRanges <- cbind(as.numeric(mzmed) - deltaMZ/2, as.numeric(mzmed) + deltaMZ/2)
  indexTemp <- which(mzRanges[,2] < min(rawData@mzrange))
  mzRanges[indexTemp,] <- min(rawData@mzrange)
  indexTemp <- which(mzRanges[,1] > max(rawData@mzrange))
  mzRanges[indexTemp,] <- max(rawData@mzrange)
  mzRanges[which(mzRanges[,2] > max(rawData@mzrange) & mzRanges[,1] < max(rawData@mzrange)),2] <- max(rawData@mzrange)
  mzRanges[which(mzRanges[,2] > min(rawData@mzrange) & mzRanges[,1] < min(rawData@mzrange)),1] <- min(rawData@mzrange)

  rtRanges <- cbind(as.numeric(rtmed) - deltaTR/2, as.numeric(rtmed) + deltaTR/2)
  indexTemp <- which(rtRanges[,2] - 2 < min(rawData@scantime))
  rtRanges[indexTemp,] <- cbind(rep(min(rawData@scantime),length(indexTemp)), rep(min(rawData@scantime)+10,length(indexTemp)))
  indexTemp <- which(rtRanges[,1] + 2 > max(rawData@scantime))
  rtRanges[indexTemp,] <- cbind(rep(max(rawData@scantime)-10,length(indexTemp)), rep(max(rawData@scantime),length(indexTemp)))
  rtRanges[which(rtRanges[,2] > max(rawData@scantime) & rtRanges[,1] < max(rawData@scantime)),2] <- max(rawData@scantime)
  rtRanges[which(rtRanges[,2] > min(rawData@scantime) & rtRanges[,1] < min(rawData@scantime)),1] <- min(rawData@scantime)

  packageStartupMessage("The extraction will take some time, depending on how many compounds are extracted and the size of the original data, please be patient.")
  EICdata <- getEIC(rawData, mzrange = mzRanges, rtrange = rtRanges)

  EICdataEIC <- EICdata@eic$xcmsRaw
  EICdataEIC <- EICdataEIC[mergeData$uniqueID]

  func <- function(ithRowDbData, ithEICdataEIC){
    extractedPeaks <- peakDectAndEntroCal(ithEICdataEIC, trRange = trRange, m = m)
    return(cbind(ithRowDbData[rep(1,nrow(extractedPeaks)),],extractedPeaks))
  }

  dbDataList <- split(dbData, 1:nrow(dbData))
  targExtracRes <- mapply(func, dbDataList, EICdataEIC, SIMPLIFY = F)
  targExtracRes <- do.call(rbind, lapply(targExtracRes, data.frame))

  print(proc.time()-ptm)
  packageStartupMessage("Targeted extraction is finished")
  return(targExtracRes)
}
