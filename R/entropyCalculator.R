#' Title
#' Use EIC data to calculate entropy and the position (retention time) of max intensity.
#'
#' @param eicData a matrix containing EIC data, the first column is rt (retention time) and the second column is intensity.
#'
#' @return maxTRandEntropy
#' @export entropyCalculator
#'
#' @examples
#' load(system.file("extdata/testData", "eicDataTest.rda", package = "MetEx"))
#' maxTRandEntropy <- entropyCalculator(eicDataTest)
#' @references
#' Ju R, Liu X, Zheng F, et al. Removal of False Positive Features to Generate Authentic Peak Table for High-resolution Mass Spectrometry-based Metabolomics Study[J]. Analytica Chimica Acta, 2019.
entropyCalculator <- function(eicData){

  maxInt <- max(eicData[,2])
  if (maxInt == 0){
    entropyScore <- 100
    maxTR <- 'None'
  }
  else{
    maxIntIndex <- which.max(eicData[,2])
    maxTR <- eicData[maxIntIndex,1]
    dataPeakSheak <- matrix(c(0,0),nrow = 1)
    dataAdded <- matrix(c(0,0),nrow = 1)
    nrowEicData <- nrow(eicData)
    numSheak <- 0
    if (maxIntIndex != 1 & maxIntIndex != nrowEicData){
      for (i in c(2:maxIntIndex)){
        if (eicData[i,2]-eicData[i-1,2] < 0){
          numSheak <- numSheak+1
          dataAdded[1,1] <- i
          dataAdded[1,2] <- abs(eicData[i,2]-eicData[i-1,2])
          dataPeakSheak <- rbind(dataPeakSheak,dataAdded)
        }
      }
      numSheak <- numSheak+1
      dataAdded[1,1] <- maxIntIndex
      dataAdded[1,2] <- max(eicData[,2])
      dataPeakSheak <- rbind(dataPeakSheak,dataAdded)

      for (i in c((maxIntIndex+1):nrowEicData)){
        if (eicData[i,2]-eicData[i-1,2] > 0){
          numSheak <- numSheak + 1
          dataAdded[1,1] <- i
          dataAdded[1,2] <- abs(eicData[i,2]-eicData[i-1,2])
          dataPeakSheak <- rbind(dataPeakSheak,dataAdded)
        }
      }
    }
    else if(maxIntIndex == 1){
      for (i in c((maxIntIndex+1):nrowEicData)){
        numSheak <- numSheak+1
        dataAdded[1,1] <- maxIntIndex
        dataAdded[1,2] <- max(eicData[,2])
        dataPeakSheak <- rbind(dataPeakSheak,dataAdded)
        if (eicData[i,2]-eicData[i-1,2] > 0){
          numSheak <- numSheak + 1
          dataAdded[1,1] <- i
          dataAdded[1,2] <- abs(eicData[i,2]-eicData[i-1,2])
          dataPeakSheak <- rbind(dataPeakSheak,dataAdded)
        }
      }
    }
    else if(maxIntIndex == nrowEicData){
      for (i in c(2:maxIntIndex)){
        if (eicData[i,2]-eicData[i-1,2] < 0){
          numSheak <- numSheak+1
          dataAdded[1,1] <- i
          dataAdded[1,2] <- abs(eicData[i,2]-eicData[i-1,2])
          dataPeakSheak <- rbind(dataPeakSheak,dataAdded)
        }
      }
      numSheak <- numSheak+1
      dataAdded[1,1] <- maxIntIndex
      dataAdded[1,2] <- max(eicData[,2])
      dataPeakSheak <- rbind(dataPeakSheak,dataAdded)
    }
    dataPeakSheak <- dataPeakSheak[-1,]

    entropyScore <- intEntropyCalculator(dataPeakSheak)
  }
  maxTRandEntropy <- cbind(maxTR,entropyScore)
  return(maxTRandEntropy)
}
