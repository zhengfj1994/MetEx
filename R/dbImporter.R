#' Title
#' Import metabolomics database which saved in xlsx file and screen the database by ion mode and CE voltage.
#'
#' @param dbFile, the xlsx file of metabolomics database with a changeless format.
#' @param ionMode, screen the database by ion mode (P or N, others are not available)
#' @param CE, screen the database by CE voltage (15, 30, 45 and 'all' are available)
#'
#' @return dbData
#' @export dbImporter
#' @importFrom openxlsx read.xlsx
#'
#' @examples
#' dbData <- dbImporter(
#'           dbFile=system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
#'           ionMode='P',
#'           CE="all")
dbImporter <- function(dbFile,
                       ionMode,
                       CE = 'all'){
  # Check the database file type
  SuffixName <- strsplit(dbFile,".",fixed = TRUE)[[1]][length(strsplit(dbFile,".",fixed = TRUE)[[1]])]
  if (SuffixName == "xlsx"){
    dbData <- openxlsx::read.xlsx(dbFile,sheet = 1)
    message(paste0("The database '", dbFile, "' is imported"))
  }
  else {
    stop("The file type of database shoulb be .xlsx, others are not available!")
  }

  # Check the column in database
  if (sum(!c("confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","ionMode","Adduct","m/z","tr","CE","MSMS") %in% colnames(dbData)) != 0){
    stop("Please check the row names of the database. 'confidence_level','ID','Name','Formula','ExactMass','SMILES','InChIKey','ionMode','Adduct','m/z','tr','CE','MSMS' must containing in the database.")
  }

  # Check the ionMode
  if (ionMode != 'P' & ionMode != 'N'){
    stop("ionMode should be 'P' or 'N', others are not available!")
  }

  # Check the CE
  if (CE != 15 & CE != 30 & CE != 45 & CE != 'all'){
    stop("CE should be 15, 30, 45 or 'all', others are not available!")
  }

  dbDataIonMode <- dbData[which(dbData$ionMode== ionMode), ]
  if (CE == 'all'){
    dbDataIonModeCE <- dbDataIonMode
  }
  else {
    dbDataIonModeCE <- dbDataIonMode[which(dbDataIonMode$CE== CE), ]
  }

  # Check the m/z value
  if (sum(is.na(dbDataIonModeCE$`m/z`)) != 0){
    warning("There are missing values in the m/z column! Please check if it is correct, otherwise MetEx will delete the rows with missing values.")
    dbDataIonModeCE = dbDataIonModeCE[which(!is.na(dbDataIonModeCE$`m/z`)), ]
  }

  # Check the tr value
  if (sum(is.na(dbDataIonModeCE$tr)) != 0){
    warning("There are missing values in the tr column! Please check if it is correct, otherwise MetEx will delete the rows with missing values.")
    dbDataIonModeCE = dbDataIonModeCE[which(!is.na(dbDataIonModeCE$tr)), ]
  }
  if (max(dbDataIonModeCE$tr) < 180){
    warning("We have checked that the retention time is generally too small, please reconfirm that all retention times are converted to values in seconds!")
  }

  if (sum(is.na(dbDataIonModeCE$MSMS)) != 0){
    warning("There are missing values in the MSMS column! Please check if it is correct, otherwise MetEx will delete the rows with missing values.")
    dbDataIonModeCE = dbDataIonModeCE[which(!is.na(dbDataIonModeCE$MSMS)), ]
  }

  message("The database import and check have been completed.")
  return(dbDataIonModeCE)

}
