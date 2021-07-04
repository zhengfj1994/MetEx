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
#' @param entroThre The information entropy threshold.
#' @param intThre The peak height threshold.
#' @param classficationMethod The classficatioin method of true signals and noises, "NoSVM" or "SVM" is avilable and "NoSVM" is the default value.
#' @param mgfFile The file path of mgfFile.
#' @param MS2.sn.threshold The S/N threshold of MS2 spectrum.
#' @param MS2.noise.intensity The intensity of noise of MS2 spectrum.
#' @param MS2.missing.value.padding The missing value padding method of MS2.
#' @param MS1MS2DeltaMZ The tolerance of MS between MS1 and MS2.
#' @param MS2DeltaMZ The tolerance of MS between experiment MS2 and database MS2.
#' @param MS1MS2DeltaTR The tolerance of retention time between MS1 and MS2.
#' @param scoreMode The score mode of MS2, the default value is "average".
#' @param MS2scoreFilter The threshold of MS2 score.
#' @param cores The CPU cores used for parallel computation.
#'
#' @return MetExAnnotationRes
#' @export MetExAnnotation
#' @importFrom utils write.table
#'
#' @examples
#' MetExAnnotationRes <- MetExAnnotation(dbFile = system.file("extdata/database","MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
#'                 ionMode = "P",
#'                 CE = "all",
#'                 msRawData = system.file("extdata/mzXML","example.mzXML", package = "MetEx"),
#'                 MS1deltaMZ = 0.01,
#'                 MS1deltaTR = 60,
#'                 entroThre = 2,
#'                 intThre = 270,
#'                 mgfFile = system.file("extdata/mgf","example.mgf", package = "MetEx"),
#'                 MS1MS2DeltaMZ = 0.01,
#'                 MS2DeltaMZ = 0.02,
#'                 MS1MS2DeltaTR = 12,
#'                 MS2scoreFilter = 0.6)
MetExAnnotation <- function(dbFile,
                            ionMode,
                            CE = "all",
                            tRCalibration = F,
                            is.tR.file = NA,
                            msRawData,
                            MS1deltaMZ,
                            MS1deltaTR,
                            entroThre,
                            intThre,
                            classficationMethod = "NoSVM",
                            mgfFile,
                            MS2.sn.threshold = 3,
                            MS2.noise.intensity = "minimum",
                            MS2.missing.value.padding = "half",
                            MS1MS2DeltaMZ,
                            MS2DeltaMZ,
                            MS1MS2DeltaTR,
                            scoreMode = "average",
                            MS2scoreFilter,
                            cores = 1){

  dbData <- dbImporter(dbFile = dbFile, ionMode = ionMode, CE = CE)
  if (tRCalibration == T){
    dbData <- retentionTimeCalibration(is.tR.file = is.tR.file, database.df = dbData)
  }
  targExtracRes <- targetExtraction.parallel(msRawData = msRawData, dbData, deltaMZ = MS1deltaMZ, deltaTR = MS1deltaTR, cores = cores)
  ms1Info <- extracResFilter(targExtracRes, entroThre = entroThre, intThre = intThre, classficationMethod = classficationMethod)
  mgfList <- importMgf(mgfFile = mgfFile)
  batchMS2ScoreResult <- batchMS2Score.parallel(ms1Info, ms1DeltaMZ = MS1MS2DeltaMZ, ms2DeltaMZ = MS2DeltaMZ, deltaTR = MS1MS2DeltaTR, mgfMatrix = mgfList$mgfMatrix, mgfData = mgfList$mgfData, MS2.sn.threshold = MS2.sn.threshold, MS2.noise.intensity = MS2.noise.intensity, MS2.missing.value.padding = MS2.missing.value.padding, scoreMode = scoreMode, cores = cores)
  # write.table(batchMS2ScoreResult, file = csvFile, col.names = NA, sep = ",", dec = ".", qmethod = "double")
  filteredRes <- identifiedResFilter(batchMS2ScoreResult = batchMS2ScoreResult, MS2score = MS2scoreFilter)
  MetExAnnotationRes <- filteredRes
  return(MetExAnnotationRes)
}
