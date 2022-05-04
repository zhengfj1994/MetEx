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

identifiedResFilter <- function(batchMS2ScoreResult, MS2score){

  # require("do")
  # require("openxlsx")
  # require("dplyr")

  identifiedRes <- batchMS2ScoreResult

  MS1identifiedRes <- identifiedRes %>% group_by(Name) %>% filter(peakHeight == max(peakHeight))
  MS1identifiedRes <- distinct(MS1identifiedRes, Name, .keep_all = TRUE)

  MS2acquired.identifiedRes <- identifiedRes[which(identifiedRes$MS2_similarity >= 0.6),]

  peak_duplicated_MS2identifiedRes = MS2acquired.identifiedRes %>% group_by(trOfPeak, peakHeight, entropy) %>% filter(MS2_similarity == max(MS2_similarity))
  MSMS_duplicated_MS2identifiedRes = MS2acquired.identifiedRes %>% group_by(trOfPeak, peakHeight, entropy, MSMS_in_file) %>% filter(MS2_similarity == max(MS2_similarity))

  sheets = list("All identified result" = batchMS2ScoreResult, "MS1 identified Result" = MS1identifiedRes,"MS2 identified Result" = MS2acquired.identifiedRes, "peak duplicated Result" = peak_duplicated_MS2identifiedRes, "MSMS duplicated Result" = MSMS_duplicated_MS2identifiedRes)
  return(sheets)
}

