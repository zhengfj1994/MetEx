#' Title
#' Use internal standard retention to cailbrate retention time of metabolites in database.
#'
#' @param is.tR.file, the txt file of IS retention times in database and experimental.
#' @param database.df, the imported database dataframe.
#'
#' @return calibrated.RT.db
#' @export retentionTimeCalibration
#' @importFrom openxlsx read.xlsx
#' @importFrom stats na.omit
#'
#' @examples
#' load(system.file("extdata/testData", "dbDataTest.rda", package = "MetEx"))
#' calibrated.RT.db <- retentionTimeCalibration(is.tR.file =
#'                     system.file("extdata/trCalibration",
#'                     "IS-for-tR-calibration.xlsx", package = "MetEx"),
#'                     database.df = dbDataTest)
#' @references
#' Huan, T. et al. DnsID in MyCompoundID for rapid identification of dansylated amine- and phenol-containing metabolites in LC-MS-based metabolomics. Anal. Chem. 87, 9838-9845 (2015).

retentionTimeCalibration <- function(is.tR.file,
                                     database.df){
  # require("openxlsx")

  is.tR.file.df <- na.omit(read.xlsx(xlsxFile = is.tR.file))
  is.tR.file.df <- is.tR.file.df[order(is.tR.file.df[,2]),]
  is.database <- is.tR.file.df$Database.tR
  is.experimental <- is.tR.file.df$Experimental.tR
  deltaISRT <- is.database-is.experimental
  met.database <- database.df$tr
  calibrated.RT <- met.database
  for (i in c(1:length(met.database))){
    met.databasei <- met.database[i]
    if (met.databasei <= is.database[1]){
      calibrated.RT[i] <- met.databasei-(is.database[1]-is.experimental[1])
    }
    else if (met.databasei >= is.database[length(is.database)]){
      calibrated.RT[i] <- met.databasei-(is.database[length(is.database)]-is.experimental[length(is.database)])
    }
    else{
      deltaISRT1 <- deltaISRT[which(is.database > met.databasei)[1]-1]
      deltaISRT2 <- deltaISRT[which(is.database > met.databasei)[1]]
      calibrated.RT[i] <- met.databasei-(deltaISRT1+(deltaISRT2-deltaISRT1)*(met.databasei-is.database[which(is.database > met.databasei)[1]-1])/(is.database[which(is.database > met.databasei)[1]]-is.database[which(is.database > met.databasei)[1]-1]))
    }
  }
  database.df$tr <- calibrated.RT
  return(database.df)
}
