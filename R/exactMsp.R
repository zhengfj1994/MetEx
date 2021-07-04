#' Title
#' exactMsp
#'
#' @param mspData the msp data.
#'
#' @return mspDataframe
#' @export exactMsp
#' @importFrom tcltk tkProgressBar setTkProgressBar
#' @importFrom xcms do_findPeaks_MSW
#' @importFrom tidyr unite
#' @import stringr
#'
#' @examples
#' load(system.file("extdata/testData", "mspDataTest.rda", package = "MetEx"))
#' mspDataframe <- exactMsp(mspDataTest)
exactMsp <- function(mspData){
  # require("xcms")
  # require("stringr")
  # require("tidyr")
  # require("tcltk")

  mspData.df <- data.frame()
  pb <- tkProgressBar("exactMSP","Rate of progress %", 0, 100)
  for (i in c(1:length(mspData))){
    info<- sprintf("Rate of progress %d%%", round(i*100/length(mspData)))
    setTkProgressBar(pb, i*100/length(mspData), sprintf("exactMSP (%s)", info),info)
    if (!is.null(mspData[[i]]$Name)){
      mspData.df[i,'Name'] <- mspData[[i]]$Name}
    if (!is.null(mspData[[i]]$Synon)){
      mspData.df[i,'Synon'] <- mspData[[i]]$Synon}
    if (!is.null(mspData[[i]]$DB)){
      mspData.df[i,'DB'] <- mspData[[i]]$DB}
    if (!is.null(mspData[[i]]$InChIKey)){
      mspData.df[i,'InChIKey'] <- mspData[[i]]$InChIKey}
    if (!is.null(mspData[[i]]$Precursor_type)){
      mspData.df[i,'Precursor_type'] <- mspData[[i]]$Precursor_type}
    if (!is.null(mspData[[i]]$Spectrum_type)){
      mspData.df[i,'Spectrum_type'] <- mspData[[i]]$Spectrum_type}
    if (!is.null(mspData[[i]]$PrecursorMZ)){
      mspData.df[i,'PrecursorMZ'] <- mspData[[i]]$PrecursorMZ}
    if (!is.null(mspData[[i]]$Instrument_type)){
      mspData.df[i,'Instrument_type'] <- mspData[[i]]$Instrument_type}
    if (!is.null(mspData[[i]]$Instrument)){
      mspData.df[i,'Instrument'] <- mspData[[i]]$Instrument}
    if (!is.null(mspData[[i]]$Ion_mode)){
      mspData.df[i,'Ion_mode'] <- mspData[[i]]$Ion_mode}
    if (!is.null(mspData[[i]]$Collision_energy)){
      mspData.df[i,'Collision_energy'] <- mspData[[i]]$Collision_energy}
    if (!is.null(mspData[[i]]$Formula)){
      mspData.df[i,'Formula'] <- mspData[[i]]$Formula}
    if (!is.null(mspData[[i]]$MW)){
      mspData.df[i,'MW'] <- mspData[[i]]$MW}
    if (!is.null(mspData[[i]]$ExactMass)){
      mspData.df[i,'ExactMass'] <- mspData[[i]]$ExactMass}

    # mspData.df[i,'Comment'] <- mspData[[i]]$Comment
    commenti <- strsplit(mspData[[i]]$Comment, split = '\\" \"', fixed = FALSE)[[1]]
    SMILES.posi <- which(str_detect(commenti,"SMILES") & !str_detect(commenti," SMILES"))
    if (length(SMILES.posi) == 1){
      mspData.df[i,'SMILES'] <- strsplit(commenti[SMILES.posi], split = 'SMILES=', fixed = FALSE)[[1]][2]}
    cas.posi <- which(str_detect(commenti,"cas"))
    if (length(cas.posi) == 1){
      mspData.df[i,'cas'] <- strsplit(commenti[cas.posi], split = 'cas=', fixed = FALSE)[[1]][2]}
    chebi.posi <- which(str_detect(commenti,"chebi"))
    if (length(chebi.posi) == 1){
      mspData.df[i,'chebi'] <- strsplit(commenti[chebi.posi], split = 'chebi=', fixed = FALSE)[[1]][2]}
    kegg.posi <- which(str_detect(commenti,"kegg"))
    if (length(kegg.posi) == 1){
      mspData.df[i,'kegg'] <- strsplit(commenti[kegg.posi], split = 'kegg=', fixed = FALSE)[[1]][2]}
    lipidmaps.posi <- which(str_detect(commenti,"lipidmaps"))
    if (length(lipidmaps.posi) == 1){
      mspData.df[i,'lipidmaps'] <- strsplit(commenti[lipidmaps.posi], split = 'lipidmaps=', fixed = FALSE)[[1]][2]}
    pubchem.cid.posi <- which(str_detect(commenti,"pubchem cid"))
    if (length(pubchem.cid.posi) == 1){
      mspData.df[i,'pubchem.cid'] <- strsplit(commenti[pubchem.cid.posi], split = 'pubchem cid=', fixed = FALSE)[[1]][2]}
    chemspider.posi <- which(str_detect(commenti,"chemspider"))
    if (length(chemspider.posi) == 1){
      mspData.df[i,'chemspider'] <- strsplit(commenti[chemspider.posi], split = 'chemspider=', fixed = FALSE)[[1]][2]}
    InChI.posi <- which(str_detect(commenti,"InChI"))
    if (length(InChI.posi) == 1){
      mspData.df[i,'InChI'] <- strsplit(commenti[InChI.posi], split = 'InChI=', fixed = FALSE)[[1]][2]}
    computed.SMILES.posi <- which(str_detect(commenti,"computed SMILES"))
    if (length(computed.SMILES.posi) == 1){
      mspData.df[i,'computed.SMILES'] <- strsplit(commenti[computed.SMILES.posi], split = 'computed SMILES=', fixed = FALSE)[[1]][2]}
    computed.InChI.posi <- which(str_detect(commenti,"computed InChI"))
    if (length(computed.InChI.posi) == 1){
      mspData.df[i,'computed.InChI'] <- strsplit(commenti[computed.InChI.posi], split = 'computed InChI=', fixed = FALSE)[[1]][2]}
    accession.posi <- which(str_detect(commenti,"accession"))
    if (length(accession.posi) == 1){
      mspData.df[i,'accession'] <- strsplit(commenti[accession.posi], split = 'accession=', fixed = FALSE)[[1]][2]}
    date.posi <- which(str_detect(commenti,"date"))
    if (length(date.posi) == 1){
      mspData.df[i,'date'] <- strsplit(commenti[date.posi], split = 'date=', fixed = FALSE)[[1]][2]}
    author.posi <- which(str_detect(commenti,"author"))
    if (length(author.posi) == 1){
      mspData.df[i,'author'] <- strsplit(commenti[author.posi], split = 'author=', fixed = FALSE)[[1]][2]}
    license.posi <- which(str_detect(commenti,"license"))
    if (length(license.posi) == 1){
      mspData.df[i,'license'] <- strsplit(commenti[license.posi], split = 'license=', fixed = FALSE)[[1]][2]}
    copyright.posi <- which(str_detect(commenti,"copyright"))
    if (length(copyright.posi) == 1){
      mspData.df[i,'copyright'] <- strsplit(commenti[copyright.posi], split = 'copyright=', fixed = FALSE)[[1]][2]}
    comment.posi <- which(str_detect(commenti,"comment"))
    if (length(copyright.posi) > 0){
      mspData.df[i,'comment'] <- paste(gsub("comment=","",commenti[comment.posi])[1:length(comment.posi)],collapse="; ")}
    exact.mass.posi <- which(str_detect(commenti,"exact mass"))
    if (length(exact.mass.posi) == 1){
      mspData.df[i,'exact.mass'] <- strsplit(commenti[exact.mass.posi], split = 'exact mass=', fixed = FALSE)[[1]][2]}
    ionization.posi <- which(str_detect(commenti,"ionization"))
    if (length(ionization.posi) == 1){
      mspData.df[i,'ionization'] <- strsplit(commenti[ionization.posi], split = 'ionization=', fixed = FALSE)[[1]][2]}
    fragmentation.mode.posi <- which(str_detect(commenti,"fragmentation mode"))
    if (length(fragmentation.mode.posi) == 1){
      mspData.df[i,'fragmentation.mode'] <- strsplit(commenti[fragmentation.mode.posi], split = 'fragmentation mode=', fixed = FALSE)[[1]][2]}
    resolution.posi <- which(str_detect(commenti,"resolution"))
    if (length(resolution.posi) == 1){
      mspData.df[i,'resolution'] <- strsplit(commenti[resolution.posi], split = 'resolution=', fixed = FALSE)[[1]][2]}
    column.posi <- which(str_detect(commenti,"column"))
    if (length(column.posi) == 1){
      mspData.df[i,'column'] <- strsplit(commenti[column.posi], split = 'column=', fixed = FALSE)[[1]][2]}
    flow.gradient.posi <- which(str_detect(commenti,"flow gradient"))
    if (length(flow.gradient.posi) == 1){
      mspData.df[i,'flow.gradient'] <- strsplit(commenti[flow.gradient.posi], split = 'flow gradient=', fixed = FALSE)[[1]][2]}
    flow.rate.posi <- which(str_detect(commenti,"flow rate"))
    if (length(flow.rate.posi) == 1){
      mspData.df[i,'flow.rate'] <- strsplit(commenti[flow.rate.posi], split = 'flow rate=', fixed = FALSE)[[1]][2]}
    retention.time.posi <- which(str_detect(commenti,"retention time"))
    if (length(retention.time.posi) == 1){
      mspData.df[i,'retention.time'] <- strsplit(commenti[retention.time.posi], split = 'retention time=', fixed = FALSE)[[1]][2]}
    SOLVENT.A.posi <- which(str_detect(commenti,"SOLVENT.A"))
    if (length(SOLVENT.A.posi) == 1){
      mspData.df[i,'SOLVENT.A'] <- strsplit(commenti[SOLVENT.A.posi], split = 'SOLVENT A=', fixed = FALSE)[[1]][2]}
    SOLVENT.B.posi <- which(str_detect(commenti,"SOLVENT B"))
    if (length(SOLVENT.B.posi) == 1){
      mspData.df[i,'SOLVENT.B'] <- strsplit(commenti[SOLVENT.B.posi], split = 'SOLVENT B=', fixed = FALSE)[[1]][2]}
    deprofile.posi <- which(str_detect(commenti,"deprofile"))
    if (length(deprofile.posi) == 1){
      mspData.df[i,'deprofile'] <- strsplit(commenti[deprofile.posi], split = 'deprofile=', fixed = FALSE)[[1]][2]}
    recalibrate.posi <- which(str_detect(commenti,"recalibrate"))
    if (length(recalibrate.posi) == 1){
      mspData.df[i,'recalibrate'] <- strsplit(commenti[recalibrate.posi], split = 'recalibrate=', fixed = FALSE)[[1]][2]}
    reanalyze.posi <- which(str_detect(commenti,"reanalyze"))
    if (length(reanalyze.posi) == 1){
      mspData.df[i,'reanalyze'] <- strsplit(commenti[reanalyze.posi], split = 'reanalyze=', fixed = FALSE)[[1]][2]}
    whole.posi <- which(str_detect(commenti,"whole"))
    if (length(whole.posi) == 1){
      mspData.df[i,'whole'] <- strsplit(commenti[whole.posi], split = 'whole=', fixed = FALSE)[[1]][2]}
    computed.mass.accuracy.posi <- which(str_detect(commenti,"computed mass accuracy"))
    if (length(computed.mass.accuracy.posi) == 1){
      mspData.df[i,'computed.mass.accuracy'] <- strsplit(commenti[computed.mass.accuracy.posi], split = 'computed mass accuracy=', fixed = FALSE)[[1]][2]}
    computed.mass.error.posi <- which(str_detect(commenti,"computed mass error"))
    if (length(computed.mass.error.posi) == 1){
      mspData.df[i,'computed.mass.error'] <- strsplit(commenti[computed.mass.error.posi], split = 'computed mass error=', fixed = FALSE)[[1]][2]}
    SPLASH.posi <- which(str_detect(commenti,"SPLASH"))
    if (length(SPLASH.posi) == 1){
      mspData.df[i,'SPLASH'] <- strsplit(commenti[SPLASH.posi], split = 'SPLASH=', fixed = FALSE)[[1]][2]}
    submitter.posi <- which(str_detect(commenti,"submitter"))
    if (length(submitter.posi) == 1){
      mspData.df[i,'submitter'] <- strsplit(commenti[submitter.posi], split = 'submitter=', fixed = FALSE)[[1]][2]}
    MoNA.Rating.posi <- which(str_detect(commenti,"MoNA Rating"))
    if (length(MoNA.Rating.posi) == 1){
      mspData.df[i,'MoNA.Rating'] <- strsplit(commenti[MoNA.Rating.posi], split = 'MoNA Rating=', fixed = FALSE)[[1]][2]}

    pspectrumi <- mspData[[i]]$pspectrum
    #####
    mz <- NULL
    intensity <- NULL
    #####

    if (nrow(pspectrumi)==1){
      mspData_pspectrum <- paste(mspData[[i]]$pspectrum[1],mspData[[i]]$pspectrum[2])
    }else{
      x.inv <- try(do_findPeaks_MSW(mspData[[i]]$pspectrum[,1], mspData[[i]]$pspectrum[,2],snthresh = 3, amp.TH = 0.05), silent=TRUE)
      if ('try-error' %in% class(x.inv)){
        pspectrumi <- mspData[[i]]$pspectrum[mspData[[i]]$pspectrum[,2]!=0,]
      }else{
        do_findpeaks_MSW_pspectrumi <- as.data.frame(do_findPeaks_MSW(mspData[[i]]$pspectrum[,1], mspData[[i]]$pspectrum[,2],snthresh = 3, amp.TH = 0.05))
        pspectrumi = cbind(mz=do_findpeaks_MSW_pspectrumi$mz,intensity=do_findpeaks_MSW_pspectrumi$into)
      }
      if (ncol(as.data.frame(pspectrumi)) != 1){
        pspectrumi <- unite(as.data.frame(pspectrumi), "mz_intensity", mz, intensity, sep = " ", remove = TRUE)
        mspData_pspectrum <- pspectrumi[1,]
        for (j in c(2:nrow(pspectrumi))){
          mspData_pspectrum <- paste0(mspData_pspectrum,";",pspectrumi[j,])
        }
      }
      else {
        mspData_pspectrum <- paste(pspectrumi[1],pspectrumi[2])
      }
    }
    mspData.df[i,'psepctrum'] <- mspData_pspectrum
  }
  close(pb)
  packageStartupMessage("A data.frame of msp data was generated")
  return(mspData.df)
}
