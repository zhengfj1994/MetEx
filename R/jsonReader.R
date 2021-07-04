#' Title
#' Convert json file to csv file.
#'
#' @param jsonFile json file
#' @param csvFile csv file
#' @param pagesize number of lines to read/write from/to the connection per iteration.
#'
#' @export jsonReader
#' @importFrom jsonlite stream_in
#' @importFrom utils write.csv
#'
#' @examples
#' json.df <- jsonReader(jsonFile =
#'                       system.file("extdata/json", "example.json", package = "MetEx"),
#'                       csvFile = "E:/test.csv")

jsonReader <- function(jsonFile, csvFile, pagesize = 100){
  json.data <- stream_in(file(jsonFile), pagesize = pagesize)
  write.csv(json.data, file = csvFile)
}
