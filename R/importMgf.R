#' Title
#' Import mgf files and generate mgfData (raw file) and mgfMatrix (a matrix of MS2 data).
#'
#' @param mgfFile the mgf file.
#'
#' @return mgfList
#' @export importMgf
#'
#' @examples
#' mgfList <- importMgf(mgfFile = system.file("extdata/mgf", "example.mgf", package = "MetEx"))
importMgf <- function(mgfFile){
  mgfData <- scan(mgfFile, what = character(0), sep = "\n")
  beginNum <- grep("BEGIN IONS", mgfData)
  pepmassNum <- grep("PEPMASS=",mgfData)
  trNum <- grep("RTINSECONDS=",mgfData)
  endNum <- grep("END IONS", mgfData)
  mgfMatrix <- cbind(beginNum,trNum,pepmassNum,endNum)

  for (i in c(1:length(pepmassNum)))
  {
    only.mass <- unlist(strsplit(mgfData[pepmassNum[i]], " ", fixed = TRUE))[1]
    pepmass <- gsub("[^0-9,.]", "", only.mass)
    mgfMatrix[i,"pepmassNum"] <- pepmass

    tr <- gsub("[^0-9,.]", "", mgfData[trNum[i]])
    mgfMatrix[i,"trNum"] <- tr
  }
  mgfList <- list(mgfData = mgfData, mgfMatrix = mgfMatrix)
  return(mgfList)
}
