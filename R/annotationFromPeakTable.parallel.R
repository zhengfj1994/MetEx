#' Title
#'
#' @param peakTable Peak table containing m/z and tr.
#' @param mgfFile The MGF file containing MS/MS information.
#' @param database The database used for identification.
#' @param ionMode Positive ion mode is 'P', negative ion mode is 'N'.
#' @param CE Collision energy，default value is 'all'.
#' @param tRCalibration T or F, T will do retention time calibration and F will not.
#' @param is.tR.file The retention time of internal standards which saved in a xlsx file.
#' @param MS1DeltaMZ Delta m/z of MS1.
#' @param MS1DeltaTR Delta retention time.
#' @param MS2.sn.threshold The S/N threshold of MS2.
#' @param MS2.noise.intensity The intensity of noise of MS2 spectrum.
#' @param MS2.missing.value.padding The MS2 missing value padding method, "half" or "minimal.value"
#' @param ms2Mode MS2 acquisition mode, 'ida' or 'dia', the default value is 'ida'
#' @param diaMethod If MS2 acquisition mode is "dia", a file save dia method should be provided.
#' @param MS1MS2DeltaTR Delta retention time between MS1 and MS2.
#' @param MS1MS2DeltaMZ Delta m/z between MS1 and MS2.
#' @param MS2DeltaMZ Delta m/z between experimental MS2 and reference MS2.
#' @param scoreMode The MS2 score mode, default is "average".
#' @param cores The number of CPU cores when computing.
#'
#' @return annotationFromPeakTableRes
#' @export annotationFromPeakTable.parallel
#' @import foreach
#' @importFrom doSNOW registerDoSNOW
#' @importFrom snow makeSOCKcluster stopCluster
#' @importFrom openxlsx write.xlsx
#' @importFrom progress progress_bar
#' @importFrom stats na.omit
#' @importFrom utils read.csv
#'
#' @examples
#' annotationFromPeakTableRes <- annotationFromPeakTable.parallel(
#'      peakTable = system.file("extdata/peakTable","example.csv", package = "MetEx"),
#'      mgfFile = system.file("extdata/mgf","example.mgf", package = "MetEx"),
#'      database = system.file("extdata/database","MetEx_MSMLS.xlsx", package = "MetEx"),
#'      ionMode = "P",
#'      MS1DeltaMZ = 0.01,
#'      MS1DeltaTR = 120,
#'      MS1MS2DeltaTR = 5,
#'      MS1MS2DeltaMZ = 0.01,
#'      MS2DeltaMZ = 0.02,
#'      cores = 4)
annotationFromPeakTable.parallel <- function(peakTable,
                                    mgfFile,
                                    database,
                                    ionMode,
                                    CE = 'all',
                                    tRCalibration = F,
                                    is.tR.file = NA,
                                    MS1DeltaMZ,
                                    MS1DeltaTR,
                                    MS2.sn.threshold = 3,
                                    MS2.noise.intensity = "minimum",
                                    MS2.missing.value.padding = "minimal.value",
                                    ms2Mode = 'ida',
                                    diaMethod = 'NA',
                                    MS1MS2DeltaTR,
                                    MS1MS2DeltaMZ,
                                    MS2DeltaMZ,
                                    scoreMode = 'average',
                                    cores = 1){
  # require("openxlsx")
  # require("dplyr")
  # require("tcltk")
  # require("doSNOW")
  # require("progress")

  # cores <- parallel::detectCores()
  cl <- makeSOCKcluster(cores)
  registerDoSNOW(cl)

  MS1RawData <- read.csv(file = peakTable)
  if (length(which(colnames(MS1RawData)=='tr')) >= 1){
    message('Row names of MS1 file is Available.')
  } else if (length(which(colnames(MS1RawData)=='tr')) == 0 & length(which(colnames(MS1RawData)=='rt')) >= 1){
    colnames(MS1RawData)[which(colnames(MS1RawData)=='rt')] = 'tr'
    message('Change rt to tr in row names of MS1.')
  } else {
    message('Row names of MS1 file is wrong!')
  }

  mgfList <- importMgf(mgfFile)
  mgfMatrix <- mgfList$mgfMatrix
  mgfData <- mgfList$mgfData
  mzinmgf <- as.matrix(mgfMatrix[ , 'pepmassNum'])
  trinmgf <- as.matrix(mgfMatrix[ , 'trNum'])
  dbData <- dbImporter(dbFile=database, ionMode = ionMode, CE = CE)
  if (tRCalibration == T){
    dbData <- retentionTimeCalibration(is.tR.file = is.tR.file, database.df = dbData)
  }

  # progress bar ------------------------------------------------------------
  iterations <- nrow(MS1RawData)
  pb <- progress_bar$new(
    format = ":letter [:bar] :elapsed | Remaining time: :eta <br>",
    total = iterations,
    width = 120)
  # allowing progress bar to be used in foreach -----------------------------
  progress <- function(n){
    pb$tick(tokens = list(letter = "Progress of annotation based on peak detection."))
  }
  opts <- list(progress = progress)

  i <- NULL
  func <- function(i){
    df.annotationFromPeakTable <- data.frame(MSMS.Exp = c(NA), MSMS.DB = c(NA), confidence_level = c(NA), ID = c(NA), Name = c(NA),
                                             Formula = c(NA), ExactMass = c(NA), SMILES = c(NA), InChIKey = c(NA), ionMode = c(NA),
                                             Adduct = c(NA), mzInDB = c(NA), trInDB = c(NA), CE = c(NA),
                                             DP = c(NA), RDP = c(NA), frag.ratio = c(NA), score = c(NA))
    annotationFromPeakTable.i <- cbind(MS1RawData[i,],df.annotationFromPeakTable)

    mz.MS1.i <- MS1RawData$mz[i]
    tr.MS1.i <- MS1RawData$tr[i]
    ms2ActInRaw <- ms1ms2Match(mz = mz.MS1.i,
                               tr = tr.MS1.i,
                               ms1DeltaMZ = MS1MS2DeltaMZ,
                               deltaTR = MS1MS2DeltaTR,
                               mgfMatrix,
                               mgfData,
                               ms2Mode,
                               diaMethod)
    match.posi <- which(abs(dbData$`m/z` - mz.MS1.i) < MS1DeltaMZ & abs(dbData$tr - tr.MS1.i) < MS1DeltaTR)

    if (length(ms2ActInRaw) == 0 & length(match.posi) == 0){
      annotationFromPeakTable.i$MSMS.Exp <- NA
      annotationFromPeakTable.i$MSMS.DB <- NA
      annotationFromPeakTable.i$confidence_level <- NA
      annotationFromPeakTable.i$ID <- NA
      annotationFromPeakTable.i$Name <- NA
      annotationFromPeakTable.i$Formula <- NA
      annotationFromPeakTable.i$ExactMass <- NA
      annotationFromPeakTable.i$SMILES <- NA
      annotationFromPeakTable.i$InChIKey <- NA
      annotationFromPeakTable.i$Adduct <- NA
      annotationFromPeakTable.i$mzInDB <- NA
      annotationFromPeakTable.i$trInDB <- NA
      annotationFromPeakTable.i$CE <- NA
      annotationFromPeakTable.i$DP <- NA
      annotationFromPeakTable.i$RDP <- NA
      annotationFromPeakTable.i$frag.ratio <- NA
      annotationFromPeakTable.i$score <- NA
    }
    else if (length(ms2ActInRaw) == 0 & length(match.posi) != 0){
      order.num <- order(abs(dbData$`m/z`[match.posi]-mz.MS1.i)/MS1DeltaMZ * 0.6 + abs(dbData$tr[match.posi]-tr.MS1.i)/MS1DeltaTR * 0.4, decreasing = F)
      annotationFromPeakTable.i$MSMS.Exp <- "Can't find MS2"
      annotationFromPeakTable.i$MSMS.DB <- as.character(paste(dbData$MSMS[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$confidence_level <- NA
      annotationFromPeakTable.i$ID <- as.character(paste(dbData$ID.DB[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$Name <- as.character(paste(dbData$Name[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$Formula <- as.character(paste(dbData$Formula[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$ExactMass <- as.character(paste(dbData$ExactMass[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$SMILES <- as.character(paste(dbData$SMILES[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$InChIKey <- as.character(paste(dbData$InChIKey[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$Adduct <- as.character(paste(dbData$Adduct[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$mzInDB <- as.character(paste(dbData$`m/z`[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$trInDB <- as.character(paste(dbData$tr[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$CE <- as.character(paste(dbData$CE[match.posi[order.num]],collapse = " * "))
      annotationFromPeakTable.i$DP <- NA
      annotationFromPeakTable.i$RDP <- NA
      annotationFromPeakTable.i$frag.ratio <- NA
      annotationFromPeakTable.i$score <- NA
    }
    else if (length(ms2ActInRaw) != 0 & length(match.posi) == 0){
      ms2ActInRaw.temp <- vector(mode="character",length = length(ms2ActInRaw))
      for (ms2ActInRaw.i in c(1:length(ms2ActInRaw))){
        ms2ActInRaw.temp[ms2ActInRaw.i] <- paste(ms2ActInRaw[[ms2ActInRaw.i]], collapse = ";")
      }
      annotationFromPeakTable.i$MSMS.Exp <- paste(ms2ActInRaw.temp, collapse = " * ")
      annotationFromPeakTable.i$MSMS.DB <- NA
      annotationFromPeakTable.i$confidence_level <- NA
      annotationFromPeakTable.i$ID <- NA
      annotationFromPeakTable.i$Name <- NA
      annotationFromPeakTable.i$Formula <- NA
      annotationFromPeakTable.i$ExactMass <- NA
      annotationFromPeakTable.i$SMILES <- NA
      annotationFromPeakTable.i$InChIKey <- NA
      annotationFromPeakTable.i$Adduct <- NA
      annotationFromPeakTable.i$mzInDB <- NA
      annotationFromPeakTable.i$trInDB <- NA
      annotationFromPeakTable.i$CE <- NA
      annotationFromPeakTable.i$DP <- NA
      annotationFromPeakTable.i$RDP <- NA
      annotationFromPeakTable.i$frag.ratio <- NA
      annotationFromPeakTable.i$score <- NA
    }
    else if (length(ms2ActInRaw) != 0 & length(match.posi) != 0){
      candidateMSMS.Exp <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateMSMS.DB <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateconfidence_level <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateID <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateName <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateFormula <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateExactMass <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateSMILES <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateInChIKey <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateAdduct <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidatemzInDB <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidatetrInDB <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateCE <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateDP <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidateRDP <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidatefrag.ratio <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))
      candidatescore <- matrix(NA, nrow = length(ms2ActInRaw), ncol = length(match.posi))

      for (k in c(1:length(ms2ActInRaw))){
        ms2Act <- ms2ActInRaw[[k]]
        ms2Act <- strsplit(ms2Act, " ", fixed=TRUE)
        ms2Act <- list2dataframe(ms2Act)
        ms2Act <- na.omit(ms2Act)
        ms2Act <- ms2Act[which(ms2Act[,1] < (mz.MS1.i+MS2DeltaMZ)),]

        for (j in c(1:length(match.posi))){
          ms2DB <- as.character(dbData$MSMS[match.posi[j]])
          ms2DB <- strsplit(ms2DB, ";", fixed=TRUE)
          ms2DB <- strsplit(unlist(ms2DB), " ", fixed=TRUE)
          ms2DB <- list2dataframe(ms2DB)
          ms2DB <- na.omit(ms2DB)
          ms2DB <- ms2DB[which(ms2DB[,1] < (ms2DB+MS2DeltaMZ)),]
          if (nrow(ms2Act)==0){
            candidateMSMS.Exp[k,j] <- "Can't find MS2"
            candidateMSMS.DB[k,j] <- dbData$MSMS[match.posi[j]]
            candidateconfidence_level[k,j] <- dbData$confidence_level[match.posi[j]]
            candidateID[k,j] <- dbData$ID[match.posi[j]]
            candidateName[k,j] <- dbData$Name[match.posi[j]]
            candidateFormula[k,j] <- dbData$Formula[match.posi[j]]
            candidateExactMass[k,j] <- dbData$ExactMass[match.posi[j]]
            candidateSMILES[k,j] <- dbData$SMILES[match.posi[j]]
            candidateInChIKey[k,j] <- dbData$InChIKey[match.posi[j]]
            candidateAdduct[k,j] <- dbData$Adduct[match.posi[j]]
            candidatemzInDB[k,j] <- dbData$`m/z`[match.posi[j]]
            candidatetrInDB[k,j] <- dbData$tr[match.posi[j]]
            candidateCE[k,j] <- dbData$CE[match.posi[j]]
            candidateDP[k,j] <- NA
            candidateRDP[k,j] <- NA
            candidatefrag.ratio[k,j] <- NA
            candidatescore[k,j] <- NA
          }
          else{
            candidatescore[k,j] <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode)
            candidateDP[k,j] <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "obverse")
            candidateRDP[k,j] <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "reverse")
            candidatefrag.ratio[k,j] <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "matched.fragments.ratio")

            candidateMSMS.Exp[k,j] <- paste(ms2ActInRaw[[k]],collapse=";")
            candidateMSMS.DB[k,j] <- dbData$MSMS[match.posi[j]]
            candidateconfidence_level[k,j] <- dbData$confidence_level[match.posi[j]]
            candidateID[k,j] <- dbData$ID[match.posi[j]]
            candidateName[k,j] <- dbData$Name[match.posi[j]]
            candidateFormula[k,j] <- dbData$Formula[match.posi[j]]
            candidateExactMass[k,j] <- dbData$ExactMass[match.posi[j]]
            candidateSMILES[k,j] <- dbData$SMILES[match.posi[j]]
            candidateInChIKey[k,j] <- dbData$InChIKey[match.posi[j]]
            candidateAdduct[k,j] <- dbData$Adduct[match.posi[j]]
            candidatemzInDB[k,j] <- dbData$`m/z`[match.posi[j]]
            candidatetrInDB[k,j] <- dbData$tr[match.posi[j]]
            candidateCE[k,j] <- dbData$CE[match.posi[j]]
          }
        }
      }

      order.num <- order(candidatescore,decreasing = T)
      annotationFromPeakTable.i$MSMS.Exp <- paste(candidateMSMS.Exp[order.num],collapse = " * ")
      annotationFromPeakTable.i$MSMS.DB <- paste(candidateMSMS.DB[order.num],collapse = " * ")
      annotationFromPeakTable.i$confidence_level <- paste(candidateconfidence_level[order.num],collapse = " * ")
      annotationFromPeakTable.i$ID <- paste(candidateID[order.num],collapse = " * ")
      annotationFromPeakTable.i$Name <- paste(candidateName[order.num],collapse = " * ")
      annotationFromPeakTable.i$Formula <- paste(candidateFormula[order.num],collapse = " * ")
      annotationFromPeakTable.i$ExactMass <- paste(candidateExactMass[order.num],collapse = " * ")
      annotationFromPeakTable.i$SMILES <- paste(candidateSMILES[order.num],collapse = " * ")
      annotationFromPeakTable.i$InChIKey <- paste(candidateInChIKey[order.num],collapse = " * ")
      annotationFromPeakTable.i$Adduct <- paste(candidateAdduct[order.num],collapse = " * ")
      annotationFromPeakTable.i$mzInDB <- paste(candidatemzInDB[order.num],collapse = " * ")
      annotationFromPeakTable.i$trInDB <- paste(candidatetrInDB[order.num],collapse = " * ")
      annotationFromPeakTable.i$CE <- paste(candidateCE[order.num],collapse = " * ")
      annotationFromPeakTable.i$DP <- paste(candidateDP[order.num],collapse = " * ")
      annotationFromPeakTable.i$RDP <- paste(candidateRDP[order.num],collapse = " * ")
      annotationFromPeakTable.i$frag.ratio <- paste(candidatefrag.ratio[order.num],collapse = " * ")
      annotationFromPeakTable.i$score <- paste(candidatescore[order.num],collapse = " * ")
    }
    return(annotationFromPeakTable.i)
  }

  annotationFromPeakTable.result.all <- foreach(i=1:nrow(MS1RawData), .options.snow=opts, .combine='rbind') %dopar% func(i)
  stopCluster(cl)

  candidate2dataframe <- function(in.vector){
    if (all(is.na(in.vector))){
      candidateDataframe <- data.frame(col1 = NA, col2 = NA, col3 = NA, col4 = NA, col5 = NA)
      # candidateDataframe <- candidateDataframe[-1, ]
      for (i in c(1:length(in.vector))) {
        candidateDataframe[i, "col1"] <- NA
        candidateDataframe[i, "col2"] <- NA
        candidateDataframe[i, "col3"] <- NA
        candidateDataframe[i, "col4"] <- NA
        candidateDataframe[i, "col5"] <- NA
      }
    }
    else {
      candidateList <- strsplit(in.vector, " * ", fixed=TRUE)
      candidateDataframe <- data.frame(col1 = NA, col2 = NA, col3 = NA, col4 = NA, col5 = NA)
      # candidateDataframe <- candidateDataframe[-1, ]
      for (i in c(1:length(candidateList))) {
        candidateDataframe[i, "col1"] <- candidateList[[i]][1]
        candidateDataframe[i, "col2"] <- candidateList[[i]][2]
        candidateDataframe[i, "col3"] <- candidateList[[i]][3]
        candidateDataframe[i, "col4"] <- candidateList[[i]][4]
        candidateDataframe[i, "col5"] <- candidateList[[i]][5]
      }
    }
    return(candidateDataframe)
  }

  annotationFromPeakTableRes1 <- cbind(MS1RawData,
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.Exp)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.DB)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$confidence_level)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ID)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Name)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Formula)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ExactMass)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$SMILES)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$InChIKey)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Adduct)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$mzInDB)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$trInDB)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$CE)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$DP)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$RDP)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$frag.ratio)[,1],
                                       candidate2dataframe(annotationFromPeakTable.result.all$score)[,1])
  colnames(annotationFromPeakTableRes1) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes2 <- cbind(MS1RawData,
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.Exp)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.DB)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$confidence_level)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ID)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Name)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Formula)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ExactMass)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$SMILES)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$InChIKey)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Adduct)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$mzInDB)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$trInDB)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$CE)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$DP)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$RDP)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$frag.ratio)[,2],
                                       candidate2dataframe(annotationFromPeakTable.result.all$score)[,2])
  colnames(annotationFromPeakTableRes2) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes3 <- cbind(MS1RawData,
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.Exp)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.DB)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$confidence_level)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ID)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Name)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Formula)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ExactMass)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$SMILES)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$InChIKey)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Adduct)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$mzInDB)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$trInDB)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$CE)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$DP)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$RDP)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$frag.ratio)[,3],
                                       candidate2dataframe(annotationFromPeakTable.result.all$score)[,3])
  colnames(annotationFromPeakTableRes3) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes4 <- cbind(MS1RawData,
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.Exp)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.DB)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$confidence_level)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ID)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Name)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Formula)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ExactMass)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$SMILES)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$InChIKey)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Adduct)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$mzInDB)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$trInDB)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$CE)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$DP)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$RDP)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$frag.ratio)[,4],
                                       candidate2dataframe(annotationFromPeakTable.result.all$score)[,4])
  colnames(annotationFromPeakTableRes4) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes5 <- cbind(MS1RawData,
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.Exp)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$MSMS.DB)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$confidence_level)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ID)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Name)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Formula)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$ExactMass)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$SMILES)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$InChIKey)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$Adduct)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$mzInDB)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$trInDB)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$CE)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$DP)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$RDP)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$frag.ratio)[,5],
                                       candidate2dataframe(annotationFromPeakTable.result.all$score)[,5])
  colnames(annotationFromPeakTableRes5) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes.list <- list(candidate.1 = annotationFromPeakTableRes1,
                                          candidate.2 = annotationFromPeakTableRes2,
                                          candidate.3 = annotationFromPeakTableRes3,
                                          candidate.4 = annotationFromPeakTableRes4,
                                          candidate.5 = annotationFromPeakTableRes5)
  # write.xlsx(annotationFromPeakTableRes.list, file = result.file)
  return(annotationFromPeakTableRes.list)
}
