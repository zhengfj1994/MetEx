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
#' @export targetExtraction
#' @importFrom tcltk tkProgressBar setTkProgressBar
#' @importFrom xcms xcmsRaw getEIC
#'
#' @examples
#' load(system.file("extdata/testData", "dbDataTest.rda", package = "MetEx"))
#' targExtracRes <- targetExtraction(
#'                  msRawData = system.file("extdata/mzXML", "example.mzXML", package = "MetEx"),
#'                  dbData = dbDataTest,
#'                  deltaMZ=0.01,
#'                  deltaTR=60)

targetExtraction <- function(msRawData,
                             dbData,
                             deltaMZ,
                             deltaTR,
                             trRange = 30,
                             m = 200){

  # require("tcltk")
  # require("xcms")

  rawData <- xcmsRaw(msRawData)
  dfExtractedPeaks <- data.frame(trOfPeak = c(NA), peakHeight = c(NA), peakArea = c(NA), entropy = c(NA))
  targExtracRes <- cbind(dbData[0,],dfExtractedPeaks[0,])

  ptm <- proc.time()
  pb <- tkProgressBar("targetExtraction","Rate of progress %", 0, 100)
  for (i in c(1:nrow(dbData)))
  {
    info<- sprintf("Rate of progress %d%%", round(i*100/nrow(dbData)))
    setTkProgressBar(pb, i*100/nrow(dbData), sprintf("targetExtraction (%s)", info),info)
    mzi <- as.numeric(dbData$'m/z'[i])
    tri <- as.numeric(dbData$tr[i])
    # Determine if mzi is within the mass spectral scan range
    if (mzi-deltaMZ/2 < rawData@mzrange[1] | mzi+deltaMZ/2 > rawData@mzrange[2]){
      dfExtractedPeaks[1,1:4] <- 'Out of range'
      targExtracResi <- cbind(dbData[i,],dfExtractedPeaks)
      targExtracRes <- rbind(targExtracRes,targExtracResi)
      next()
    }
    else{
      mzRange <- c(mzi-deltaMZ/2, mzi+deltaMZ/2)
    }
    if (tri-deltaTR/2 >= rawData@scantime[length(rawData@scantime)] | tri+deltaTR/2 <= rawData@scantime[1]){
      dfExtractedPeaks[1,1:4] <- 'Out of range'
      targExtracResi <- cbind(dbData[i,],dfExtractedPeaks)
      targExtracRes <- rbind(targExtracRes,targExtracResi)
      next()
    }
    else if (tri-deltaTR/2 <= rawData@scantime[1]){
      EICtrRange <- c(rawData@scantime[1], tri+deltaTR/2)
    }
    else if (tri+deltaTR/2 >= rawData@scantime[length(rawData@scantime)]){
      EICtrRange <- c(tri-deltaTR/2, rawData@scantime[length(rawData@scantime)])
    }
    else{
      EICtrRange <- c(tri-deltaTR/2, tri+deltaTR/2)
    }
    tryRes <- try(xcms::getEIC(rawData, mzRange, EICtrRange)@eic$xcmsRaw[[1]])

    if("try-error" %in% class(tryRes)){
      dfExtractedPeaks[1,1:4] <- 'Out of range'
      targExtracResi <- cbind(dbData[i,],dfExtractedPeaks)
      targExtracRes <- rbind(targExtracRes,targExtracResi)
    }
    else {
      eicData <- xcms::getEIC(rawData, mzRange, EICtrRange)@eic$xcmsRaw[[1]]
      extractedPeaks <- peakDectAndEntroCal(eicData,trRange,m)
      for (j in nrow(extractedPeaks)){
        targExtracResi <- cbind(dbData[i,][rep(1,each=nrow(extractedPeaks)),],extractedPeaks)
        targExtracRes <- rbind(targExtracRes,targExtracResi)
      }
    }

  }
  close(pb)
  print(proc.time()-ptm)
  packageStartupMessage("Targeted extraction is finished")
  # write.table(targExtracRes, file = "mydata.csv", col.names = NA, sep = ",", dec = ".", qmethod = "double")
  return(targExtracRes)
}
