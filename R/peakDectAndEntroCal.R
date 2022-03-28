#' Title
#' Use EIC data to do peak detection and calculate entropy of each peaks within a retention time range.
#'
#' @param eicData, a matrix containing EIC data, the first column is rt (retention time) and the second column is intensity.
#' @param trRange retention time range for extraction.
#' @param m parameter of peak detection.
#'
#' @importFrom stats na.omit
#' @import dplyr
#' @return extractedPeaks
#' @export peakDectAndEntroCal
#'
#' @examples
#' load(system.file("extdata/testData", "eicDataTest.rda", package = "MetEx"))
#' extractedPeaks <- peakDectAndEntroCal(eicData = eicDataTest, trRange=20)
#' @references
#' Ju R, Liu X, Zheng F, et al. Removal of False Positive Features to Generate Authentic Peak Table for High-resolution Mass Spectrometry-based Metabolomics Study[J]. Analytica Chimica Acta, 2019.

peakDectAndEntroCal <- function(eicData,
                                trRange,
                                m = 200){
  # require(dplyr)
  extractedPeaks <- as.data.frame(peakDetection(eicData,m))
  if (nrow(extractedPeaks)==0){
    maxTRandEntropy <- entropyCalculator(eicData)
    extractedPeaks[1,]=NA
    extractedPeaks$trOfPeak[1] <- maxTRandEntropy[,'maxTR']
    # fitted_curve <- fitCurve(eicData[,1], eicData[,2], curveModel='emgGaussian', params='guess')
    # pred_y  <- predictCurve(fitted_curve, eicData[,1])
    # plot(eicData)
    # lines(x = eicData[,1], y = pred_y, col = "red")

    extractedPeaks$peakHeight[1] <- max(eicData[,2])
    # extractedPeaks$peakArea[1] <- areaIntegrator(l1 = list(x = eicData[,1]), l2 = list(y = pred_y), left = eicData[1,1], right = eicData[nrow(eicData),1], integrationType = "simpson", baselineType = "base_to_base", fitEMG = F, baseSubtraction = T)
    extractedPeaks$peakArea[1] <- NA
    if (max(eicData[,2]) != 0){
      extractedPeaks$entropy[1] <- entropyCalculator(eicData[which(eicData[,1] > (extractedPeaks$trOfPeak[1]-trRange/2) & eicData[,1] < (extractedPeaks$trOfPeak[1]+trRange/2)),])[,'entropyScore']
    }
    else {
      extractedPeaks$entropy[1] <- NA
    }

  }
  else if (nrow(extractedPeaks)==1){
    # fitted_curve <- fitCurve(eicData[,1], eicData[,2], curveModel='emgGaussian', params='guess')
    # pred_y  <- predictCurve(fitted_curve, eicData[,1])
    # plot(eicData)
    # lines(x = eicData[,1], y = pred_y, col = "red")
    # extractedPeaks$peakArea[1] <- areaIntegrator(l1 = list(x = eicData[,1]), l2 = list(y = pred_y), left = eicData[1,1], right = eicData[nrow(eicData),1], integrationType = "simpson", baselineType = "base_to_base", fitEMG = F, baseSubtraction = T)
    extractedPeaks$peakArea[1] <- NA

    maxTRandEntropy <- entropyCalculator(eicData[which(eicData[,1] > (extractedPeaks$trOfPeak[1]-trRange/2) & eicData[,1] < (extractedPeaks$trOfPeak[1]+trRange/2)),])
    extractedPeaks$entropy[1] <- maxTRandEntropy[,'entropyScore']
  }
  else{
    for (i in c(1:nrow(extractedPeaks))){
      # fitted_curve <- fitCurve(eicData[,1], eicData[,2], curveModel='emgGaussian', params='guess')
      # pred_y  <- predictCurve(fitted_curve, eicData[,1])
      # plot(eicData)
      # lines(x = eicData[,1], y = pred_y, col = "red")
      # extractedPeaks$peakArea[i] <- areaIntegrator(l1 = list(x = eicData[,1]), l2 = list(y = pred_y), left = eicData[1,1], right = eicData[nrow(eicData),1], integrationType = "simpson", baselineType = "base_to_base", fitEMG = F, baseSubtraction = T)
      extractedPeaks$peakArea[i] <- NA

      maxTRandEntropy <- entropyCalculator(eicData[which(eicData[,1] > (extractedPeaks$trOfPeak[i]-trRange/2) & eicData[,1] < (extractedPeaks$trOfPeak[i]+trRange/2)),])
      extractedPeaks$entropy[i] <- maxTRandEntropy[,'entropyScore']
    }
  }
  return(extractedPeaks)
}

