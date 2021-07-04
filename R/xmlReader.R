#' Title
#' Convert json file to csv file.
#'
#' @param xmlFile xml file
#' @param csvFile csv file
#'
#' @export xmlReader
#' @importFrom XML xmlToDataFrame
#' @importFrom utils write.csv
#'
#' @examples
#' xml.df <- xmlReader(xmlFile =
#'                     system.file("extdata/xml", "example.xml", package = "MetEx"),
#'                     csvFile = "E:/test.csv")

xmlReader <- function(xmlFile, csvFile){
  xmldataframe <- xmlToDataFrame(xmlFile)
  write.csv(xmldataframe, file = csvFile)
}


