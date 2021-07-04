#' Title annotationFromPeakTable
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
#'
#' @return annotationFromPeakTableRes
#' @export annotationFromPeakTable
#' @importFrom tcltk tkProgressBar setTkProgressBar
#' @importFrom openxlsx write.xlsx
#' @importFrom stats na.omit
#' @importFrom utils read.csv
#'
#' @examples
#' annotationFromPeakTableRes <- annotationFromPeakTable(
#'     peakTable = system.file("extdata/peakTable","example.csv", package = "MetEx"),
#'     mgfFile = system.file("extdata/mgf","example.mgf", package = "MetEx"),
#'     database = system.file("extdata/database","MetExDB_KEGG.xlsx", package = "MetEx"),
#'     ionMode = "P",
#'     MS1DeltaMZ = 0.01,
#'     MS1DeltaTR = 120,
#'     MS1MS2DeltaTR = 5,
#'     MS1MS2DeltaMZ = 0.01,
#'     MS2DeltaMZ = 0.02)
annotationFromPeakTable <- function(peakTable,
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
                                    MS2.missing.value.padding = "half",
                                    ms2Mode = 'ida',
                                    diaMethod = 'NA',
                                    MS1MS2DeltaTR,
                                    MS1MS2DeltaMZ,
                                    MS2DeltaMZ,
                                    scoreMode = 'average'){

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

  MSMS.Exp <- vector(mode="character",length = nrow(MS1RawData))
  MSMS.DB <- vector(mode="character",length = nrow(MS1RawData))
  confidence_level <- vector(mode="character",length = nrow(MS1RawData))
  ID <- vector(mode="character",length = nrow(MS1RawData))
  Name <- vector(mode="character",length = nrow(MS1RawData))
  Formula <- vector(mode="character",length = nrow(MS1RawData))
  ExactMass <- vector(mode="character",length = nrow(MS1RawData))
  SMILES <- vector(mode="character",length = nrow(MS1RawData))
  InChIKey <- vector(mode="character",length = nrow(MS1RawData))
  Adduct <- vector(mode="character",length = nrow(MS1RawData))
  mzInDB <- vector(mode="character",length = nrow(MS1RawData))
  trInDB <- vector(mode="character",length = nrow(MS1RawData))
  CE <- vector(mode="character",length = nrow(MS1RawData))
  DP <- vector(mode="character",length = nrow(MS1RawData))
  RDP <- vector(mode="character",length = nrow(MS1RawData))
  frag.ratio <- vector(mode="character",length = nrow(MS1RawData))
  score <- vector(mode="character",length = nrow(MS1RawData))

  pb <- tkProgressBar("annotationFromPeakTable","Rate of progress %", 0, 100)
  for (i in c(1:nrow(MS1RawData))){
    info<- sprintf("Rate of progress %d%%", round(i*100/nrow(MS1RawData)))
    setTkProgressBar(pb, i*100/nrow(MS1RawData), sprintf("annotationFromPeakTable (%s)", info),info)

    mz.MS1.i <- MS1RawData$mz[i]
    tr.MS1.i <- MS1RawData$tr[i]
    ms2ActInRaw <- ms1ms2Match(mz = mz.MS1.i,
                              tr = tr.MS1.i,
                              MS1MS2DeltaMZ,
                              deltaTR = MS1MS2DeltaTR,
                              mgfMatrix,
                              mgfData,
                              ms2Mode,
                              diaMethod)
    match.posi <- which(abs(dbData$`m/z` - mz.MS1.i) < MS1DeltaMZ & abs(dbData$tr - tr.MS1.i) < MS1DeltaTR)

    if (length(ms2ActInRaw) == 0 & length(match.posi) == 0){
      MSMS.Exp[i] <- NA
      MSMS.DB[i] <- NA
      confidence_level[i] <- NA
      ID[i] <- NA
      Name[i] <- NA
      Formula[i] <- NA
      ExactMass[i] <- NA
      SMILES[i] <- NA
      InChIKey[i] <- NA
      Adduct[i] <- NA
      mzInDB[i] <- NA
      trInDB[i] <- NA
      CE[i] <- NA
      DP[i] <- NA
      RDP[i] <- NA
      frag.ratio[i] <- NA
      score[i] <- NA
    }
    else if (length(ms2ActInRaw) == 0 & length(match.posi) != 0){
      order.num <- order(abs(dbData$`m/z`[match.posi]-mz.MS1.i)/MS1DeltaMZ * 0.6 + abs(dbData$tr[match.posi]-tr.MS1.i)/MS1DeltaTR * 0.4, decreasing = F)

      MSMS.Exp[i] <- "Can't find MS2"
      MSMS.DB[i] <- as.character(paste(dbData$MSMS[match.posi[order.num]],collapse = " * "))
      confidence_level[i] <- as.character(paste(dbData$confidence_level[match.posi[order.num]],collapse = " * "))
      ID[i] <- as.character(paste(dbData$ID[match.posi[order.num]],collapse = " * "))
      Name[i] <- as.character(paste(dbData$Name[match.posi[order.num]],collapse = " * "))
      Formula[i] <- as.character(paste(dbData$Formula[match.posi[order.num]],collapse = " * "))
      ExactMass[i] <- as.character(paste(dbData$ExactMass[match.posi[order.num]],collapse = " * "))
      SMILES[i] <- as.character(paste(dbData$SMILES[match.posi[order.num]],collapse = " * "))
      InChIKey[i] <- as.character(paste(dbData$InChIKey[match.posi[order.num]],collapse = " * "))
      Adduct[i] <- as.character(paste(dbData$Adduct[match.posi[order.num]],collapse = " * "))
      mzInDB[i] <- as.character(paste(dbData$`m/z`[match.posi[order.num]],collapse = " * "))
      trInDB[i] <- as.character(paste(dbData$tr[match.posi[order.num]],collapse = " * "))
      CE[i] <- as.character(paste(dbData$CE[match.posi[order.num]],collapse = " * "))
      DP[i] <- NA
      RDP[i] <- NA
      frag.ratio[i] <- NA
      score[i] <- NA
    }
    else if (length(ms2ActInRaw) != 0 & length(match.posi) == 0){
      ms2ActInRaw.temp <- vector(mode="character",length = length(ms2ActInRaw))
      for (ms2ActInRaw.i in c(1:length(ms2ActInRaw))){
        ms2ActInRaw.temp[ms2ActInRaw.i] <- paste(ms2ActInRaw[[ms2ActInRaw.i]], collapse = ";")
      }

      MSMS.Exp[i] <- paste(ms2ActInRaw.temp, collapse = " * ")
      MSMS.DB[i] <- NA
      confidence_level[i] <- NA
      ID[i] <- NA
      Name[i] <- NA
      Formula[i] <- NA
      ExactMass[i] <- NA
      SMILES[i] <- NA
      InChIKey[i] <- NA
      Adduct[i] <- NA
      mzInDB[i] <- NA
      trInDB[i] <- NA
      CE[i] <- NA
      DP[i] <- NA
      RDP[i] <- NA
      frag.ratio[i] <- NA
      score[i] <- NA
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
            candidateMSMS.Exp <- "Can't find MS2"
            candidateMSMS.DB <- dbData$MSMS[match.posi[j]]
            candidateconfidence_level <- dbData$confidence_level[match.posi[j]]
            candidateID <- dbData$ID[match.posi[j]]
            candidateName <- dbData$Name[match.posi[j]]
            candidateFormula <- dbData$Formula[match.posi[j]]
            candidateExactMass <- dbData$ExactMass[match.posi[j]]
            candidateSMILES <- dbData$SMILES[match.posi[j]]
            candidateInChIKey <- dbData$InChIKey[match.posi[j]]
            candidateAdduct <- dbData$Adduct[match.posi[j]]
            candidatemzInDB <- dbData$`m/z`[match.posi[j]]
            candidatetrInDB <- dbData$tr[match.posi[j]]
            candidateCE <- dbData$CE[match.posi[j]]
            candidateDP <- NA
            candidateRDP <- NA
            candidatefrag.ratio <- NA
            candidatescore <- NA
          }
          else{
            candidateMSMS.Exp <- paste(ms2ActInRaw[[k]],collapse=";")
            candidateMSMS.DB <- dbData$MSMS[match.posi[j]]
            candidateconfidence_level <- dbData$confidence_level[match.posi[j]]
            candidateID <- dbData$ID[match.posi[j]]
            candidateName <- dbData$Name[match.posi[j]]
            candidateFormula <- dbData$Formula[match.posi[j]]
            candidateExactMass <- dbData$ExactMass[match.posi[j]]
            candidateSMILES <- dbData$SMILES[match.posi[j]]
            candidateInChIKey <- dbData$InChIKey[match.posi[j]]
            candidateAdduct <- dbData$Adduct[match.posi[j]]
            candidatemzInDB <- dbData$`m/z`[match.posi[j]]
            candidatetrInDB <- dbData$tr[match.posi[j]]
            candidateCE <- dbData$CE[match.posi[j]]
            candidateDP <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "obverse")
            candidateRDP <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "reverse")
            candidatefrag.ratio <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode = "matched.fragments.ratio")
            candidatescore <- ms2Score(ms2Act, ms2DB, MS2DeltaMZ, sn.threshold = MS2.sn.threshold, noise.intensity = MS2.noise.intensity, missing.value.padding = MS2.missing.value.padding, scoreMode)
          }
        }
      }

      order.num <- order(candidatescore,decreasing = T)

      MSMS.Exp[i] <- paste(candidateMSMS.Exp[order.num],collapse = " * ")
      MSMS.DB[i] <- paste(candidateMSMS.DB[order.num],collapse = " * ")
      confidence_level[i] <- paste(candidateconfidence_level[order.num],collapse = " * ")
      ID[i] <- paste(candidateID[order.num],collapse = " * ")
      Name[i] <- paste(candidateName[order.num],collapse = " * ")
      Formula[i] <- paste(candidateFormula[order.num],collapse = " * ")
      ExactMass[i] <- paste(candidateExactMass[order.num],collapse = " * ")
      SMILES[i] <- paste(candidateSMILES[order.num],collapse = " * ")
      InChIKey[i] <- paste(candidateInChIKey[order.num],collapse = " * ")
      Adduct[i] <- paste(candidateAdduct[order.num],collapse = " * ")
      mzInDB[i] <- paste(candidatemzInDB[order.num],collapse = " * ")
      trInDB[i] <- paste(candidatetrInDB[order.num],collapse = " * ")
      CE[i] <- paste(candidateCE[order.num],collapse = " * ")
      DP[i] <- paste(candidateDP[order.num],collapse = " * ")
      RDP[i] <- paste(candidateRDP[order.num],collapse = " * ")
      frag.ratio[i] <- paste(candidatefrag.ratio[order.num],collapse = " * ")
      score[i] <- paste(candidatescore[order.num],collapse = " * ")
    }
  }
  close(pb)

  candidate2dataframe <- function(in.vector){
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
    return(candidateDataframe)
  }


  annotationFromPeakTableRes1 <- cbind(MS1RawData,
                                       candidate2dataframe(MSMS.Exp)[,1],
                                       candidate2dataframe(MSMS.DB)[,1],
                                       candidate2dataframe(confidence_level)[,1],
                                       candidate2dataframe(ID)[,1],
                                       candidate2dataframe(Name)[,1],
                                       candidate2dataframe(Formula)[,1],
                                       candidate2dataframe(ExactMass)[,1],
                                       candidate2dataframe(SMILES)[,1],
                                       candidate2dataframe(InChIKey)[,1],
                                       candidate2dataframe(Adduct)[,1],
                                       candidate2dataframe(SMILES)[,1],
                                       candidate2dataframe(mzInDB)[,1],
                                       candidate2dataframe(trInDB)[,1],
                                       candidate2dataframe(CE)[,1],
                                       candidate2dataframe(DP)[,1],
                                       candidate2dataframe(RDP)[,1],
                                       candidate2dataframe(frag.ratio)[,1],
                                       candidate2dataframe(score)[,1])
  colnames(annotationFromPeakTableRes1) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes2 <- cbind(MS1RawData,
                                       candidate2dataframe(MSMS.Exp)[,2],
                                       candidate2dataframe(MSMS.DB)[,2],
                                       candidate2dataframe(confidence_level)[,2],
                                       candidate2dataframe(ID)[,2],
                                       candidate2dataframe(Name)[,2],
                                       candidate2dataframe(Formula)[,2],
                                       candidate2dataframe(ExactMass)[,2],
                                       candidate2dataframe(SMILES)[,2],
                                       candidate2dataframe(InChIKey)[,2],
                                       candidate2dataframe(Adduct)[,2],
                                       candidate2dataframe(mzInDB)[,2],
                                       candidate2dataframe(trInDB)[,2],
                                       candidate2dataframe(CE)[,2],
                                       candidate2dataframe(DP)[,2],
                                       candidate2dataframe(RDP)[,2],
                                       candidate2dataframe(frag.ratio)[,2],
                                       candidate2dataframe(score)[,2])
  colnames(annotationFromPeakTableRes2) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes3 <- cbind(MS1RawData,
                                       candidate2dataframe(MSMS.Exp)[,3],
                                       candidate2dataframe(MSMS.DB)[,3],
                                       candidate2dataframe(confidence_level)[,3],
                                       candidate2dataframe(ID)[,3],
                                       candidate2dataframe(Name)[,3],
                                       candidate2dataframe(Formula)[,3],
                                       candidate2dataframe(ExactMass)[,3],
                                       candidate2dataframe(SMILES)[,3],
                                       candidate2dataframe(InChIKey)[,3],
                                       candidate2dataframe(Adduct)[,3],
                                       candidate2dataframe(mzInDB)[,3],
                                       candidate2dataframe(trInDB)[,3],
                                       candidate2dataframe(CE)[,3],
                                       candidate2dataframe(DP)[,3],
                                       candidate2dataframe(RDP)[,3],
                                       candidate2dataframe(frag.ratio)[,3],
                                       candidate2dataframe(score)[,3])
  colnames(annotationFromPeakTableRes3) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes4 <- cbind(MS1RawData,
                                       candidate2dataframe(MSMS.Exp)[,4],
                                       candidate2dataframe(MSMS.DB)[,4],
                                       candidate2dataframe(confidence_level)[,4],
                                       candidate2dataframe(ID)[,4],
                                       candidate2dataframe(Name)[,4],
                                       candidate2dataframe(Formula)[,4],
                                       candidate2dataframe(ExactMass)[,4],
                                       candidate2dataframe(SMILES)[,4],
                                       candidate2dataframe(InChIKey)[,4],
                                       candidate2dataframe(Adduct)[,4],
                                       candidate2dataframe(mzInDB)[,4],
                                       candidate2dataframe(trInDB)[,4],
                                       candidate2dataframe(CE)[,4],
                                       candidate2dataframe(DP)[,4],
                                       candidate2dataframe(RDP)[,4],
                                       candidate2dataframe(frag.ratio)[,4],
                                       candidate2dataframe(score)[,4])
  colnames(annotationFromPeakTableRes4) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes5 <- cbind(MS1RawData,
                                       candidate2dataframe(MSMS.Exp)[,5],
                                       candidate2dataframe(MSMS.DB)[,5],
                                       candidate2dataframe(confidence_level)[,5],
                                       candidate2dataframe(ID)[,5],
                                       candidate2dataframe(Name)[,5],
                                       candidate2dataframe(Formula)[,5],
                                       candidate2dataframe(ExactMass)[,5],
                                       candidate2dataframe(SMILES)[,5],
                                       candidate2dataframe(InChIKey)[,5],
                                       candidate2dataframe(Adduct)[,5],
                                       candidate2dataframe(mzInDB)[,5],
                                       candidate2dataframe(trInDB)[,5],
                                       candidate2dataframe(CE)[,5],
                                       candidate2dataframe(DP)[,5],
                                       candidate2dataframe(RDP)[,5],
                                       candidate2dataframe(frag.ratio)[,5],
                                       candidate2dataframe(score)[,5])
  colnames(annotationFromPeakTableRes5) <- c(colnames(MS1RawData),"MSMS.Exp","MSMS.DB","confidence_level","ID","Name","Formula","ExactMass","SMILES","InChIKey","Adduct","mzInDB","trInDB","CE","DP","RDP","frag.ratio","score")
  annotationFromPeakTableRes.list <- list(candidate.1 = annotationFromPeakTableRes1,
                                          candidate.2 = annotationFromPeakTableRes2,
                                          candidate.3 = annotationFromPeakTableRes3,
                                          candidate.4 = annotationFromPeakTableRes4,
                                          candidate.5 = annotationFromPeakTableRes5)
  # write.xlsx(annotationFromPeakTableRes.list, file = result.file)
  return(annotationFromPeakTableRes.list)
}
