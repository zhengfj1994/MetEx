<h1 align="center">
MetEx
</h1>

> MetEx is a tool to extract and annotate metabolites from liquid chromatography–mass spectrometry data.

## Introduction
Liquid chromatography–high resolution mass spectrometry (LC-HRMS) is the most popular platform for untargeted metabolomics methods, but annotating LC-HRMS data is a long-standing bottleneck that we are facing since years ago in metabolomics research. A wide variety of methods have been established to deal with the annotation issue. To date, however, there is a scarcity of efficient, systematic, and easy-to-handle tools that are tailored for metabolomics and exposome community. So we developed a user-friendly and powerful software/webserver, MetEx, to both enable implementation of classical peak detection-based annotation and a new annotation method based on targeted extraction algorithms. The new annotation method based on targeted extraction algorithms can annotate more than 2 times metabolites than classical peak detection-based annotation method because it reduces the loss of metabolite signal in the data preprocessing process. MetEx is freely available at http://www.metaboex.cn/MetEx and the source code available at https://github.com/zhengfj1994/MetEx.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Workflow-of-MetEx.png"/></div>
<h4 align="center">
Figure 1. The workflow of MetEx
</h4>

## Installation
1. If you don't have R language, install R first.   
[>> R download here](https://cran.r-project.org/)  
Note: We developed MetEx in R 3.6.3 and we have test it in R 4.0.2. If you find problems when you use other versions, please contact us.  
[>> The old version of R](https://cran.r-project.org/bin/windows/base/old/)
2. We recommended to install Rstudio owing to it is an integrated development environment (IDE) for R.  
[>> Rstudio download here](https://rstudio.com/products/rstudio/)
3. Install the R package "devtools" and other reliable packages, then install MetEx using codes below.
   [>>The devtools package](https://cran.r-project.org/web/packages/devtools/index.html)
   
    ```
   install.packages(c("devtools","BiocManager"))
   BiocManager::install(c("xcms","KEGGREST"),update = TRUE, ask = FALSE)
   devtools::install_github('zhengfj1994/MetEx')
    ```
    It will take few minutes to download the packages.
4. If the third step fails to install, users can download the project and install off line as shown in Figure 2-4:  
<div align=center><img width="600" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Offline-install-1.png"/></div>
<h4 align="center">
Figure 2. Download the MetEx-master.zip from github.
</h4>
​		Then, in Rstudio, choose Packages —— Install:  

<div align=center><img width="600" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Offline-install-2.png"/></div>
<h4 align="center">
Figure 3. Package intallation in Rstudio
</h4>
​		Finally, choose install from Package Archive File (.zip; .tar.gz), and select the MetEx-master.zip, click install.

<div align=center><img width="350" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Offline-install-3.png"/></div>  
<h4 align="center">
Figure 4. Choose the MetEx-master.zip and install.
</h4>
5. Call MetEx to see if the installation was successful.
    ```
    library(MetEx)
    ```



## Dependences

MetEx dependent the following packages, If you find that the installation fails and you are prompted that the following installation package is missing, please manually install the missing packages.
         openxlsx, 
         tcltk, 
         doSNOW,
         stringr, 
         xcms, 
         do, 
         KEGGREST,
         XML,
         progress,
         shinydashboard,
         shinycssloaders,
         shinyjs,
         ggrepel,
         DT,
         dplyr,
         foreach,
         jsonlite,
         snow,
         tidyr,
		 BiocManager,
         knitr,
         shiny,
         ggplot2,
         RColorBrewer

## The uniform database format

- The database is stored in .xlsx file. And the first row is column names. Column names are specific, and using an irregular column name would make the database unrecognizable. The database should containing these columns:
    - Name: the compound name.

    - m/z: the accurate mass in LC-MS

    - tr: the retention time (in second)

    - ionMode: the ion mode of LC-MS, positive ion mode is P and negative ion mode is N.

    - CE: collision energy.

    - MSMS: the MS/MS spectrum. The ion and its intensity are separated by a space (" "), and the ion and the ion are separated by a semicolon (";"). For example: 428.036305927272 0.0201115093588212;524.057195188813 0.0699256604274525;542.065116124274 0.148347272003186;664.112740221342 1 is the abbreviate of MS/MS spectrum below:  

      |       m/z        |     intensity      |
      | :--------------: | :----------------: |
      | 428.036305927272 | 0.0201115093588212 |
      | 524.057195188813 | 0.0699256604274525 |
      | 542.065116124274 | 0.148347272003186  |
      | 664.112740221342 |         1          |

    - Other information is not mandatory, and users can add it as they see fit.  We have gave an example of database in data (Figure 5).

      <div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/example-of-database.png"/></div>  
      <h4 align="center">
      Figure 5. An example of database.
      </h4>

## Supported database
- OSI-SMMS: Our in-house database, containing ~2000 metabolites in positive or negative ion modes, but not open-accessed now.

- MSMLS: Acquired by Mass Spectrometry Metabolite Library (MSMLS) supplied by IROA Technologies. containing ~300 metabolites.

- MoNA: Download from MoNA and transfer it to the format used for MetEx. The retention time is predicted.

  - And we provided the method to transfer the MoNA database (saved in MSP) to the format used for MetEx:

  - ```
    library(MetEx)
    library(openxlsx)
    mspData <- readMsp(file = "D:/MoNA-export-All_Spectra.msp") # The file path should change to yours.
    mspDataframe <- exactMsp(mspData)
    write.xlsx(mspDataframe, file = "D:/MoNA used for MetEx.xlsx") # The file path should change to yours.
    ```

  - The retention time prediction method can be seen in the Part of Retention time prediction.

- KEGG: Download from KEGG and transfer it to the format used for MetEx. The retention time and MS/MS spectrum are predicted.

  - We provided the method to download KEGG and transfer it to the format used for MetEx:

  - ```
    library(MetEx)
    kegg.compound.database.df <- KEGGdownloader()
    write.xlsx(kegg.compound.database.df, file = "D:/KEGG used for MetEx.xlsx") # The file path should change to yours.
    ```

  - The retention time prediction method can be seen in the Part of Retention time prediction.

  - The MS/MS spectrum prediction method can be seen in the Part of MS/MS spectrum prediction. 

- Other databases（Constantly updating ... ...）

- User-defined database: All users can defined their own database by our database format. And we will add more database in MetEx.



## Retention time prediction

1. Molecular descriptor calculation.  [Mordred](https://github.com/mordred-descriptor/mordred) is used to calculate molecular descriptors. And other tools for molecular descriptor calculation are also available.  [Mordred](https://github.com/mordred-descriptor/mordred) have provided some examples to calculate molecular descriptors. And users can also see the example provided in https://github.com/zhengfj1994/Retention-time-prediction-in-MetEx
2. Molecular descriptor processing. 
3. Retention time prediction.



## How to use the Shiny App?

We provided a Shiny App and its screen shot  is shown in Figure 6.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Screen-shot-of-Shiny-App.png"/></div>  
<h4 align="center">
Figure 6. Screen shot of Shiny App.
</h4>

1. Please confirm that you have install the MetEx package in R.

2. Open Rstudio.

3. Enter the following line of code:

   ```
   shiny::runApp(system.file("extdata/shinyApp", "app.R", package = "MetEx"))
   ```

4. A new visualization window is opened.

5. There are four main taps in the left. The first tap is introduction, the second tap is the annotation work flow of a single file by MetEx, the second tap is the annotation work flow of multiple files by MetEx, the fourth work flow is the annotation work flow based on peak detection result. The parameters of several modules are described separately in the next section.

   5.2 The second tap, MetEx (Single file), annotation work flow of a single file by MetEx:

   - Database: A database file that meets MetEx's formatting requirements.

   - Ion mode: The ion mode used for annotation, "positive" or "negative".

   - CE: Collision energy used for MS/MS acquisition, "all", "low", "medium" or "high". Only when the low, medium and high collision energies of the database are 15, 30, 45 eV, the "low", "medium" and "high" options can be used, otherwise, please use the "all" option.

   - Whether to perform tR calibration: "Yes: means the tR prediction will be preformed and you should provide an xlsx for tR prediction. "No" means tR prediction will not be preformed. 

   - tR of internal standards: a xlsx file, which contain the retention time of internal standards in database and experiment. It should be looked like Figure 7. 

     <div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/IS-for-tR-calibration.png"/></div>  
     <h4 align="center">
     Figure 7. The format of the xlsx file storing the retention time of the internal standard.
     </h4>

     Users can also open the file named "IS-for-tR-calibration.xlsx" (inst/extdata/trCalibration) to see the format of the files, but please do not change it.

   - mzXML file: The mzXML file which is transfered from raw LC-MS data (by using MSconvert in proteowizard).

   - mgf file: The mgf file which is transfered from raw LC-MS data (by using MSconvert in proteowizard).

   - Delta m/z of MS1: The tolerance of MS1 between database and experiment (0.01 Da is recommended for Q-TOF and 0.005 Da is recommended for Obitrap).

   - Delta tR of MS1: the tolerance of retention time between database and experiment. The unit is seconds.

   - Entropy threshold: The information entropy threshold, 1.75 - 2 is recommended.

   - Intensity threshold: The peak height threshold. 600-270 is recommended for Q-TOF.

   - Delta m/z of MS1 and MS2: The tolerance between MS1 and MS2 in experiment.

   - Delta m/z of MS2: The tolerance of MS2 between database and experiment.

   - Delta tR of MS1 and MS2: The tolerance of tR between MS1 and MS2

   - MS2 score threshold: The MS2 score threshold (0-1)

   - Result (csv file): The result file path and name (.csv file).

   - Result (xlsx file): The result file path and name (.xlsx file).

   - Number of cores for parallel computing: The number of CPU cores for parallel computing, it is depend on your computer's CPU and RAM. Users can refer to the following rules:

     The number of cores for parallel computing < The number of CPU cores of your computer &

     The number of cores for parallel computing × 4 GB < The RAM of you computer

   - MS2 S/N threshold: The MS2 S/N threshold.

   - MS2 noise intensity: The MS2 noise intensity, "minimum" or a number.

   - MS2 missing value padding method: The MS2 missing value padding method, two options are available, "half" and "minimal". "Half" is referred to MS-DIAL and "minimal" is closer to the actual situation. And now we recommended "minimal".

   5.3 The third tap, MetEx (Multiple file), annotation work flow of multiple files by MetEx:

   - mzXML file path:  A file folder used to save mzXML files which are transfered from raw LC-MS data (by using MSConvert in ProteoWizard).
   - mgf file:  A file folder used to save mgf files which are transfered from raw LC-MS data (by using MSConvert in ProteoWizard).
   - Other parameters are same as Chapter 5.2.

   5.3 The fourth tap, Annotation from peak table, annotation work flow based on peak detection result:

   - MS1 peak table (.csv file):  The peak detection result which is saved in csv file. We provided an example shown in (inst/extdata/peakTable). Two columns named "mz" and "rt" are necessary, other columns are not required.
   - Other parameters are same as Chapter 5.2.

   

## The main functions and their parameters in MetEx

### 1. dbImporter: Import the database which saved in xlsx file.

1. dbFile: the path of the database (xlsx file). 

2. ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is "P" and negative ion mode is "N".

3. CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is "all".

### 2. retentionTimeCalibration: Use internal standard retention to calibrate retention time of metabolites in database.

1. is.tR.file: the xlsx file of IS retention times in database and in your experiment.

3. database.df: the imported database data frame.

### 3. targetExtraction.parallel: Targeted extraction of metabolites using m/z and retention time. 

1. msRawData: the LC-MS untargeted raw data in the formate of mzXML.  e.g. "D:/github/MetEx/Example Data/mzXML/Urine-30V.mzXML".
2. dbData: the imported dbData by the function named “dbImporter”.
3. deltaMZ: the m/z window in targeted extraction.
4. deltaTR: the retention time window in targeted extraction.
5. trRange: the range of retention time used to calculate information entropy, the default value is 30 (second).
6. m: a parameter used for peak detection, the default value is 200.
7. cores: The CPU cores for parallel computing.

### 4. extracResFilter: Filter the result of targeted extraction based on information entropy and peak height.

1. targExtracRes: the result of the function named "targetExtraction"
2. classficationMethod: use the SVM method or not. If you want to use SVM, the value is "SVM", otherwise, the value is "NoSVM". The default value is "NoSVM".
3. entroThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of information entropy.
4. intThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of peak height.

### 5. importMgf: Import the mgf file.

1. mgfFile: the file of mgf. 

### 6. batchMS2Score.parallel: MS/MS similarity calculation.

1. ms1Info: the result of extracResFilter.
2. ms1DeltaMZ: the m/z tolerance between MS1 and MS2.
3. ms2DeltaMZ: the m/z tolerance between MS2 in database and experiment.
4. deltaTR: the retention time tolerance between MS1 and MS2 (second).
5. mgfMatrix: the matrix of mgf that generate by the function named "importMgf". mgfList$mgfMatrix
6. mgfData: the R data of mgf that generate by the function named "importMgf". mgfList$mgfData
7. MS2.sn.threshold: MS2 S/N threshold, the default is 3.
8. MS2.noise.intensity: The MS2 noise intensity, "minimum" or a number.
9. MS2.missing.value.padding: The MS2 missing value padding method, two options are available, "half" and "minimal.value". "Half" is referred to MS-DIAL and "minimal" is closer to the actual situation. And now we recommended "minimal.value".
10. ms2Mode: the MS2 acquisition mode which can be IDA and DIA. the default is "ida", and another option "dia" is developing.
11. scoreMode: "obverse" means dot product, "reverse" means reverse dot product, "average" means the mean of dot product and reverse dot product.
12. diaMethod: when the ms2Mode is "dia", you should input an txt file of the dia method. However, the function is in developing, so the default of diaMethod is "NA".
13. cores: The CPU cores for parallel computing.

### 7. identifiedResFilter: Filter the identified result and generate an new xlsx file for saving the identification result.

1. csvFile: the result of batchMS2Score should be output to a csv file. This parameter is the path of the csv file.
2. resFile: a xlsx file to save the identification result.
3. MS2score: the MS2 score threshold (0-1).

### 8. MetExAnnotation: Integration of the above functions, one line of code can complete the targeted extraction and annotation of metabolites.

1. dbFile: the path of the database (xlsx file).  e.g. "D:/github/MetEx/Example Data/Database/MSMLS database.xlsx".
2. ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is "P" and negative ion mode is "N".
3. CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is "all".
4. tRCalibration: Calibrate retention time (T) or not (F). The default is F.
5. is.tR.file: the xlsx file of IS retention times in database and in your experiment. If the tRCalibration is F, this parameter should be set as "NA".
6. msRawData: the LC-MS untargeted raw data in the formate of mzXML.
7. MS1deltaMZ: the m/z window in targeted extraction.
8. MS1deltaTR: the retention time window in targeted extraction.
9. entroThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of information entropy.
10. intThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of peak height.
11. classficationMethod: use the SVM method or not. If you want to use SVM, the value is "SVM", otherwise, the value is "NoSVM". The default value is "NoSVM".
12. mgfFile: the file of mgf. 
13. MS2.sn.threshold: MS2 S/N threshold, the default is 3.
14. MS2.noise.intensity: The MS2 noise intensity, "minimum" or a number.
15. MS2.missing.value.padding: The MS2 missing value padding method, two options are available, "half" and "minimal.value". "Half" is referred to MS-DIAL and "minimal" is closer to the actual situation. And now we recommended "minimal.value".
16. MS1MS2DeltaMZ: the m/z tolerance between MS1 and MS2.
17. MS2DeltaMZ: the m/z tolerance between MS2 in database and experiment.
18. MS1MS2DeltaTR: the retention time tolerance between MS1 and MS2 (second).
19. scoreMode: "obverse" means dot product, "reverse" means reverse dot product, "average" means the mean of dot product and reverse dot product.
20. csvFile: the result of batchMS2Score should be output to a csv file. This parameter is the path of the csv file.
21. xlsxFile: a xlsx file to save the identification result.
22. MS2scoreFilter: the MS2 score threshold (0-1).
23. parallel.Computing: T or F.
24. cores: The CPU cores for parallel computing.



## Examples
MetEx provide two approaches to annotate metabolites. The first approach is peak-detection-independent method and the second is peak-detection-dependent method. The first approach is newly developed and could avoid the peak loss in conventional peak detection methods.

- Peak-detection-independent metabolite annotation method without retention time calibration (signal LC-MS data):  
    1. Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (http://proteowizard.sourceforge.net/tools.shtml, provided by ProteoWizard). 
    
    2. We used the built-in data files as examples to shown how to do the annotation. the database is:
    
       ```
       system.file("extdata/database", "example_database.xlsx", package = "MetEx")
       ```
    
       The mzXML file is:
    
       ```
       system.file("extdata/mzXML", "example.mzXML", package = "MetEx")
       ```
    
       The mgf file is:
    
       ```
       system.file("extdata/mgf", "example.mgf", package = "MetEx")
       ```
    
       The codes used the example data above to do annotation is shown below:
     ```R
    library(MetEx)
    dbData <- dbImporter(dbFile = system.file("extdata/database", "example_database.xlsx", package = "MetEx"), ionMode = 'P', CE = "all") # If you want to use other database, just change the dbFile to your own database such as "D:/MyCompoundDatabase.xlsx"
    targExtracRes <- targetExtraction.parallel(msRawData = system.file("extdata/mzXML", "example.mzXML", package = "MetEx"), dbData, deltaMZ=0.01, deltaTR=60, cores = 1) # If you want to use your own data, just change the msRawData to your own data such as "D:/My-mzXML-data.mzXML"
    ms1Info <- extracResFilter(targExtracRes, entroThre = 2, intThre = 270)
    mgfList <- importMgf(mgfFile=system.file("extdata/mgf", "example.mgf", package = "MetEx")) # If you want to use you own data, just change the mgfFile to your own data such as "D:/My-mgf-data.mgf"
    batchMS2ScoreResult <- batchMS2Score.parallel(ms1Info, ms1DeltaMZ = 0.01, ms2DeltaMZ = 0.02, deltaTR = 12, mgfMatrix = mgfList$mgfMatrix, mgfData = mgfList$mgfData, scoreMode = "average", cores = 1)
    write.table(batchMS2ScoreResult, file = "D:/Example-result.csv", col.names = NA, sep = ",", dec = ".", qmethod = "double")
    identifiedResFilter(csvFile="D:/Example-result.csv", resFile="D:/Example-result.xlsx", MS2score=0.6)
     ```
    
    ​		We also provide a one-line code method to implement the metabolites targeted extraction and annotation.
    
    ```R
    library(MetEx)
    MetExAnnotation(dbFile = system.file("extdata/database", "example_database.xlsx", package = "MetEx"),
                    ionMode = "P",
                    msRawData = system.file("extdata/mzXML", "example.mzXML", package = "MetEx"),
                    MS1deltaMZ = 0.01,
                    MS1deltaTR = 120,
                    entroThre = 2,
                    intThre = 270,
                    mgfFile = system.file("extdata/mgf", "example.mgf", package = "MetEx"),
                    MS1MS2DeltaMZ = 0.01,
                    MS2DeltaMZ = 0.02,
                    MS1MS2DeltaTR = 12,
                    csvFile = "D:/Example-result.csv",
                    xlsxFile = "D:/Example-result.xlsx",
                    MS2scoreFilter = 0.6)
    ```
    
- Peak-detection-independent metabolite annotation method with retention time calibration (signal LC-MS data):

    1. Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (http://proteowizard.sourceforge.net/tools.shtml, provided by ProteoWizard). 

    2. We used the built-in data files as examples to shown how to do the annotation. 

    3. The retention time of IS used for retention time calibration is:

        ```
        system.file("extdata/trCalibration", "IS-for-tR-calibration.xlsx", package = "MetEx")
        ```

        If you want to calibrate retention times, you should get the experimental retention time of internal standards which are concluded in "IS for retention time calibration.xlsx" and mentioned in our published paper. Write them in the xlsx file.

    4. The codes used the example data above to do annotation is shown below:

         ```R
        library(MetEx)
        dbData <- dbImporter(dbFile = system.file("extdata/database", "example_database.xlsx", package = "MetEx"), ionMode = 'P', CE = "all") # If you want to use other database, just change the dbFile to your own database such as "D:/MyCompoundDatabase.xlsx"
        dbData <- retentionTimeCalibration(is.tR.file = system.file("extdata/trCalibration", "IS-for-tR-calibration.xlsx", package = "MetEx"), database.df = dbData)  # The xlsx file is just an example, if you want to calibrate the retention time, please change the file to yours such as "D:/MyCompoundDatabase.xlsx"
        targExtracRes <- targetExtraction.parallel(msRawData=system.file("extdata/mzXML", "example.mzXML", package = "MetEx"), dbData, deltaMZ=0.01, deltaTR=60, cores = 1) # If you want to use your own data, just change the msRawData to your own data such as "D:/My-mzXML-data.mzXML"
        ms1Info <- extracResFilter(targExtracRes, entroThre = 2, intThre = 270)
        mgfList <- importMgf(mgfFile=system.file("extdata/mgf", "example.mgf", package = "MetEx")) # If you want to use you own data, just change the mgfFile to your own data such as "D:/My-mgf-data.mgf"
        batchMS2ScoreResult <- batchMS2Score.parallel(ms1Info, ms1DeltaMZ = 0.01, ms2DeltaMZ = 0.02, deltaTR = 12, mgfMatrix = mgfList$mgfMatrix, mgfData = mgfList$mgfData, scoreMode = "average", cores = 1)
        write.table(batchMS2ScoreResult, file = "D:/Example-result.csv", col.names = NA, sep = ",", dec = ".", qmethod = "double")
        identifiedResFilter(csvFile="D:/Example-result.csv", resFile="D:/Example-result.xlsx", MS2score=0.6)
        ```
        
        We also provide a one-line code method to implement the metabolites targeted extraction and annotation.
        
        ```R
        library(MetEx)
        MetExAnnotation(dbFile = system.file("extdata/database", "example_database.xlsx", package = "MetEx"),
                        ionMode = "P",
                        tRCalibration = T,
                        is.tR.file =  system.file("extdata/trCalibration", "IS-for-tR-calibration.xlsx", package = "MetEx"),
                        msRawData = system.file("extdata/mzXML", "example.mzXML", package = "MetEx"),
                        MS1deltaMZ = 0.01,
                        MS1deltaTR = 120,
                        entroThre = 2,
                        intThre = 270,
                        mgfFile = system.file("extdata/mgf", "example.mgf", package = "MetEx"),
                        MS1MS2DeltaMZ = 0.01,
                        MS2DeltaMZ = 0.02,
                        MS1MS2DeltaTR = 12,
                        csvFile = "D:/Example-result.csv",
                        xlsxFile = "D:/Example-result.xlsx",
                        MS2scoreFilter = 0.6)
        ```
    
- Peak-detection-independent metabolite annotation without retention time calibration (multiple LC-MS data): 

    1. Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (http://proteowizard.sourceforge.net/tools.shtml, provided by ProteoWizard). 

    2. Create a new folder,  such as "Data for MetEx", then create three new subfolders named "mzXML", "mgf" and "result" under the folder.

    3. The codes used the example data above to do annotation is shown below:

        ```R
        library(MetEx)
        
        path <- "E:/Data for MetEx"
        mzXML.files <- dir(paste0(path,"/mzXML"))
        mgf.files <- gsub(".mzXML", ".mgf", mzXML.files)
        index.files <- gsub(".mzXML", "", mzXML.files)
        
        for (i in c(1:length(mzXML.files))){
          print(index.files[i])
          MetExAnnotation(dbFile = system.file("extdata/database", "example_database.xlsx", package = "MetEx"),
                          ionMode = "P",
                          msRawData = paste0(path,"/mzXML/",mzXML.files[i]),
                          MS1deltaMZ = 0.01,
                          MS1deltaTR = 120,
                          entroThre = 2,
                          intThre = 270,
                          mgfFile = paste0(path,"/mgf/", mgf.files[i]),
                          MS1MS2DeltaMZ = 0.01,
                          MS2DeltaMZ = 0.02,
                          MS1MS2DeltaTR = 12,
                          csvFile = paste0(path,"/result/", index.files[i],".csv"),
                          xlsxFile = paste0(path,"/result/", index.files[i],".xlsx"),
                          MS2scoreFilter = 0.6)
        }
        ```

- Peak-detection-independent metabolite annotation method with retention time calibration (multiple LC-MS data):  

    1. Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (http://proteowizard.sourceforge.net/tools.shtml, provided by ProteoWizard). 

    2. Create a new folder,  such as "Data for MetEx", then create three new subfolders named "mzXML", "mgf" and "result" under the folder.

    3. The codes used the example data above to do annotation is shown below:

        ```R
       library(MetEx)
       
       path <- "E:/Data for MetEx"
       mzXML.files <- dir(paste0(path,"/mzXML"))
       mgf.files <- gsub(".mzXML", ".mgf", mzXML.files)
       index.files <- gsub(".mzXML", "", mzXML.files)
       
       for (i in c(1:length(mzXML.files))){
         print(index.files[i])
         MetExAnnotation(dbFile = system.file("extdata/database", "example_database.xlsx", package = "MetEx"),
                         ionMode = "P",
                         tRCalibration = T,
                         is.tR.file = system.file("extdata/trCalibration", "IS-for-tR-calibration.xlsx", package = "MetEx"),
                         msRawData = paste0(path,"/mzXML/",mzXML.files[i]),
                         MS1deltaMZ = 0.01,
                         MS1deltaTR = 120,
                         entroThre = 2,
                         intThre = 270,
                         mgfFile = paste0(path,"/mgf/", mgf.files[i]),
                         MS1MS2DeltaMZ = 0.01,
                         MS2DeltaMZ = 0.02,
                         MS1MS2DeltaTR = 12,
                         csvFile = paste0(path,"/result/", index.files[i],".csv"),
                         xlsxFile = paste0(path,"/result/", index.files[i],".xlsx"),
                         MS2scoreFilter = 0.6)
       }
       ```

- Peak-detection-dependent method:

    - MetEx is focus on targeted extraction and annotation without peak detection. But we consider that the annotation method based on the result of peak detection is still used by many researchers, we also provided the annotation method based on peak detection.

    - ```R
      # Without tR calibration
      library(MetEx)
      annotationFromPeakTableRes <- annotationFromPeakTable(
           peakTable = system.file("extdata/peakTable","example.csv", package = "MetEx"),
           mgfFile = system.file("extdata/mgf","example.mgf", package = "MetEx"),
           database = system.file("extdata/database","example_database.xlsx", package = "MetEx"),
           ionMode = "P",
           MS1DeltaMZ = 0.01,
           MS1DeltaTR = 120,
           MS1MS2DeltaTR = 5,
           MS1MS2DeltaMZ = 0.01,
           MS2DeltaMZ = 0.02,
       result.file = "D:/Example-result.xlsx")
      ```
      
      ```R
      # With tR calibration
      library(MetEx)
      annotationFromPeakTableRes <- annotationFromPeakTable(
           peakTable = system.file("extdata/peakTable","example.csv", package = "MetEx"),
           mgfFile = system.file("extdata/mgf","example.mgf", package = "MetEx"),
           database = system.file("extdata/database","example_database.xlsx", package = "MetEx"),
           ionMode = "P",
           tRCalibration = T,
           is.tR.file = system.file("extdata/trCalibration", "IS-for-tR-calibration.xlsx", package = "MetEx"),
           MS1DeltaMZ = 0.01,
           MS1DeltaTR = 120,
           MS1MS2DeltaTR = 5,
           MS1MS2DeltaMZ = 0.01,
           MS2DeltaMZ = 0.02,
           result.file = "D:/Example-result.xlsx")
      ```

## Maintainers
Fujian Zheng <zhengfj@dicp.ac.cn> or <2472700387@qq.com>

## Change Log
### `v1.0`
The first version

## Developing Plan

- [ ] Update the MS1 and tr matching method.
- [ ] parallel computing
- [ ] More databases
