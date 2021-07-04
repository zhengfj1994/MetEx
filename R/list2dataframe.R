#' Title
#' Tranfer list to dataframe.
#'
#' @param ms2List a list containing the information of MSMS
#'
#' @return ms2Dataframe
#' @export list2dataframe
#'
#' @examples
#' load(system.file("extdata/testData", "ms2ListTest.rda", package = "MetEx"))
#' ms2Dataframe <- list2dataframe(ms2ListTest)
list2dataframe <- function(ms2List){
  ms2Dataframe <- data.frame(mz = 0,intensity = 0)
  ms2Dataframe <- ms2Dataframe[-1,]
  for (i in c(1:length(ms2List))){
    ms2Dataframe[i,'mz'] <- as.numeric(ms2List[[i]][1])
    ms2Dataframe[i,'intensity'] <- as.numeric(ms2List[[i]][2])
  }
  return(ms2Dataframe)
}
