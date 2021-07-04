#' Title
#' Use function in python to do peak detection.
#'
#' @param eicData, a matrix containing EIC data, the first column is rt (retention time) and the second column is intensity.
#' @param m parameter of peak detection.
#'
#' @return extractedPeaks
#' @export peakDetection
#'
#' @examples
#' load(system.file("extdata/testData", "eicDataTest.rda", package = "MetEx"))
#' extractedPeaks <- peakDetection(eicData = eicDataTest, m=200)
#' @references
#' https://github.com/stas-g/findPeaks

peakDetection <- function(eicData,
                          m = 200){
  find_peaks <- function (x, m = 3){
    shape <- diff(sign(diff(x, na.pad = FALSE)))
    pks <- sapply(which(shape < 0), FUN = function(i){
      z <- i - m + 1
      z <- ifelse(z > 0, z, 1)
      w <- i + m + 1
      w <- ifelse(w < length(x), w, length(x))
      if(all(x[c(z : i, (i + 2) : w)] <= x[i + 1])) return(i + 1) else return(numeric(0))
    })
    pks <- unlist(pks)
    pks
  }
  extractedPeaks <- data.frame(trOfPeak= numeric(), peakHheights= numeric(), stringsAsFactors=FALSE)
  peak_detection_result <- find_peaks(eicData[,2], m)
  extractedPeaks <- as.data.frame(cbind(as.matrix(eicData[,1][peak_detection_result]), as.matrix(eicData[,2][peak_detection_result])))
  colnames(extractedPeaks) <- c("trOfPeak","peakHeight")
  return(extractedPeaks)
}
