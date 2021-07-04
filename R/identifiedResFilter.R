#' Title
#' Filter identified Result
#'
#' @param batchMS2ScoreResult batchMS2ScoreResult.
#' @param MS2score The threshold of MS2 score.
#'
#' @return sheets
#' @export identifiedResFilter
#' @import dplyr
#' @importFrom openxlsx write.xlsx
#' @importFrom utils read.csv
#'
#' @examples
#' load(system.file("extdata/testData", "batchMS2ScoreResult.Rda", package = "MetEx"))
#' filteredres <- identifiedResFilter(batchMS2ScoreResult = batchMS2ScoreResult, MS2score = 0.6)

identifiedResFilter <- function(batchMS2ScoreResult, MS2score){

  # require("do")
  # require("openxlsx")
  # require("dplyr")
  Name <- NULL
  peakHeight <- NULL
  trOfPeak <- NULL
  entropy <-NULL
  score <- NULL
  MSMS.Exp <- NULL

  identifiedRes <- batchMS2ScoreResult

  MS1identifiedRes <- identifiedRes %>% group_by(Name) %>% filter(peakHeight == max(peakHeight))
  MS1identifiedRes <- distinct(MS1identifiedRes, Name, .keep_all = TRUE)

  MS2acquired.identifiedRes <- identifiedRes[which(identifiedRes$score != "Can't find MS2"),]
  MS2acquired.identifiedRes <- MS2acquired.identifiedRes[which(MS2acquired.identifiedRes$score >= MS2score),]

  peak_duplicated_MS2identifiedRes = MS2acquired.identifiedRes %>% group_by(trOfPeak, peakHeight, entropy) %>% filter(score == max(score))
  MSMS_duplicated_MS2identifiedRes = MS2acquired.identifiedRes %>% group_by(trOfPeak, peakHeight, entropy, MSMS.Exp) %>% filter(score == max(score))

  sheets = list("MS1 identified Result" = MS1identifiedRes,"MS2 identified Result" = MS2acquired.identifiedRes, "peak duplicated Result" = peak_duplicated_MS2identifiedRes, "MSMS duplicated Result" = MSMS_duplicated_MS2identifiedRes)
  return(sheets)
}

