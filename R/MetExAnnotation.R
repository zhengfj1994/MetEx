#' Title
#' Annotate metabolites by MetEx in one line.
#'
#' @param dbFile The file path of database.
#' @param ionMode The ion mode of experiment, "P" or "N".
#' @param CE Collision energy, the default value is "all".
#' @param tRCalibration Whether to perform retention time calibration.
#' @param is.tR.file If retention time calibration is performed, the retention time of IS saved in xlsx should be imported.
#' @param msRawData The file path of mzXML file.
#' @param MS1deltaMZ Tolerance of MS1.
#' @param MS1deltaTR Tolerance of retention time between experiment and database.
#' @param trRange
#' @param m
#' @param entroThre The information entropy threshold.
#' @param intThre The peak height threshold.
#' @param classficationMethod The classficatioin method of true signals and noises, "NoSVM" or "SVM" is avilable and "NoSVM" is the default value.
#' @param mgfFile The file path of mgfFile.
#' @param MS1MS2DeltaMZ The tolerance of MS between MS1 and MS2.
#' @param MS1MS2DeltaTR The tolerance of retention time between MS1 and MS2.
#' @param MS2DeltaMZ The tolerance of MS between experiment MS2 and database MS2.
#' @param NeedCleanSpectra T
#' @param MS2NoiseRemoval 0.01
#' @param onlyKeepMax T
#' @param minScore 0.5
#' @param KeepNotMatched T
#' @param MS2scoreFilter The threshold of MS2 score.
#' @param cores The CPU cores used for parallel computation.
#'
#' @return MetExAnnotationRes
#' @export MetExAnnotation
#' @importFrom utils write.table
#'
MetExAnnotation <- function(dbFile,
                            ionMode,
                            CE = "all",
                            tRCalibration = F,
                            is.tR.file = NA,
                            msRawData,
                            MS1deltaMZ,
                            MS1deltaTR,
                            trRange = 30,
                            m = 200,
                            entroThre,
                            intThre,
                            classficationMethod = "NoSVM",
                            mgfFilePath,
                            MS1MS2DeltaMZ,
                            MS1MS2DeltaTR,
                            MS2DeltaMZ,
                            NeedCleanSpectra = T,
                            MS2NoiseRemoval = 0.01,
                            onlyKeepMax = T,
                            minScore = 0,
                            KeepNotMatched = T,
                            MS2scoreFilter = 0,
                            cores = 1){

  dbData <- dbImporter(dbFile = dbFile,
                       ionMode = ionMode,
                       CE = CE)
  if (tRCalibration == T){
    dbData <- retentionTimeCalibration(is.tR.file = is.tR.file,
                                       database.df = dbData)
  }
  targExtracRes <- targetExtraction.optimized(msRawData = msRawData,
                                              dbData,
                                              deltaMZ = MS1deltaMZ,
                                              deltaTR = MS1deltaTR,
                                              trRange = trRange,
                                              m = m)
  ms1Info <- extracResFilter(targExtracRes,
                             entroThre = entroThre,
                             intThre = intThre,
                             classficationMethod = classficationMethod)
  batchMS2ScoreResult <- batchMS2Score.optimized(ms1Info,
                                                 MS1MS2DeltaMZ = MS1MS2DeltaMZ,
                                                 MS1MS2DeltaTR = MS1MS2DeltaTR,
                                                 mgfFilePath = mgfFilePath,
                                                 MS2DeltaMZ = MS2DeltaMZ,
                                                 NeedCleanSpectra,
                                                 MS2NoiseRemoval,
                                                 onlyKeepMax,
                                                 minScore=minScore,
                                                 KeepNotMatched,
                                                 cores = cores)
  MetExAnnotationRes <- identifiedResFilter(batchMS2ScoreResult = batchMS2ScoreResult$batchMS2ScoreResult,
                                            MS2score = MS2scoreFilter)
  return(MetExAnnotationRes)
}
