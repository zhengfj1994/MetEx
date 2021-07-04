#' Title
#' When mz and rt are given, find the matched MSMS.
#'
#' @param mz, m/z
#' @param tr, retention time
#' @param ms1DeltaMZ, the tolerence of m/z
#' @param deltaTR, the tolerence of retention time
#' @param mgfMatrix, a matrix containing the information of mgf
#' @param mgfData, a data containing the information of mgf
#' @param ms2Mode, the mode of MS2 acquisition, ida or dia
#' @param diaMethod, if the ms2Mode is dia, a txt file containing dia method.
#'
#' @return matchedMS2
#' @export ms1ms2Match
#' @importFrom stringr str_detect
#' @importFrom utils read.table
#'
#' @examples
#' load(system.file("extdata/testData", "mgfMatrixTest.rda", package = "MetEx"))
#' load(system.file("extdata/testData", "mgfDataTest.rda", package = "MetEx"))
#' matchedMS2 <- ms1ms2Match(mz = 118.0106,
#'                           tr = 120,
#'                           ms1DeltaMZ = 0.01,
#'                           deltaTR = 12,
#'                           mgfMatrix = mgfMatrixTest,
#'                           mgfData = mgfDataTest,
#'                           ms2Mode = "ida",
#'                           diaMethod = "NA")

ms1ms2Match <- function(mz,
                        tr,
                        ms1DeltaMZ,
                        deltaTR,
                        mgfMatrix,
                        mgfData,
                        ms2Mode,
                        diaMethod = 'NA'){
  # require("stringr")
  # require("dplyr")

  mzinmgf <- as.matrix(mgfMatrix[ , 'pepmassNum'])
  trinmgf <- as.matrix(mgfMatrix[ , 'trNum'])
  if (ms2Mode=='ida'){
    count <- 1
    matchedMS2 <- list()
    for (i in c(1:length(mzinmgf))){
      if (abs(as.numeric(mzinmgf[i])-as.numeric(mz)) < ms1DeltaMZ & abs(as.numeric(trinmgf[i])-as.numeric(tr)) < deltaTR){
        if (str_detect(mgfData[as.numeric(mgfMatrix[i,'beginNum'])+4],"CHARGE=")){
          start_row <- as.numeric(mgfMatrix[i,'beginNum'])+5
        }
        else if (str_detect(mgfData[as.numeric(mgfMatrix[i,'beginNum'])+4]," ")){
          start_row <- as.numeric(mgfMatrix[i,'beginNum'])+4
        }
        else {
          packageStartupMessage("The format of MGF file is wrong!")
          break()
        }
        end_row <- as.numeric(mgfMatrix[i,'endNum'])-1
        if (list(mgfData[start_row:end_row])[[1]][1]=='END IONS'){
          next
        }
        list(mgfData[start_row:end_row]) -> matchedMS2[count]
        count <- count+1
      }
    }
    return(matchedMS2)
  } # When mz and rt are given, find the matched ms2
  else if (ms2Mode=='dia'){
    diaMethodmatrix <- read.table(diaMethod)
    count <- 1
    matchedMS2 <- list()
    for (i in c(1:length(mzinmgf))){
      v2posi <- which(diaMethodmatrix$V2>mz)[1]
      v1posi <- which(diaMethodmatrix$V1>mz)[1]
      if (is.na(v1posi) & v2posi == nrow(diaMethodmatrix)){
        v1posi <- v2posi+1
      }

      if ((v1posi-v2posi) == 1){
        mzAverage <- (diaMethodmatrix$V1[v2posi]+diaMethodmatrix$V2[v2posi])/2
        if (as.numeric(mzAverage) == as.numeric(mzinmgf[i]) & abs(as.numeric(trinmgf[i])-as.numeric(tr)) < deltaTR){
          start_row <- as.numeric(mgfMatrix[i,'beginNum'])+4
          end_row <- as.numeric(mgfMatrix[i,'endNum'])-1
          if (list(mgfData[start_row:end_row])[[1]][1]=='END IONS'){
            next
          }
          list(mgfData[start_row:end_row]) -> matchedMS2[count]
          count <- count+1
        }
      }
      else{
        mzAverage <- (diaMethodmatrix$V1[v2posi+1]+diaMethodmatrix$V2[v2posi+1])/2
        if (as.numeric(mzAverage) == as.numeric(mzinmgf[i]) & abs(as.numeric(trinmgf[i])-as.numeric(tr)) < deltaTR){
          start_row <- as.numeric(mgfMatrix[i,'beginNum'])+4
          end_row <- as.numeric(mgfMatrix[i,'endNum'])-1
          if (list(mgfData[start_row:end_row])[[1]][1]=='END IONS'){
            next
          }
          list(mgfData[start_row:end_row]) -> matchedMS2[count]

        }
      }
    }
    return(matchedMS2)
  }
}

