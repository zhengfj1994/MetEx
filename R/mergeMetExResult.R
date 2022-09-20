#' Title mergeMetExResult
#'
#' @param resultPath MetEx results path
#'
#' @return resultList
#' @export mergeMetExResult
#' @importFrom purrr map_dfr
#' @importFrom data.table as.data.table

mergeMetExResult <- function(resultPath){
  require(purrr)
  require(openxlsx)
  require(data.table)
  # get all xlsx Files
  resultFiles <- list.files(resultPath, full.names = T, pattern = ".xlsx")
  # If there is already a merged result file, ignore it
  resultFiles <- resultFiles[!grepl("_mergedMetExResult.xlsx", resultFiles)]
  # Read and combine sheet1
  read.xlsx.sheet1 <- function(xlsxFile){return(openxlsx::read.xlsx(xlsxFile, sheet = 1))}
  MergedSheet1 = purrr::map_dfr(set_names(resultFiles), read.xlsx.sheet1, .id = "FileName")
  MergedSheet1$FileName <- gsub("\\.xlsx", "", do.call("rbind", strsplit(MergedSheet1$FileName, split = "/"))[,ncol(do.call("rbind", strsplit(MergedSheet1$FileName, split = "/")))])
  # Read and combine sheet4
  read.xlsx.sheet4 <- function(xlsxFile){return(openxlsx::read.xlsx(xlsxFile, sheet = 4))}
  MergedSheet4 = purrr::map_dfr(set_names(resultFiles), read.xlsx.sheet4, .id = "FileName")
  MergedSheet4$FileName <- gsub("\\.xlsx", "", do.call("rbind", strsplit(MergedSheet4$FileName, split = "/"))[,ncol(do.call("rbind", strsplit(MergedSheet4$FileName, split = "/")))])
  MergedSheet4 <- data.table::as.data.table(MergedSheet4)
  uniqueMergedSheet4 <- MergedSheet4[MergedSheet4[, .I[which.max(MS2_similarity)], by=c("ID")]$V1]
  uniqueMergedSheet4 <- uniqueMergedSheet4[,-c("trOfPeak", "peakHeight", "peakArea", "entropy", "MatchedMS2ID")]

  sampleMatrix <- as.data.frame(matrix(data = NA, nrow = nrow(uniqueMergedSheet4), ncol = length(gsub("\\.xlsx", "", do.call("rbind", strsplit(resultFiles, split = "/"))[,ncol(do.call("rbind", strsplit(resultFiles, split = "/")))]))))
  colnames(sampleMatrix) <- gsub("\\.xlsx", "", do.call("rbind", strsplit(resultFiles, split = "/"))[,ncol(do.call("rbind", strsplit(resultFiles, split = "/")))])
  resultMatrix <- cbind(uniqueMergedSheet4, sampleMatrix)

  rtMatrix <- resultMatrix
  phMatrix <- resultMatrix
  paMatrix <- resultMatrix
  eyMatrix <- resultMatrix

  for (ithRow in c(1:nrow(resultMatrix))){
    matchedID <- which(MergedSheet1$ID == resultMatrix$ID[ithRow])
    matchedFileNames <- MergedSheet1$FileName[matchedID]
    for (ithFileName in colnames(sampleMatrix)){
      matchedFileNameID <- which(matchedFileNames == ithFileName)
      if (length(matchedFileNameID) == 0){
        next()
      }
      else if (length(matchedFileNameID) == 1){
        rtMatrix[[ithFileName]][ithRow] <- MergedSheet1$trOfPeak[matchedID][matchedFileNameID]
        phMatrix[[ithFileName]][ithRow] <- MergedSheet1$peakHeight[matchedID][matchedFileNameID]
        paMatrix[[ithFileName]][ithRow] <- MergedSheet1$peakArea[matchedID][matchedFileNameID]
        eyMatrix[[ithFileName]][ithRow] <- MergedSheet1$entropy[matchedID][matchedFileNameID]
      }
      else {
        rtMatrix[[ithFileName]][ithRow] <- paste(MergedSheet1$trOfPeak[matchedID][matchedFileNameID], collapse = " ")
        phMatrix[[ithFileName]][ithRow] <- paste(MergedSheet1$peakHeight[matchedID][matchedFileNameID], collapse = " ")
        paMatrix[[ithFileName]][ithRow] <- paste(MergedSheet1$peakArea[matchedID][matchedFileNameID], collapse = " ")
        eyMatrix[[ithFileName]][ithRow] <- paste(MergedSheet1$entropy[matchedID][matchedFileNameID], collapse = " ")
      }
    }
  }

  for (ithRow in c(1:nrow(resultMatrix))){
    tempVector <- na.omit(unlist(rtMatrix[ithRow, (ncol(resultMatrix)-length(colnames(sampleMatrix))+1):ncol(resultMatrix)]))
    tempVector <- as.numeric(tempVector[!grepl(" ", tempVector)])
    for (ithFileName in colnames(sampleMatrix)){
      if(grepl(" ",rtMatrix[[ithFileName]][ithRow])){
        candidates <- as.numeric(unlist(strsplit(rtMatrix[[ithFileName]][ithRow], split = " ")))
        if (length(tempVector) == 0){
          selectedID <- 1
        }
        else {
          selectedID <- which.min(abs(candidates - mean(tempVector)))
        }
        rtMatrix[[ithFileName]][ithRow] <- candidates[selectedID]
        phMatrix[[ithFileName]][ithRow] <- as.numeric(unlist(strsplit(phMatrix[[ithFileName]][ithRow], split = " ")))[selectedID]
        eyMatrix[[ithFileName]][ithRow] <- as.numeric(unlist(strsplit(eyMatrix[[ithFileName]][ithRow], split = " ")))[selectedID]
      }
    }
  }

  for (ithFileName in colnames(sampleMatrix)){
    rtMatrix[[ithFileName]] <- as.numeric(rtMatrix[[ithFileName]])
    phMatrix[[ithFileName]] <- as.numeric(phMatrix[[ithFileName]])
    eyMatrix[[ithFileName]] <- as.numeric(eyMatrix[[ithFileName]])
  }

  rtMatrix <- rtMatrix[,-1]
  phMatrix <- phMatrix[,-1]
  eyMatrix <- eyMatrix[,-1]
  resultList <- list(peakHeight = phMatrix,
                     retentionTime = rtMatrix,
                     # peakArea = paMatrix,
                     entropy = eyMatrix)
  openxlsx::write.xlsx(resultList, file = paste0(resultPath, "/",gsub(":","",Sys.time()),"_mergedMetExResult.xlsx"))
  return(resultList)
}
