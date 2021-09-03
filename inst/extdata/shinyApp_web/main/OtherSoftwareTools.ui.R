fluidPage(
  fluidRow(
    div(
      id="mainbody",
      column(img(src = "flower_left.png", align = "center", width = "10%"),
             img(src = "MetEx_icon_2.png", align = "center", width = "35%"),
             img(src = "flower_right.png", align = "center", width = "10%"),
             align = "center", width = 12),
      column(3),
      column(
        width = 12,
        div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
            HTML("~~ <em>Dear Users, Welcome to MetEx</em> ~~")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:150%;margin-top:20px",
            HTML("Here are some introductions and links to other commonly used tools in metabolomics, hope it will be helpful to you."))
      ),
      column(
        width = 12,
        div(style="text-align:left;margin-top:10px;font-size:180%;color:darkred",
           HTML("<em>Data format conversion</em>")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("1. MSConvert in ProteoWizard (<a href='http://proteowizard.sourceforge.net/download.html' target='_blank'>http://proteowizard.sourceforge.net/download.html</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Convert MS raw data such as .raw, .wiff, .d to third-party format such as .mzXML, .mgf, .txt.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("2. AbfConverter (<a href='https://www.reifycs.com/AbfConverter/' target='_blank'>https://www.reifycs.com/AbfConverter/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Reifycs Abf Converter provides MS vender specific raw file format converter for free MS data analysis software such as MS-DIAL and MRMPROBS. "))
      ),
      column(
        width = 12,
        div(style="text-align:left;margin-top:10px;font-size:180%;color:darkred",
            HTML("<em>Peak detection</em>")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("1. XCMS (<a href='http://bioconductor.riken.jp/packages/release/bioc/html/xcms.html' target='_blank'>http://bioconductor.riken.jp/packages/release/bioc/html/xcms.html</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data. Imports from AIA/ANDI NetCDF, mzXML, mzData and mzML files. Preprocesses data for high-throughput, untargeted analyte profiling.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("2. MS-DIAL (<a href='http://prime.psc.riken.jp/compms/msdial/main.html' target='_blank'>http://prime.psc.riken.jp/compms/msdial/main.html</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MS-DIAL was launched as a universal program for untargeted metabolomics that supports multiple instruments (GC/MS, GC/MS/MS, LC/MS, and LC/MS/MS) and MS vendors (Agilent, Bruker, LECO, Sciex, Shimadzu, Thermo, and Waters). ")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("3. MZmine 2 (<a href='http://mzmine.github.io/' target='_blank'>http://mzmine.github.io/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MZmine 2 is an open-source software for mass-spectrometry data processing, with the main focus on LC-MS data. "))
      ),
      column(
        width = 12,
        div(style="text-align:left;margin-top:10px;font-size:180%;color:darkred",
            HTML("<em>Databases</em>")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("1. HMDB (<a href='https://hmdb.ca/' target='_blank'>https://hmdb.ca/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Human Metabolome Database (HMDB) is a freely available electronic database containing detailed information about small molecule metabolites found in the human body. ")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("2. Metlin (<a href='https://metlin.scripps.edu/' target='_blank'>https://metlin.scripps.edu/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;METLIN, a freely accessible web-based data repository, has been developed to assist in a broad array of metabolite research and to facilitate metabolite identification through mass analysis. METLINincludes an annotated list of known metabolite structural information that is easily cross-correlated with its catalogue of high-resolution Fourier transform mass spectrometry (FTMS) spectra, tandem mass spectrometry (MS/MS) spectra, and LC/MS data.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("3. MassBank of North America (MoNA) (<a href='http://mzmine.github.io/' target='_blank'>http://mzmine.github.io/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MassBank of North America (MoNA) is a metadata-centric, auto-curating repository designed for efficient storage and querying of mass spectral records. It intends to serve as a the framework for a centralized, collaborative database of metabolite mass spectra, metadata and associated compounds. MoNA currently contains over 200,000 mass spectral records from experimental and in-silico libraries as well as from user contributions.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("4. GNPS (<a href='https://gnps.ucsd.edu/ProteoSAFe/static/gnps-splash.jsp' target='_blank'>https://gnps.ucsd.edu/ProteoSAFe/static/gnps-splash.jsp/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;GNPS is a web-based mass spectrometry ecosystem that aims to be an open-access knowledge base for community-wide organization and sharing of raw, processed, or annotated fragmentation mass spectrometry data (MS/MS). GNPS aids in identification and discovery throughout the entire life cycle of data; from initial data acquisition/analysis to post publication."))
      ),
      column(
        width = 12,
        div(style="text-align:left;margin-top:10px;font-size:180%;color:darkred",
            HTML("<em>Retention time prediction</em>")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("1. Retip (<a href='https://www.retip.app/' target='_blank'>https://www.retip.app/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Retip is an R package for predicting Retention Time (RT) for small molecules in a high pressure liquid chromatography (HPLC) Mass Spectrometry analysis.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("2. QSRR Automator (<a href='https://github.com/ UofUMetabolomicsCore/QSRR_Automator' target='_blank'>https://github.com/ UofUMetabolomicsCore/QSRR_Automator</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A Tool for Automating Retention Time Prediction in Lipidomics and Metabolomics.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("3. SMRT (<a href='https://doi.org/10.1038/s41467-019-13680-7' target='_blank'>https://doi.org/10.1038/s41467-019-13680-7</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;METLIN small molecule retention time (SMRT) dataset, an experimentally acquired reversephase chromatography retention time dataset covering up to 80,038 small molecules.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("4. GNN-RT (<a href='https://github.com/Qiong-Yang/GNNRT' target='_blank'>https://github.com/Qiong-Yang/GNNRT</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In this study, authors used the graph neural network to predict the retention time (GNN-RT) from structures of small molecules directly without the requirement of molecular descriptors. The predicted accuracy of GNN-RT was compared with random forests (RFs), Bayesian ridge regression, convolutional neural network (CNN), and a deep-learning regression model (DLM) on a METLIN small molecule retention time (SMRT) dataset. GNN-RT achieved the highest predicting accuracy with a mean relative error of 4.9% and a median relative error of 3.2%. Furthermore, the SMRT-trained GNN-RT model can be transferred to the same type of chromatographic systems easily."))
      ),
      column(
        width = 12,
        div(style="text-align:left;margin-top:10px;font-size:180%;color:darkred",
            HTML("<em>In silico MS2 methods</em>")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("1. MAGMa+ (<a href='https://link.springer.com/article/10.1007/s11306-016-1036-3' target='_blank'>https://link.springer.com/article/10.1007/s11306-016-1036-3</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Verdegem, D., Lambrechts, D., Carmeliet, P. & Ghesquière, B. Improved metabolite identification with midas and magma through ms/ms spectral dataset-driven parameter optimization. Metabolomics 12, 98 (2016).")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("2. MassFrontier (<a href='https://link.springer.com/article/10.1007%2Fs00216-010-3608-9' target='_blank'>https://link.springer.com/article/10.1007%2Fs00216-010-3608-9</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MassFrontier is a commercial software that utilizes a large number of fragmentation mechanism rules to predict fragmentation spectra")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("3. MetFrag (<a href='https://pubmed.ncbi.nlm.nih.gov/20307295/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/20307295/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MetFrag is based on weighted peak count and bond dissociation energy to compute matching scores.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("4. MIDAS (<a href='https://pubmed.ncbi.nlm.nih.gov/25157598/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/25157598/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MIDAS takes account of fragment-peak matching errors.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("5. MSFinder (<a href='https://pubmed.ncbi.nlm.nih.gov/27419259/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/27419259/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MSFinder introduces the hydrogen rearrangement rules for fragmentation and scoring.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("6. QCEIMS (<a href='https://pubmed.ncbi.nlm.nih.gov/23630109/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/23630109/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;QCEIMS uses quantum chemical simulation to predict mass spectra.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("7. CFM-ID (<a href='https://link.springer.com/article/10.1007/s11306-014-0676-4' target='_blank'>https://link.springer.com/article/10.1007/s11306-014-0676-4</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CFM-ID applies stochastic Markov process to predict fragmentation spectra.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("8. CSI:FingerID (<a href='https://pubmed.ncbi.nlm.nih.gov/26392543/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/26392543/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;CSI:FingerID predicts a molecular fingerprint based on mass spectra and searches the fingerprint in a molecular database.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("9. ChemDistiller (<a href='https://pubmed.ncbi.nlm.nih.gov/29447341/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/29447341/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ChemDistiller combines both molecular fingerprint and fragmentation information to score the molecule spectrum matches.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("10. DEREPLICATOR+ (<a href='https://pubmed.ncbi.nlm.nih.gov/30279420/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/30279420/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Dereplication of microbial metabolites through database search of mass spectra.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("11. MolDiscovery (<a href='https://pubmed.ncbi.nlm.nih.gov/34140479/' target='_blank'>https://pubmed.ncbi.nlm.nih.gov/34140479/</a>): <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;MolDiscovery: learning mass spectrometry fragmentation of small molecules."))
      )
    )
  )
)


