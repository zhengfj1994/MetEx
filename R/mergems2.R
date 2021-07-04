#' Title
#' merge MSMS
#'
#' @param MS2.matrix, a matrix containing two column
#'
#' @return ms2
#' @export mergems2
#'
#' @examples
#' load(system.file("extdata/testData", "MS2MatrixTest.rda", package = "MetEx"))
#' ms2 <- mergems2(MS2.matrix = MS2MatrixTest)

mergems2 <- function(MS2.matrix){
  MS2.matrix1 <- paste(MS2.matrix[,'mz'], MS2.matrix[,'intensity'], sep=" ")
  res <- MS2.matrix1[1]
  for (i in c(2:length(MS2.matrix1))){
    res <- paste0(res, ";", MS2.matrix1[i])
  }
  return(res)
}
