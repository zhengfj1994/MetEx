#' Title
#' Peak Group
#'
#' @param MetExAnnotationResList A list of MetEx annotation
#'
#' @return res.sheet
#' @export peakGroup
#' @importFrom purrr map_dfr
#'

peakGroup <- function(MetExAnnotationResList){
  MetExAnnotationResList

  templist <- list()
  for (i in names(MetExAnnotationResList)){
    templist[[i]] <- MetExAnnotationResList[[i]][[3]]
  }

  library(purrr)
  allData <- map_dfr(set_names(templist), bind_rows, .id = NULL)
  allDataUnique <- distinct(allData, Name, SMILES, mz, tr, .keep_all = TRUE)
  mergeData <- subset(allDataUnique, select = -c(trOfPeak,entropy,peakHeight,peakArea,MS2_similarity,MSMS,MSMS_in_file,MS2_similarity))

  trOfPeak.df <- as.data.frame(mergeData)
  IE.df <- as.data.frame(mergeData)
  PH.df <- as.data.frame(mergeData)
  PA.df <- as.data.frame(mergeData)
  MSMS.score.df <- as.data.frame(mergeData)

  for (i in names(templist)){
    trOfPeak.df[,i] <- NA
    IE.df[,i] <- NA
    PH.df[,i] <- NA
    PA.df[,i] <- NA
    MSMS.score.df[,i] <- NA
  }

  for (i in names(templist)){
    for (j in c(1:nrow(mergeData))){
      x.position <- which(templist[[i]]$Name == mergeData$Name[j] &
                            templist[[i]]$SMILES == mergeData$SMILES[j] &
                            templist[[i]]$mz == mergeData$mz[j] &
                            templist[[i]]$tr == mergeData$tr[j])
      if (length(x.position) == 1){
        trOfPeak.df[j,i] <- templist[[i]]$trOfPeak[x.position]
        IE.df[j,i] <- templist[[i]]$entropy[x.position]
        PH.df[j,i] <- templist[[i]]$peakHeight[x.position]
        PA.df[j,i] <- templist[[i]]$peakArea[x.position]
        MSMS.score.df[j,i] <- templist[[i]]$MS2_similarity[x.position]
      }
    }
  }

  res.sheet <- list(trOfPeak = trOfPeak.df, entropy = IE.df, peakHeight = PH.df, peakArea = PA.df, MSMS.score = MSMS.score.df)
  return(res.sheet)
}





