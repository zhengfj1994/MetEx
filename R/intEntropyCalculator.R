#' Title
#' Calculate entropy
#'
#' @param dataPeakSheak, a matrix which has two column of MSMS
#'
#' @return entropy
#' @export intEntropyCalculator
#'
#' @examples
#' load(system.file("extdata/testData", "dataPeakSheakTest.rda", package = "MetEx"))
#' entropy <- intEntropyCalculator(dataPeakSheak = dataPeakSheakTest)
#' @references
#' Ju R, Liu X, Zheng F, et al. Removal of False Positive Features to Generate Authentic Peak Table for High-resolution Mass Spectrometry-based Metabolomics Study[J]. Analytica Chimica Acta, 2019.

intEntropyCalculator <- function(dataPeakSheak){
  x.inv <- try(dataPeakSheak[,2], silent=TRUE)
  if ('try-error' %in% class(x.inv)){
    entropy <- 0
  }
  else{
    data <- dataPeakSheak[,2]
    r <- length(data)
    S <- sum(data)
    entropy <- 0
    for (i in c(1:r))
    {
      temp_entropy <- -1*data[i]/S*log(data[i]/S)
      entropy <- entropy + temp_entropy
    }
  }
  return(entropy)
}
