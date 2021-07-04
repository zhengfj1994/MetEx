#' Title
#' Fliter the result of targetExtraction by entropy and intensity.
#'
#' @param targExtracRes, the result of targetExtraction
#' @param entroThre, the threshold of entropy
#' @param intThre, the threshold of intensity
#' @param classficationMethod Classfication Method, "NoSVM" or "SVM".
#'
#' @return ms1Info
#' @export extracResFilter
#'
#' @examples
#' load(system.file("extdata/testData", "targExtracResTest.rda", package = "MetEx"))
#' ms1Info <- extracResFilter(targExtracRes = targExtracResTest,
#'                            entroThre=2,
#'                            intThre=250,
#'                            classficationMethod="NoSVM")

extracResFilter <- function(targExtracRes,
                            entroThre,
                            intThre,
                            classficationMethod="NoSVM"){
  ms1Info <- targExtracRes[which(targExtracRes$trOfPeak != 'Out of range'),]
  entropy <- as.matrix(ms1Info[ , 'entropy'])
  peakHeight <- as.matrix(ms1Info[ , 'peakHeight'])
  count <- 1
  deleteRow <- c()
  if (classficationMethod == "SVM"){
    for (i in c(1:nrow(ms1Info))){
      if (log10(as.numeric(peakHeight[i])) > 1.285998 * as.numeric(entropy[i]) + 0.5905482){
        deleteRow[count] <- i
        count <- count + 1
      }
    }
    if (is.null(deleteRow)){
      ms1Info <- ms1Info
    }
    else{
      ms1Info <- ms1Info[-deleteRow,]
    }
  }
  else {
    for (i in c(1:nrow(ms1Info))){
      if (as.numeric(entropy[i]) > entroThre | as.numeric(peakHeight[i]) < intThre){
        deleteRow[count] <- i
        count <- count + 1
      }
    }
    if (is.null(deleteRow)){
      ms1Info <- ms1Info
    }
    else{
      ms1Info <- ms1Info[-deleteRow,]
    }
  }
  return(ms1Info)
}
