#' Title ClassicalAnnotation
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
#' @param MS1MS2DeltaTR Delta retention time between MS1 and MS2.
#' @param MS1MS2DeltaMZ Delta m/z between MS1 and MS2.
#' @param MS2DeltaMZ Delta m/z between experimental MS2 and reference MS2.
#' @param NeedCleanSpectra T
#' @param MS2NoiseRemoval 0.01
#' @param onlyKeepMax T
#' @param minScore 0.5
#' @param KeepNotMatched T
#' @param cores The number of CPU cores when computing.
#'
#' @return ClassicalAnnotationRes
#' @export ClassicalAnnotation
#' @import foreach
#' @importFrom doSNOW registerDoSNOW
#' @importFrom snow makeSOCKcluster stopCluster
#' @importFrom openxlsx write.xlsx
#' @importFrom progress progress_bar
#' @importFrom stats na.omit
#' @importFrom utils read.csv

ClassicalAnnotation <- function(peakTable,
                                mgfFilePath,
                                database,
                                ionMode,
                                CE = 'all',
                                tRCalibration = F,
                                is.tR.file = NA,
                                MS1DeltaMZ,
                                MS1DeltaTR,
                                MS1MS2DeltaTR,
                                MS1MS2DeltaMZ,
                                MS2DeltaMZ,
                                NeedCleanSpectra = T,
                                MS2NoiseRemoval = 0.01,
                                onlyKeepMax = T,
                                minScore = 0.5,
                                KeepNotMatched = T,
                                cores = 1){
  require(openxlsx)
  require(dplyr)
  require(tcltk)
  require(doSNOW)
  require(progress)

  ## Define mgfReader function for reading mgf files
  mgfReader <- function(mgfFile){
    mgfFileContent <- read.csv2(file = mgfFile, header = F)
    beginIndex <- which(mgfFileContent == "BEGIN IONS")
    endIndex <- which(mgfFileContent == "END IONS")
    RTIndex <- which(grepl("RTINSECONDS=",mgfFileContent$V1))
    pepmassIndex <- which(grepl("PEPMASS=",mgfFileContent$V1))
    mgfMatrix <- as.data.frame(matrix(data = NA, nrow = length(beginIndex), ncol = 4))
    colnames(mgfMatrix) <- c("FileName", "RT", "PEPMASS", "MSMS")
    mgfMatrix$FileName <- unlist(strsplit(rev(unlist(strsplit(mgfFile, split = "/")))[1], split = ".mgf"))[1]
    for (i in c(1:length(beginIndex))){
      mgfMatrix$RT[i] <- strsplit(mgfFileContent$V1[RTIndex[i]], split = "=")[[1]][2]
      mgfMatrix$PEPMASS[i] <- strsplit(strsplit(mgfFileContent$V1[pepmassIndex[i]], split = "=")[[1]][2], split = " ")[[1]][1]

      ithMSMS <- mgfFileContent$V1[(beginIndex[i]):(endIndex[i])]
      ithMSMS <- ithMSMS[!grepl("[a-zA-Z]", ithMSMS)]
      if (length(ithMSMS) == 0){
        mgfMatrix$MSMS[i] <- NA
      } else {
        if (length(unlist(strsplit(ithMSMS[1], split = " "))) == 2){
          ithMSMS <- strsplit(ithMSMS, split = " ")
          ithMSMS <- data.frame(matrix(unlist(ithMSMS), byrow = T, ncol = 2), stringsAsFactors = F)
          colnames(ithMSMS) <- c("mz", "intensity")
          ithMSMS$mz <- as.numeric(ithMSMS$mz)
          ithMSMS$intensity <- as.numeric(ithMSMS$intensity)
          ithMSMS <- ithMSMS[which(ithMSMS$intensity/max(ithMSMS$intensity) > 0.005),]
          mgfMatrix$MSMS[i] <- paste(paste(ithMSMS$mz,ithMSMS$intensity, sep = " "), collapse = ";")
        } else if (length(unlist(strsplit(ithMSMS[1], split = " "))) == 3){
          ithMSMS <- strsplit(ithMSMS, split = " ")
          ithMSMS <- data.frame(matrix(unlist(ithMSMS), byrow = T, ncol = 3), stringsAsFactors = F)
          colnames(ithMSMS) <- c("mz", "intensity", "charge")
          ithMSMS$mz <- as.numeric(ithMSMS$mz)
          ithMSMS$intensity <- as.numeric(ithMSMS$intensity)
          ithMSMS <- ithMSMS[which(ithMSMS$intensity/max(ithMSMS$intensity) > 0.005),]
          mgfMatrix$MSMS[i] <- paste(paste(ithMSMS$mz,ithMSMS$intensity, sep = " "), collapse = ";")
        } else {
          packageStartupMessage("The format of mgf is wrong!")
        }
      }
      # if (beginIndex[i] + 4 == endIndex[i]){
      #   mgfMatrix$MSMS[i] <- NA
      # }
      # else {
      #   ithMSMS <- mgfFileContent$V1[(beginIndex[i] + 4):(endIndex[i] - 1)]
      #   ithMSMS <- strsplit(ithMSMS, split = " ")
      #   ithMSMS <- data.frame(matrix(unlist(ithMSMS), byrow = T, ncol = 2), stringsAsFactors = F)
      #   colnames(ithMSMS) <- c("mz", "intensity")
      #   ithMSMS$intensity <- as.numeric(ithMSMS$intensity)
      #   ithMSMS <- ithMSMS[which(ithMSMS$intensity/max(ithMSMS$intensity) > 0.005),]
      #   mgfMatrix$MSMS[i] <- paste(paste(ithMSMS$mz,ithMSMS$intensity, sep = " "), collapse = ";")
      # }
    }
    mgfMatrix <- mgfMatrix[which(!is.na(mgfMatrix$MSMS) & mgfMatrix$MSMS != ""),]
    return(mgfMatrix)
  }
  ## Define MS1MS2Match function
  MS1MS2Match <- function(ithRow){
    mz <- MS1RawData$mz[ithRow]
    rt <- MS1RawData$tr[ithRow]
    matchedMgfRowID <- which(abs(as.numeric(mgfMatrix$PEPMASS) - mz) < MS1MS2DeltaMZ &
                               abs(as.numeric(mgfMatrix$RT) - rt) < MS1MS2DeltaTR)
    return(paste(matchedMgfRowID, collapse = " "))
  }
  ## Define database search function
  SearchDatabase <- function(ithRow){
    mz <- MS1RawData$mz[ithRow]
    rt <- MS1RawData$tr[ithRow]
    matchedDBRowID <- which(abs(as.numeric(dbData$`m/z`) - mz) < MS1DeltaMZ &
                              abs(as.numeric(dbData$tr) - rt) < MS1DeltaTR)
    return(paste(matchedDBRowID, collapse = " "))
  }
  ## Define MS2ScoreFunction
  MS2ScoreFunction <- function(ithRow, onlyKeepMax = T,
                               minScore = 0.5, KeepNotMatched = T){
    ## Get the matched MS2 ID and matched database ID
    MatchedMS2ID <- MS1RawData$MatchedMS2ID[ithRow]
    MatchedDBID <- MS1RawData$MatchedDBID[ithRow]
    MatchedMS2ID <- as.numeric(unlist(strsplit(MatchedMS2ID, split = " ")))
    MatchedDBID <- as.numeric(unlist(strsplit(MatchedDBID, split = " ")))
    ## If there are no matched MS2 or matched database, output none
    if (length(MatchedMS2ID) == 0 | length(MatchedDBID) == 0){
      ## Create a data.frame to save the MS2 score result
      MS2ScoreResult <- as.data.frame(matrix(data = NA, nrow = 1, ncol = 3))
      colnames(MS2ScoreResult) <- c("MS2_file_name","MSMS_in_file","MS2_similarity")
      ## Create the final result
      MS2ScoreFunctionResult <- cbind(MS1RawData[0,],MS2ScoreResult[0,],dbData[0,])
      ## If you want to keep the result which have no matched result
      if (KeepNotMatched){
        MS2ScoreFunctionResult[1,c(1:ncol(MS1RawData))] <- MS1RawData[ithRow,]
      }
    } else{ ## If there are  matched MS2 and matched database
      ## Get the MS2 in mgf and MS2 in database
      MS2inMgf <- mgfMatrix$MSMS[MatchedMS2ID]
      MS2inDB <- dbData$MSMS[MatchedDBID]
      ## Create a matrix to save the MS2 score result
      MS2ScoreMatrix <- matrix(data = NA, nrow = length(MS2inMgf), ncol = length(MS2inDB))
      ## MS2 score
      for (ithMS2inMgf in c(1:length(MS2inMgf))){
        for (ithMS2inDB in c(1:length(MS2inDB))){
          spec_query <- as.data.frame(do.call("rbind", strsplit(unlist(strsplit(MS2inMgf[ithMS2inMgf], split = ";")), split = " ")))
          colnames(spec_query) <- c("mz", "intensity")
          spec_query <- as.data.frame(lapply(spec_query,as.numeric))
          spec_reference <- as.data.frame(do.call("rbind", strsplit(unlist(strsplit(MS2inDB[ithMS2inDB], split = ";")), split = " ")))
          colnames(spec_reference) <- c("mz", "intensity")
          spec_reference <- as.data.frame(lapply(spec_reference,as.numeric))
          # spec_matched = tools.match_peaks_in_spectra(spec_a=spec_query,
          #                                             spec_b=spec_reference,
          #                                             ms2_ppm=NA, ms2_da=0.01)
          # print(spec_matched)
          MS2score <- MetEx::ms2ScoreSpectralEntropy(spec_query = spec_query,
                                              spec_reference = spec_reference,
                                              ms2_da = MS2DeltaMZ,
                                              need_clean_spectra = NeedCleanSpectra,
                                              noise_removal = MS2NoiseRemoval)
          MS2ScoreMatrix[ithMS2inMgf,ithMS2inDB] <- MS2score
        }
      }
      if (onlyKeepMax){ ## If you want to only keep the result with the max score
        ## Find the row and column ID of the max score
        MaxRowAndColID <- which(MS2ScoreMatrix == max(MS2ScoreMatrix),arr.ind=TRUE)
        MatchedRowID <- MaxRowAndColID[,1]
        MatchedColID <- MaxRowAndColID[,2]

        ## Create a data.frame to save the MS2 score result
        MS2ScoreResult <- as.data.frame(matrix(data = NA, nrow = nrow(MaxRowAndColID), ncol = 3))
        colnames(MS2ScoreResult) <- c("MS2_file_name","MSMS_in_file","MS2_similarity")

        ## Write the result to the MS2 score result
        MS2ScoreResult$MS2_file_name <- mgfMatrix$FileName[MatchedMS2ID[MatchedRowID]]
        MS2ScoreResult$MSMS_in_file <- mgfMatrix$MSMS[MatchedMS2ID[MatchedRowID]]
        MS2ScoreResult$MS2_similarity <- MS2ScoreMatrix[MaxRowAndColID]
        ## Create the final result
        MS2ScoreFunctionResult <- cbind(MS1RawData[ithRow,],MS2ScoreResult,dbData[MatchedDBID[MatchedColID],])
      } else { ## If you want to keep the result bigger than a min score
        ## Reshape the MS2 score matrix
        reshapedMS2ScoreMatrix <- data.frame(idrow = rep(c(1:nrow(MS2ScoreMatrix)),
                                                         ncol(MS2ScoreMatrix)),
                                             idcol = rep(c(1:ncol(MS2ScoreMatrix)),
                                                         each = nrow(MS2ScoreMatrix)),
                                             value = as.vector(as.matrix(MS2ScoreMatrix)))
        ## Order the reshaped MS2 score matrix by score
        reshapedMS2ScoreMatrix <- reshapedMS2ScoreMatrix[order(reshapedMS2ScoreMatrix$value, decreasing = T),]
        ## Only keep the result bigger than min score
        reshapedMS2ScoreMatrix <- reshapedMS2ScoreMatrix[which(reshapedMS2ScoreMatrix$value >= minScore),]
        if (nrow(reshapedMS2ScoreMatrix) == 0){ ## If there are no result bigger than min score
          ## Create a data.frame to save the MS2 score result
          MS2ScoreResult <- as.data.frame(matrix(data = NA, nrow = 1, ncol = 3))
          colnames(MS2ScoreResult) <- c("MS2_file_name","MSMS_in_file","MS2_similarity")
          MS2ScoreFunctionResult <- cbind(MS1RawData[0,],MS2ScoreResult[0,],dbData[0,])
          ## If you want to keep the result which have no matched result
          if (KeepNotMatched){
            MS2ScoreFunctionResult[1,c(1:ncol(MS1RawData))] <- MS1RawData[ithRow,]
          }
        } else {
          ## Create a data.frame to save the MS2 score result
          MS2ScoreResult <- as.data.frame(matrix(data = NA, nrow = nrow(reshapedMS2ScoreMatrix), ncol = 3))
          colnames(MS2ScoreResult) <- c("MS2_file_name","MSMS_in_file","MS2_similarity")
          MatchedRowID <- reshapedMS2ScoreMatrix[,1]
          MatchedColID <- reshapedMS2ScoreMatrix[,2]

          ## Write the result to the data.frame
          MS2ScoreResult$MS2_file_name <- mgfMatrix$FileName[MatchedMS2ID[MatchedRowID]]
          MS2ScoreResult$MSMS_in_file <- mgfMatrix$MSMS[MatchedMS2ID[MatchedRowID]]
          MS2ScoreResult$MS2_similarity <- reshapedMS2ScoreMatrix$value
          ## Create the final result
          MS2ScoreFunctionResult <- cbind(MS1RawData[rep(ithRow,nrow(reshapedMS2ScoreMatrix)),],MS2ScoreResult,dbData[MatchedDBID[MatchedColID],])
        }
      }
    }
    return(MS2ScoreFunctionResult)
  }

  ## Read the peak table and check the row names.
  MS1RawData <- read.csv(file = peakTable)
  if (length(which(colnames(MS1RawData)=='tr')) >= 1){
    message('Row names of MS1 file is Available.')
  } else if (length(which(colnames(MS1RawData)=='tr')) == 0 & length(which(colnames(MS1RawData)=='rt')) >= 1){
    colnames(MS1RawData)[which(colnames(MS1RawData)=='rt')] = 'tr'
    message('Change rt to tr in row names of MS1.')
  } else {
    message('Row names of MS1 file is wrong!')
  }

  ## Get the file path of all mgf files
  mgfFiles <- list.files(mgfFilePath, pattern = "mgf", recursive = T, full.names = T)
  ## Read mgf files and save them in mgfMatrix
  cl <- makeSOCKcluster(cores)
  registerDoSNOW(cl)
  # progress bar ------------------------------------------------------------
  iterations <- length(mgfFiles)
  pb <- progress_bar$new(
    format = ":letter [:bar] :elapsed | Remaining time: :eta <br>",
    total = iterations,
    width = 120)
  # allowing progress bar to be used in foreach -----------------------------
  progress <- function(n){
    pb$tick(tokens = list(letter = "Progress of reading mgf files."))
  }
  opts <- list(progress = progress)
  ## Read mgf files
  mgfMatrix <- foreach(i=mgfFiles, .options.snow=opts, .combine='rbind') %dopar% mgfReader(i)

  # progress bar ------------------------------------------------------------
  iterations <- nrow(MS1RawData)
  pb <- progress_bar$new(
    format = ":letter [:bar] :elapsed | Remaining time: :eta <br>",
    total = iterations,
    width = 120)
  # allowing progress bar to be used in foreach -----------------------------
  progress <- function(n){
    pb$tick(tokens = list(letter = "Progress of matching MS2 to MS1 peak table."))
  }
  opts <- list(progress = progress)
  ## Match MS1 and MS2
  MS1MS2MatchResult <- foreach(i=1:nrow(MS1RawData), .options.snow=opts, .combine='rbind') %dopar% MS1MS2Match(i)

  MS1MS2MatchResult <- as.data.frame(MS1MS2MatchResult)
  colnames(MS1MS2MatchResult) <- "MatchedMS2ID"
  MS1RawData <- cbind(MS1RawData, MS1MS2MatchResult)

  ## import database
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
    pb$tick(tokens = list(letter = "Progress of searching database."))
  }
  opts <- list(progress = progress)
  ## Search database using MS1 and retention time
  SearchDatabaseResult <- foreach(i=1:nrow(MS1RawData), .options.snow=opts, .combine='rbind') %dopar% SearchDatabase(i)

  SearchDatabaseResult <- as.data.frame(SearchDatabaseResult)
  colnames(SearchDatabaseResult) <- "MatchedDBID"
  MS1RawData <- cbind(MS1RawData, SearchDatabaseResult)

  # progress bar ------------------------------------------------------------
  iterations <- nrow(MS1RawData)
  pb <- progress_bar$new(
    format = ":letter [:bar] :elapsed | Remaining time: :eta <br>",
    total = iterations,
    width = 120)
  # allowing progress bar to be used in foreach -----------------------------
  progress <- function(n){
    pb$tick(tokens = list(letter = "Progress of classical annotation."))
  }
  opts <- list(progress = progress)
  ## MS2 score
  ClassicalAnnotationResult <- foreach(i=1:nrow(MS1RawData), .options.snow=opts, .combine='rbind') %dopar% MS2ScoreFunction(i, onlyKeepMax = onlyKeepMax, minScore = minScore, KeepNotMatched = KeepNotMatched)
  stopCluster(cl)
  # ClassicalAnnotationResult[,!colnames(ClassicalAnnotationResult) %in% c("MatchedMS2ID","MatchedDBID")]
  resultList <- list(mgfMatrix = mgfMatrix,
                     ClassicalAnnotationResult = ClassicalAnnotationResult)
  return(resultList)
}

# peakTable <- system.file("extdata/peakTable","example.csv", package = "MetEx")
# mgfFilePath <- "F:/Maotai/Food Chemistry/Data Processing/2. Convert to mgf/Positive mode/Wuliangye"
# database <- "F:/Database/xlsx for MetEx/Chinese Baijiu Database_MetExDB_MetEx.xlsx"
# ionMode <- "P"
# CE <- "all"
# cores = 4
# MS1DeltaMZ = 1
# MS1DeltaTR = 60
# MS1MS2DeltaTR = 12
# MS1MS2DeltaMZ = 0.01
# MS2DeltaMZ = 0.01
#
# results <- ClassicalAnnotation(peakTable,
#                     mgfFilePath,
#                     database,
#                     ionMode,
#                     CE = 'all',
#                     tRCalibration = F,
#                     is.tR.file = NA,
#                     MS1DeltaMZ,
#                     MS1DeltaTR,
#                     MS1MS2DeltaTR,
#                     MS1MS2DeltaMZ,
#                     MS2DeltaMZ,
#                     cores = 4)
