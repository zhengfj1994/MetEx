<h1 align="center">
MetEx
</h1>

> MetEx is a tool to extract and annotate metabolites from liquid chromatography–mass spectrometry data.

## Introduction
Liquid chromatography–high resolution mass spectrometry (LC-HRMS) is the most popular platform for untargeted metabolomics methods, but annotating LC-HRMS data is a long-standing bottleneck that we are facing since years ago in metabolomics research. A wide variety of methods have been established to deal with the annotation issue. To date, however, there is a scarcity of efficient, systematic, and easy-to-handle tools that are tailored for metabolomics community. So we developed a user-friendly and powerful software/webserver, MetEx, to both enable implementation of classical peak detection-based annotation and a new annotation method based on targeted extraction algorithms. The new annotation method based on targeted extraction algorithms can annotate more than 2 times metabolites than classical peak detection-based annotation method because it reduces the loss of metabolite signal in the data preprocessing process. MetEx is freely available at http://www.metaboex.cn/MetEx and https://sourceforge.net/projects/metex (webserver and offline standalone program), the source code is available at https://github.com/zhengfj1994/MetEx.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Workflow-of-MetEx.png"/></div>
<h4 align="center">
Figure 1. The workflow of MetEx
</h4>
## R package, offline standalone software and web server.

MetEx provides three ways to obtain, namely:

1. R package  https://github.com/zhengfj1994/MetEx
2. Offline standalone software https://sourceforge.net/projects/metex
3. web server http://www.metaboex.cn/MetEx

We first recommend using offline standalone program.



## How to use the offline standalone software?

### 1. Download MetExApp.zip

Please download MetExApp.zip on SourceForge https://sourceforge.net/projects/metex

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Download_MetExApp.png"/></div>
<h4 align="center">
Figure 2. Download MetExApp from SourceForge
</h4>

### 2. Unzip MetExApp.zip.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Unzipped_MetExApp.png"/></div>
<h4 align="center">
Figure 3. Unzipped MetExApp
</h4>

### 3. Check browser

Please ensure that there is a browser available on your computer, because the MetEx program will be opened in your default browser. We tested Google Chrome browser, Microsoft Edge browser, 360 speed browser, all of which can run MetEx.

### 4. Double-click MetEx.vbs

There is a file named MetEx.vbs in the unzipped folder. Double-click MetEx.vbs. Please wait patiently. The loading of the operating environment may take about 1 minute.

### 5. MetEx in browser

Then you can see the MetEx is opened in your default browser.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Page_MetEx.png"/></div>
<h4 align="center">
Figure 4. MetExApp opened in web browser
</h4>

### 6. Overview of MetEx

You can see that there are some options to choose from on the left side of the MetEx page, namely Introduction, MetEx (Single file), MetEx (Mutilple), Classic annotation, Other software tools, Database download, Chromatographic systems, Help document, Update. If you want to annotate a mass spectrum file with MetEx, please select MetEx (Single file). If you want to annotate multiple mass spectrum files, and multiple mass spectrum files will eventually be merged into one table, please select MetEx (Mutilple). If you want to annotate compounds based on the results of peak matching, please select Classic annotation.

### 7. MetEx (Single file)

Below we will introduce MetEx (Single file): Use MetEx to annotate a single LC-MS file.

#### 7.1 Parameters

On the page of MetEx (Single file), you can see that there are some parameters that need to be set. Their meanings and recommended values are as follows:

##### 	7.1.1 Database input

###### 		7.1.1.1 Database

​		A database file that meets MetEx's formatting requirements.

###### 		7.1.1.2 Ion mode

​		The ion mode used for annotation, 'positive' or 'negative'.

###### 		7.1.1.3 CE

​		Collision energy used for MS/MS acquisition, 'all', 'low', 'medium' or 'high'. Only when the low, medium and high collision energies of the database are 15, 30, 45 eV, the 'low', 'medium' and 'high' options can be used, otherwise, please use the 'all' option.

##### 	7.1.2 Retention time calibration

###### 		7.1.2.1 Whether to perform tR calibration

​		'Yes' means the tR prediction will be preformed and you should provide an xlsx for tR prediction. 'No' means tR prediction will not be preformed.

###### 		7.1.2.2 tR of internal standards

​		a xlsx file, which contain the retention time of internal standards in database and experiment. It should be looked like Figure below.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/IS-for-tR-calibration.png"/></div>
<h4 align="center">
Figure 5. A xlsx file containing retention times of internal standard which used for retention time calibration
</h4>

##### 	7.1.3 LC-MS data import

###### 		7.1.3.1 mzXML file

​		The mzXML file which is transfered from raw LC-MS data (by using MSconvert in proteowizard).

###### 		7.1.3.2 mgf file

​		The mgf file which is transfered from raw LC-MS data (by using MSconvert in proteowizard).

##### 	7.1.4 Parameters of MetEx (MS1)

###### 		7.1.4.1 Delta m/z of MS1

​		The tolerance of MS1 between database and experiment (0.01 Da is recommended for Q-TOF and 0.005 Da is recommended for QE-HF).

###### 		7.1.4.2 Delta tR of MS1

​		the tolerance of retention time between database and experiment. The unit is seconds.

###### 		7.1.4.3 Entropy threshold

​		The information entropy threshold, 1.75 - 2 is recommended.

###### 		7.1.4.4 Intensity threshold

​		The peak height threshold. 600-270 is recommended for Q-TOF.

##### 	7.1.5 Parameters of MetEx (MS2)

###### 		7.1.5.1 Delta m/z of MS1 and MS2

​		The tolerance between MS1 and MS2 in experiment.

###### 		7.1.5.2 Delta m/z of MS2

​		The tolerance of MS2 between database and experiment.

###### 		7.1.5.3 Delta tR of MS1 and MS2

​		The tolerance of tR between MS1 and MS2

###### 		7.1.5.4 MS2 score threshold

​		The MS2 score threshold (0-1)

##### 	7.1.6 Other parameters

###### 		7.1.6.1 Number of cores for parallel computing

​		The number of CPU cores for parallel computing, it is depend on your computer's CPU and RAM. Users can refer to the following rules: The number of cores for parallel computing < The number of CPU cores of your computer & The number of cores for parallel computing × 4 GB < The RAM of you computer

###### 		7.1.6.2 show/hide Advance parameters

##### 	7.1.7 Advance parameters

###### 		7.1.7.1 MS2 S/N threshold

​		The MS2 S/N threshold

###### 		7.1.7.2 MS2 noise intensity

​		The MS2 noise intensity, 'minimum' or a number.

###### 		7.1.7.3 MS2 missing value padding method

​		The MS2 missing value padding method, two options are available, 'half' and 'minimal'. 'half' is referred to MS-DIAL and 'minimal' is closer to the actual situation. And now we recommended 'minimal'.

#### 7.2 Run MetEx

Click the run button to start running.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Run_MetEx.png"/></div>
<h4 align="center">
Figure 6. Run MetEx
</h4>


#### 7.3 Download result

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Download_result.png"/></div>
<h4 align="center">
Figure 7. Download result
</h4>


### 8. MetEx (Mutiple file)

Below we will introduce MetEx (Mutiple file): Use MetEx to annotate mutiple LC-MS files.

#### 8.1  Parameters

Except for the different parameters in the 'LC-MS data import' part, other parameters are the same as MetEx (Single file) The 'mzXML file path' is a file folder in your computer which save mzXML files and the 'mgf file path' is a file folder in your computer which save mgf files.

#### 8.2 Run MetEx

Click the run button to start running

#### 8.3 Download result



### 9. Classic annotation

Below we will introduce Classic annotation: Annotation from peak detection result.

#### 9.1 Parameters

##### 	9.1.1 Database input

​	same with 7.1.1

##### 	9.1.2 Retention time calibration

​	same with 7.1.2

##### 	9.1.3 LC-MS data import

###### 		9.1.3.1 MS1 peak table (.csv file)

​		The peak detection result which is saved in csv file. We provided an example shown in (inst/extdata/peakTable). Two columns named 'mz' and 'rt' are necessary, other columns are not required.

###### 		9.1.3.2 mgf file path

​		same with 7.1.3.2

##### 	9.1.4 Parameters of MetEx (MS1)

###### 		9.1.4.1 Delta m/z of MS1

​		same with 7.1.4.1

###### 		9.1.4.2 Delta tR of MS1

​		It is slightly different from 7.1.4.2. 7.1.4.2 refers to the retention time range, and 9.1.4.2 refers to the retention time deviation, so 120 s in 7.1.4.2 and 60 s in 9.1.4.2 are equivalent.

##### 	9.1.5 Parameters of MetEx (MS2)

​	same with 7.1.5

##### 	9.1.6 Other parameters

​	same with 7.1.6

##### 	9.1.7 Advance parameters

​	same with 7.1.7

#### 9.2 Run MetEx

Click the run button to start running.

#### 9.3 Download result



## How to use the web server?

### 1. Open MetEx web server

web server http://www.metaboex.cn/MetEx

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Webserver_MetEx.png"/></div>
<h4 align="center">
Figure 8. Web server of MetEx
</h4>




### 2. Overview of MetEx

You can see that web server of MetEx is same with the offline standalone software. The two are almost the same in use, so we won't repeat them here. Please note that the web server resources are limited. Please use offline standalone program as much as possible. If the running capacity of the server is exceeded, an error will be reported.



## How to use the R package?

### 1. Installation

#### 1.1 Install R

If you don't have R language, install R first.   

[>> R download here](https://cran.r-project.org/)  
Note: We developed MetEx in R 4.10.0. If you find problems when you use other versions, please contact us.  
[>> The old version of R](https://cran.r-project.org/bin/windows/base/old/)

#### 1.2 Install Rstudio 

We recommended to install Rstudio owing to it is an integrated development environment (IDE) for R.  
[>> Rstudio download here](https://rstudio.com/products/rstudio/)

#### 1.3 Install MetEx

Install the R package "devtools" and other reliable packages, then install MetEx using codes below.
[>>The devtools package](https://cran.r-project.org/web/packages/devtools/index.html)

```
install.packages(c("devtools","BiocManager"))
BiocManager::install(c("xcms","KEGGREST","DIAlignR","peakPantheR"), update = TRUE, ask = FALSE)
devtools::install_github('bentrueman/fffprocessr')
devtools::install_github('zhengfj1994/MetEx')
```

 It will take few minutes to download the packages.

#### 1.4 Offline install

If the third step fails to install, users can download the project and install offline as shown below:  

<div align=center><img width="600" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Offline-install-1.png"/></div>
<h4 align="center">
Figure 9. Download the MetEx package from github.
</h4>

<div align=center><img width="600" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Offline-install-2.png"/></div>
<h4 align="center">
Figure 10. Download the MetEx package from github(2).
</h4>		


Then, in Rstudio, choose Packages —— Install:  

<div align=center><img width="600" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Offline-install-3.png"/></div>
<h4 align="center">
Figure 11. Package intallation in Rstudio
</h4>


Finally, choose install from Package Archive File (.zip; .tar.gz), and select the MetEx package, click install.

<div align=center><img width="350" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Offline-install-4.png"/></div>  
<h4 align="center">
Figure 12. Choose the MetEx-master.zip and install.
</h4>


#### 1.5 Call MetEx

Call MetEx to see if the installation was successful.

```
library(MetEx)
```

### 2. Run shinyApp in Rstudio

Enter the following line of code:

```
shiny::runApp(system.file("extdata/shinyApp", package = "MetEx"))
```

Then you can run shinyApp in Rstudio.

<div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/Screen-shot-of-Shiny-App.png"/></div>  
<h4 align="center">
Figure 13. Screen shot of Shiny App.
</h4>


### 3. Functions and their parameters

The main functions and their parameters in MetEx

#### 3.1 dbImporter

Import the database which saved in xlsx file.

- dbFile: the path of the database (xlsx file). 

- ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is "P" and negative ion mode is "N".

- CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is "all".

#### 3.2 retentionTimeCalibration

Use internal standard retention to calibrate retention time of metabolites in database.

- is.tR.file: the xlsx file of IS retention times in database and in your experiment.

- database.df: the imported database data frame.

#### 3.3 targetExtraction.parallel

Targeted extraction of metabolites using m/z and retention time. 

- msRawData: the LC-MS untargeted raw data in the formate of mzXML.  e.g. "D:/github/MetEx/Example Data/mzXML/Urine-30V.mzXML".

- dbData: the imported dbData by the function named “dbImporter”.

- deltaMZ: the m/z window in targeted extraction.

- deltaTR: the retention time window in targeted extraction.

- trRange: the range of retention time used to calculate information entropy, the default value is 30 (second).

- m: a parameter used for peak detection, the default value is 200.

- cores: The CPU cores for parallel computing.

#### 3.4 extracResFilter

Filter the result of targeted extraction based on information entropy and peak height.

- targExtracRes: the result of the function named "targetExtraction"

- classficationMethod: use the SVM method or not. If you want to use SVM, the value is "SVM", otherwise, the value is "NoSVM". The default value is "NoSVM".

- entroThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of information entropy.

- intThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of peak height.

#### 3.5 importMgf

Import the mgf file.

- mgfFile: the file of mgf. 

#### 3.6 batchMS2Score.parallel

MS/MS similarity calculation.

- ms1Info: the result of extracResFilter.

- ms1DeltaMZ: the m/z tolerance between MS1 and MS2.

- ms2DeltaMZ: the m/z tolerance between MS2 in database and experiment.

- deltaTR: the retention time tolerance between MS1 and MS2 (second).

- mgfMatrix: the matrix of mgf that generate by the function named "importMgf". mgfList$mgfMatrix

- mgfData: the R data of mgf that generate by the function named "importMgf". mgfList$mgfData

- MS2.sn.threshold: MS2 S/N threshold, the default is 3.

- MS2.noise.intensity: The MS2 noise intensity, "minimum" or a number.

- MS2.missing.value.padding: The MS2 missing value padding method, two options are available, "half" and "minimal.value". "Half" is referred to MS-DIAL and "minimal" is closer to the actual situation. And now we recommended "minimal.value".

- ms2Mode: the MS2 acquisition mode which can be IDA and DIA. the default is "ida", and another option "dia" is developing.

- scoreMode: "obverse" means dot product, "reverse" means reverse dot product, "average" means the mean of dot product and reverse dot product.

- diaMethod: when the ms2Mode is "dia", you should input an txt file of the dia method. However, the function is in developing, so the default of diaMethod is "NA".

- cores: The CPU cores for parallel computing.

#### 3.7 identifiedResFilter

Filter the identified result and generate an new xlsx file for saving the identification result.

- batchMS2ScoreResult: the result of batchMS2Score.

- MS2score: the MS2 score threshold (0-1).

#### 3.8 MetExAnnotation

Integration of the above functions, one line of code can complete the targeted extraction and annotation of metabolites.

- dbFile: the path of the database (xlsx file).  e.g. "D:/github/MetEx/Example Data/Database/MSMLS database.xlsx".

- ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is "P" and negative ion mode is "N".

- CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is "all".

- tRCalibration: Calibrate retention time (T) or not (F). The default is F.

- is.tR.file: the xlsx file of IS retention times in database and in your experiment. If the tRCalibration is F, this parameter should be set as "NA".

- msRawData: the LC-MS untargeted raw data in the formate of mzXML.

- MS1deltaMZ: the m/z window in targeted extraction.

- MS1deltaTR: the retention time window in targeted extraction.

- entroThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of information entropy.

- intThre: When the classficationMethod is "NoSVM", this parameter is meaningful, The value of peak height.

- classficationMethod: use the SVM method or not. If you want to use SVM, the value is "SVM", otherwise, the value is "NoSVM". The default value is "NoSVM".

- mgfFile: the file of mgf. 

- MS2.sn.threshold: MS2 S/N threshold, the default is 3.

- MS2.noise.intensity: The MS2 noise intensity, "minimum" or a number.

- MS2.missing.value.padding: The MS2 missing value padding method, two options are available, "half" and "minimal.value". "Half" is referred to MS-DIAL and "minimal" is closer to the actual situation. And now we recommended "minimal.value".

- MS1MS2DeltaMZ: the m/z tolerance between MS1 and MS2.

- MS2DeltaMZ: the m/z tolerance between MS2 in database and experiment.

- MS1MS2DeltaTR: the retention time tolerance between MS1 and MS2 (second).

- scoreMode: "obverse" means dot product, "reverse" means reverse dot product, "average" means the mean of dot product and reverse dot product.

- MS2scoreFilter: the MS2 score threshold (0-1).

- cores: The CPU cores for parallel computing.

#### 3.9 annotationFromPeakTable.parallel

Annotation from peak table.

- peakTable: peak table in specific format.
- mgfFile: the file of mgf. 
- database: the path of the database (xlsx file).  e.g. "D:/github/MetEx/Example Data/Database/MSMLS database.xlsx".
- ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is "P" and negative ion mode is "N".
- CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is "all".
- tRCalibration: Calibrate retention time (T) or not (F). The default is F.
- is.tR.file: the xlsx file of IS retention times in database and in your experiment. If the tRCalibration is F, this parameter should be set as "NA".
- MS1DeltaMZ: the m/z tolerance.
- MS1DeltaTR: the retention time tolerance.
- MS2.sn.threshold: MS2 S/N threshold, the default is 3.
- MS2.noise.intensity: The MS2 noise intensity, "minimum" or a number.
- MS2.missing.value.padding: The MS2 missing value padding method, two options are available, "half" and "minimal.value". "Half" is referred to MS-DIAL and "minimal" is closer to the actual situation. And now we recommended "minimal.value".
- ms2Mode: the MS2 acquisition mode which can be IDA and DIA. the default is "ida", and another option "dia" is developing.
- diaMethod: when the ms2Mode is "dia", you should input an txt file of the dia method. However, the function is in developing, so the default of diaMethod is "NA".
- MS1MS2DeltaTR: the retention time tolerance between MS1 and MS2 (second).
- MS1MS2DeltaMZ: the m/z tolerance between MS1 and MS2.
- MS2DeltaMZ: the m/z tolerance between MS2 in database and experiment.
- scoreMode: "obverse" means dot product, "reverse" means reverse dot product, "average" means the mean of dot product and reverse dot product.
- cores: The CPU cores for parallel computing.



### 4. Examples

MetEx provide two approaches to annotate metabolites. The first approach is peak-detection-independent method and the second is peak-detection-dependent method. The first approach is newly developed and could avoid the peak loss in conventional peak detection methods.

- Peak-detection-independent metabolite annotation method without retention time calibration (signal LC-MS data):  

  1. Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (http://proteowizard.sourceforge.net/tools.shtml, provided by ProteoWizard). 

  2. We used the built-in data files as examples to shown how to do the annotation. the database is:

     ```
     system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx")
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
  dbData <- dbImporter(dbFile = system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx"), ionMode = 'P', CE = "all") # If you want to use other database, just change the dbFile to your own database such as "D:/MyCompoundDatabase.xlsx"
  targExtracRes <- targetExtraction.parallel(msRawData = system.file("extdata/mzXML", "example.mzXML", package = "MetEx"), dbData, deltaMZ=0.01, deltaTR=60, cores = 1) # If you want to use your own data, just change the msRawData to your own data such as "D:/My-mzXML-data.mzXML"
  ms1Info <- extracResFilter(targExtracRes, entroThre = 2, intThre = 270)
  mgfList <- importMgf(mgfFile=system.file("extdata/mgf", "example.mgf", package = "MetEx")) # If you want to use you own data, just change the mgfFile to your own data such as "D:/My-mgf-data.mgf"
  batchMS2ScoreResult <- batchMS2Score.parallel(ms1Info, ms1DeltaMZ = 0.01, ms2DeltaMZ = 0.02, deltaTR = 12, mgfMatrix = mgfList$mgfMatrix, mgfData = mgfList$mgfData, scoreMode = "average", cores = 1)
  write.table(batchMS2ScoreResult, file = "D:/Example-result.csv", col.names = NA, sep = ",", dec = ".", qmethod = "double")
  identifiedResFilterRes <- identifiedResFilter(batchMS2ScoreResult, MS2score=0.6)
  openxlsx::write.xlsx(identifiedResFilterRes, file = "D:/Example-result.xlsx")
   ```

  ​		We also provide a one-line code method to implement the metabolites targeted extraction and annotation.

  ```R
  library(MetEx)
  MetExAnnotationRes <- MetExAnnotation(dbFile = system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
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
                  MS2scoreFilter = 0.6)
  openxlsx::write.xlsx(MetExAnnotationRes, file = "D:/Example-result.xlsx")
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
     dbData <- dbImporter(dbFile = system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx"), ionMode = 'P', CE = "all") # If you want to use other database, just change the dbFile to your own database such as "D:/MyCompoundDatabase.xlsx"
     dbData <- retentionTimeCalibration(is.tR.file = system.file("extdata/trCalibration", "IS-for-tR-calibration.xlsx", package = "MetEx"), database.df = dbData)  # The xlsx file is just an example, if you want to calibrate the retention time, please change the file to yours such as "D:/MyCompoundDatabase.xlsx"
     targExtracRes <- targetExtraction.parallel(msRawData=system.file("extdata/mzXML", "example.mzXML", package = "MetEx"), dbData, deltaMZ=0.01, deltaTR=60, cores = 1) # If you want to use your own data, just change the msRawData to your own data such as "D:/My-mzXML-data.mzXML"
     ms1Info <- extracResFilter(targExtracRes, entroThre = 2, intThre = 270)
     mgfList <- importMgf(mgfFile=system.file("extdata/mgf", "example.mgf", package = "MetEx")) # If you want to use you own data, just change the mgfFile to your own data such as "D:/My-mgf-data.mgf"
     batchMS2ScoreResult <- batchMS2Score.parallel(ms1Info, ms1DeltaMZ = 0.01, ms2DeltaMZ = 0.02, deltaTR = 12, mgfMatrix = mgfList$mgfMatrix, mgfData = mgfList$mgfData, scoreMode = "average", cores = 1)
     write.table(batchMS2ScoreResult, file = "D:/Example-result.csv", col.names = NA, sep = ",", dec = ".", qmethod = "double")
     identifiedResFilterRes <- identifiedResFilter(batchMS2ScoreResult, MS2score=0.6)
     openxlsx::write.xlsx(identifiedResFilterRes, file = "D:/Example-result.xlsx")
     ```

     We also provide a one-line code method to implement the metabolites targeted extraction and annotation.

     ```R
     library(MetEx)
     MetExAnnotationRes <- MetExAnnotation(dbFile = system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
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
                     MS2scoreFilter = 0.6)
     openxlsx::write.xlsx(MetExAnnotationRes, file = "D:/Example-result.xlsx")
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
       MetExAnnotationRes <- MetExAnnotation(dbFile = system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
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
                       MS2scoreFilter = 0.6)
         openxlsx::write.xlsx(MetExAnnotationRes, file = paste0(path, "/", index.files[i], ".xlsx"))
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
       MetExAnnotationRes <- MetExAnnotation(dbFile = system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
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
                       MS2scoreFilter = 0.6)
         openxlsx::write.xlsx(MetExAnnotationRes, file = paste0(path, "/", index.files[i], ".xlsx"))
     }
     ```

- Peak-detection-dependent method:

  - MetEx is focus on targeted extraction and annotation without peak detection. But we consider that the annotation method based on the result of peak detection is still used by many researchers, we also provided the annotation method based on peak detection.

  - ```R
    # Without tR calibration
    library(MetEx)
    annotationFromPeakTableRes <- annotationFromPeakTable.parallel(
         peakTable = system.file("extdata/peakTable","example.csv", package = "MetEx"),
         mgfFile = system.file("extdata/mgf","example.mgf", package = "MetEx"),
         database = system.file("extdata/database","MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
         ionMode = "P",
         MS1DeltaMZ = 0.01,
         MS1DeltaTR = 120,
         MS1MS2DeltaTR = 5,
         MS1MS2DeltaMZ = 0.01,
         MS2DeltaMZ = 0.02,
    	 cores = 1)
    
    openxlsx::write.xlsx(annotationFromPeakTableRes, file = "D:/Example-result.xlsx")
    ```
    
    ```R
    # With tR calibration
    library(MetEx)
    annotationFromPeakTableRes <- annotationFromPeakTable.parallel(
         peakTable = system.file("extdata/peakTable","example.csv", package = "MetEx"),
         mgfFile = system.file("extdata/mgf","example.mgf", package = "MetEx"),
         database = system.file("extdata/database","MetEx_OSI+MSMLS.xlsx", package = "MetEx"),
         ionMode = "P",
         tRCalibration = T,
         is.tR.file = system.file("extdata/trCalibration", "IS-for-tR-calibration.xlsx", package = "MetEx"),
         MS1DeltaMZ = 0.01,
         MS1DeltaTR = 120,
         MS1MS2DeltaTR = 5,
         MS1MS2DeltaMZ = 0.01,
         MS2DeltaMZ = 0.02,
    	 cores = 1)
    
    openxlsx::write.xlsx(annotationFromPeakTableRes, file = "D:/Example-result.xlsx")
    ```



## Dependences

MetEx dependent the following packages, If you find that the installation fails and you are prompted that the following installation package is missing, please manually install the missing packages.
         stats,
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
         Rcpp,
         DIAlignR,
         minpack.lm,
         purrr,
         rlang,
         peakPantheR
         BiocManager,
         knitr,
         shiny,
         ggplot2,
         RColorBrewer,
         fffprocessr

## The uniform database format

- The database is stored in .xlsx file. And the first row is column names. Column names are specific, and using an irregular column name would make the database unrecognizable. The database should containing these columns:
  
    - confidence_level : Compounds with level 1 have accurate mass, experimental tR and experimental MS2 data. Compounds with level 2 have accurate mass, predicted tR and experimental MS2 data. Compounds with level 3 have accurate mass, predicted tR and predicted MS2 data.
      
    - ID: The compound ID in database
      
    - Name: the compound name.
    
    - Formula
    
    - ExactMass: MW
    
    - SMILES
    
    - InChIKey
    
    - CAS
    
    - CID

    - ionMode : the ion mode of LC-MS, positive ion mode is P and negative ion mode is N.

    - Adduct
    
    - m/z: the accurate mass in LC-MS
    
    - tr: the retention time (in second)
    
    - CE: collision energy.
    
    - MSMS: the MS/MS spectrum. The ion and its intensity are separated by a space (" "), and the ion and the ion are separated by a semicolon (";"). For example: 428.036305927272 0.0201115093588212;524.057195188813 0.0699256604274525;542.065116124274 0.148347272003186;664.112740221342 1 is the abbreviate of MS/MS spectrum below:  
    
      |       m/z        |     intensity      |
      | :--------------: | :----------------: |
      | 428.036305927272 | 0.0201115093588212 |
      | 524.057195188813 | 0.0699256604274525 |
      | 542.065116124274 | 0.148347272003186  |
      | 664.112740221342 |         1          |
    
    - Instrument_type: for example, Q-TOF.
    
    - Instrument: for example, AB 5600 +
    
    - Other information is not mandatory, and users can add it as they see fit.  We have gave an example of database in data.
    
      <div align=center><img width="800" src="https://github.com/zhengfj1994/MetEx/blob/master/screenshots/example-of-database.png"/></div>  
      <h4 align="center">
      Figure 13. An example of database.
      </h4>

## Supported database
- OSI-SMMS: Our in-house database, containing ~2000 metabolites in positive or negative ion modes.

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

GNN-RT (https://github.com/Qiong-Yang/GNNRT) was used for retention time prediction in multiple chromatographic systems.



## Maintainers
Fujian Zheng <zhengfj@dicp.ac.cn> or <2472700387@qq.com>

## Change Log
### `v1.0`
The first version

## Developing Plan

- [ ] Update the MS1 and tr matching method.
- [x] parallel computing
- [ ] More databases
