fluidPage(
  fluidRow(
    div(
      id="mainbody",
      column(img(src = "flower_left.png", align = "center", width = "10%"),
             img(src = "MetEx_icon_2.png", align = "center", width = "35%"),
             img(src = "flower_right.png", align = "center", width = "10%"),
             align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
          HTML("~~ <em>Dear Users, Welcome to check the help document</em> ~~")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
  <h2 >Introduction</h2>
  <p>Liquid chromatography–high resolution mass spectrometry (LC-HRMS) is the most popular platform for untargeted metabolomics methods, but annotating LC-HRMS data is a long-standing bottleneck that we are facing since years ago in metabolomics research. A wide variety of methods have been established to deal with the annotation issue. To date, however, there is a scarcity of efficient, systematic, and easy-to-handle tools that are tailored for metabolomics community. So we developed a user-friendly and powerful software/webserver, MetEx, to both enable implementation of classical peak detection-based annotation and a new annotation method based on targeted extraction algorithms. The new annotation method based on targeted extraction algorithms can annotate more than 2 times metabolites than classical peak detection-based annotation method because it reduces the loss of metabolite signal in the data preprocessing process. MetEx is freely available at <a href='http://www.metaboex.cn/MetEx' target='_blank' class='url'>http://www.metaboex.cn/MetEx</a> and <a href='https://sourceforge.net/projects/metex' target='_blank' class='url'>https://sourceforge.net/projects/metex</a> (webserver and offline standalone program), the source code is available at <a href='https://github.com/zhengfj1994/MetEx' target='_blank' class='url'>https://github.com/zhengfj1994/MetEx</a>.</p>
               ")),
      column(img(src = "The_workflow_of_MetEx.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 1. The workflow of MetEx
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <h2 >R package, offline standalone software and web server.</h2>
               <p>MetEx provides three ways to obtain, namely:</p>
               <ol>
               <li>R package  <a href='https://github.com/zhengfj1994/MetEx' target='_blank' class='url'>https://github.com/zhengfj1994/MetEx</a></li>
               <li>Offline standalone software <a href='https://sourceforge.net/projects/metex' target='_blank' class='url'>https://sourceforge.net/projects/metex</a></li>
               <li>web server <a href='http://www.metaboex.cn/MetEx' target='_blank' class='url'>http://www.metaboex.cn/MetEx</a></li>
               </ol>
               <p>We first recommend using offline standalone program.</p>
               <p>&nbsp;</p>
               <h2 >How to use the offline standalone software?</h2>
               <h3 >1. Download MetExApp.zip</h3>
               <p>Please download MetExApp.zip on SourceForge <a href='https://sourceforge.net/projects/metex' target='_blank' class='url'>https://sourceforge.net/projects/metex</a></p>
               ")),
      column(img(src = "Download_MetExApp.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 2. Download MetExApp from SourceForge
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <h3 >2. Unzip MetExApp.zip.</h3>
               ")),
      column(img(src = "Unzipped_MetExApp.png", align = "center", width = "35%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 3. Unzipped MetExApp
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <h3 >3. Check browser</h3>
               <p>Please ensure that there is a browser available on your computer, because the MetEx program will be opened in your default browser. We tested Google Chrome browser, Microsoft Edge browser, 360 speed browser, all of which can run MetEx.</p>
               <h3 >4. Double-click MetEx.vbs</h3>
               <p>There is a file named MetEx.vbs in the unzipped folder. Double-click MetEx.vbs. Please wait patiently. The loading of the operating environment may take about 1 minute.</p>
               <h3 >5. MetEx in browser</h3>
               <p>Then you can see the MetEx is opened in your default browser.</p>
               ")),
      column(img(src = "Page_MetEx.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 4. MetExApp opened in web browser
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <h3 >6. Overview of MetEx</h3>
               <p>You can see that there are some options to choose from on the left side of the MetEx page, namely Introduction, MetEx (Single file), MetEx (Mutilple), Classic annotation, Other software tools, Database download, Chromatographic systems, Help document, Update. If you want to annotate a mass spectrum file with MetEx, please select MetEx (Single file). If you want to annotate multiple mass spectrum files, and multiple mass spectrum files will eventually be merged into one table, please select MetEx (Mutilple). If you want to annotate compounds based on the results of peak matching, please select Classic annotation.</p>
               <h3 >7. MetEx (Single file)</h3>
               <p>Below we will introduce MetEx (Single file): Use MetEx to annotate a single LC-MS file.</p>
               <ol>
               <h3 >7.1 Parameters</h3>
               <p>On the page of MetEx (Single file), you can see that there are some parameters that need to be set. Their meanings and recommended values are as follows:</p>
               <ol>
               <h3 >	7.1.1 Database input</h3>
               <ol>
               <h3 >		7.1.1.1 Database</h3>
               <p>		A database file that meets MetEx&#39;s formatting requirements.</p>
               <h3 >		7.1.1.2 Ion mode</h3>
               <p>		The ion mode used for annotation, &#39;positive&#39; or &#39;negative&#39;.</p>
               <h3 >		7.1.1.3 CE</h3>
               <p>		Collision energy used for MS/MS acquisition, &#39;all&#39;, &#39;low&#39;, &#39;medium&#39; or &#39;high&#39;. Only when the low, medium and high collision energies of the database are 15, 30, 45 eV, the &#39;low&#39;, &#39;medium&#39; and &#39;high&#39; options can be used, otherwise, please use the &#39;all&#39; option.</p>
               </ol>
               <h3 >	7.1.2 Retention time calibration</h3>
               <ol>
               <h3 >		7.1.2.1 Whether to perform tR calibration</h3>
               <p>		&#39;Yes&#39; means the tR prediction will be preformed and you should provide an xlsx for tR prediction. &#39;No&#39; means tR prediction will not be preformed.</p>
               <h3 >		7.1.2.2 tR of internal standards</h3>
               <p>		a xlsx file, which contain the retention time of internal standards in database and experiment. It should be looked like Figure below.</p>
               </ol>
               </ol>
               </ol>
               ")),
      column(img(src = "IS-for-tR-calibration.png", align = "center", width = "50%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 5. A xlsx file containing retention times of internal standard which used for retention time calibration
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <ol>
               <ol>
               <h3 >	7.1.3 LC-MS data import</h3>
               <ol>
               <h3 >		7.1.3.1 mzXML file</h3>
               <p>		The mzXML file which is transfered from raw LC-MS data (by using MSconvert in proteowizard).</p>
               <h3 >		7.1.3.2 mgf file</h3>
               <p>		The mgf file which is transfered from raw LC-MS data (by using MSconvert in proteowizard).</p>
               </ol>
               <h3 >	7.1.4 Parameters of MetEx (MS1)</h3>
               <ol>
               <h3 >		7.1.4.1 Delta m/z of MS1</h3>
               <p>		The tolerance of MS1 between database and experiment (0.01 Da is recommended for Q-TOF and 0.005 Da is recommended for QE-HF).</p>
               <h3 >		7.1.4.2 Delta tR of MS1</h3>
               <p>		the tolerance of retention time between database and experiment. The unit is seconds.</p>
               <h3 >		7.1.4.3 Entropy threshold</h3>
               <p>		The information entropy threshold, 1.75 - 2 is recommended.</p>
               <h3 >		7.1.4.4 Intensity threshold</h3>
               <p>		The peak height threshold. 600-270 is recommended for Q-TOF.</p>
               </ol>
               <h3 >	7.1.5 Parameters of MetEx (MS2)</h3>
               <ol>
               <h3 >		7.1.5.1 Delta m/z of MS1 and MS2</h3>
               <p>		The tolerance between MS1 and MS2 in experiment.</p>
               <h3 >		7.1.5.2 Delta m/z of MS2</h3>
               <p>		The tolerance of MS2 between database and experiment.</p>
               <h3 >		7.1.5.3 Delta tR of MS1 and MS2</h3>
               <p>		The tolerance of tR between MS1 and MS2</p>
               <h3 >		7.1.5.4 MS2 score threshold</h3>
               <p>		The MS2 score threshold (0-1)</p>
               </ol>
               <h3 >	7.1.6 Other parameters</h3>
               <ol>
               <h3 >		7.1.6.1 Result (xlsx file)</h3>
               <p>		Result (xlsx file) is the path of the result file. It is only available in the offline version. The full path is required, separated by / instead of  \\. For example: E:/MetEx/result.xlsx</p>
               <h3 >		7.1.6.2 Number of cores for parallel computing</h3>
               <p>		The number of CPU cores for parallel computing, it is depend on your computer&#39;s CPU and RAM. Users can refer to the following rules: The number of cores for parallel computing &lt; The number of CPU cores of your computer &amp; The number of cores for parallel computing × 4 GB &lt; The RAM of you computer</p>
               <h3 >		7.1.6.3 show/hide Advance parameters</h3>
               </ol>
               <h3 >	7.1.7 Advance parameters</h3>
               <ol>
               <h3 >		7.1.7.1 MS2 S/N threshold</h3>
               <p>		The MS2 S/N threshold</p>
               <h3 >		7.1.7.2 MS2 noise intensity</h3>
               <p>		The MS2 noise intensity, &#39;minimum&#39; or a number.</p>
               <h3 >		7.1.7.3 MS2 missing value padding method</h3>
               <p>		The MS2 missing value padding method, two options are available, &#39;half&#39; and &#39;minimal&#39;. &#39;half&#39; is referred to MS-DIAL and &#39;minimal&#39; is closer to the actual situation. And now we recommended &#39;minimal&#39;.</p>
               </ol>
               </ol>
               </ol>
               <ol>
               <h3 >7.2 Run MetEx</h3>
               <p>Click the run button to start running.</p>
               <ol>
               ")),
      column(img(src = "Run_MetEx.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 6. Run MetEx
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <ol>
               <h3 >7.3 Download result</h3>
               <p>Note: In the offline standalone program, you don't need to download, just check it directly in the set result file path.</p>
               </ol>
               ")),
      column(img(src = "Download_result.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 7. Download result
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <h3 >8. MetEx (Mutiple file)</h3>
               <p>Below we will introduce MetEx (Mutiple file): Use MetEx to annotate mutiple LC-MS files.</p>
               <ol>
               <h3 >8.1  Parameters</h3>
               <p>Except for the different parameters in the &#39;LC-MS data import&#39; part and &#39;Result (xlsx file) path&#39;, other parameters are the same as MetEx (Single file). The &#39;mzXML file path&#39; is a file folder in your computer which save mzXML files and the &#39;mgf file path&#39; is a file folder in your computer which save mgf files. Result (xlsx file) path is a path of a folder to save result files, for example, E:/MetEx/Result. And it is only available in the version of sffline standalone program.</p>
               <h3 >8.2 Run MetEx</h3>
               <p>Click the run button to start running</p>
               <h3 >8.3 Download result</h3>
               <p>Note: In the offline standalone program, you don't need to download, just check it directly in the set result file path.</p>
               </ol>
               <p>&nbsp;</p>
               <h3 >9. Classic annotation</h3>
               <p>Below we will introduce Classic annotation: Annotation from peak detection result.</p>
               <ol>
               <h3 >9.1 Parameters</h3>
               <ol>
               <h3 >	9.1.1 Database input</h3>
               <p>	same with 7.1.1</p>
               <h3 >	9.1.2 Retention time calibration</h3>
               <p>	same with 7.1.2</p>
               <h3 >	9.1.3 LC-MS data import</h3>
               <ol>
               <h3 >		9.1.3.1 MS1 peak table (.csv file)</h3>
               <p>		The peak detection result which is saved in csv file. We provided an example shown in (inst/extdata/peakTable). Two columns named &#39;mz&#39; and &#39;rt&#39; are necessary, other columns are not required.</p>
               <h3 >		9.1.3.2 mgf file path</h3>
               <p>		same with 7.1.3.2</p>
               </ol>
               <h3 >	9.1.4 Parameters of MetEx (MS1)</h3>
               <ol>
               <h3 >		9.1.4.1 Delta m/z of MS1</h3>
               <p>		same with 7.1.4.1</p>
               <h3 >		9.1.4.2 Delta tR of MS1</h3>
               <p>		It is slightly different from 7.1.4.2. 7.1.4.2 refers to the retention time range, and 9.1.4.2 refers to the retention time deviation, so 120 s in 7.1.4.2 and 60 s in 9.1.4.2 are equivalent.</p>
               </ol>
               <h3 >	9.1.5 Parameters of MetEx (MS2)</h3>
               <p>	same with 7.1.5</p>
               <h3 >	9.1.6 Other parameters</h3>
               <p>	same with 7.1.6</p>
               <h3 >	9.1.7 Advance parameters</h3>
               <p>	same with 7.1.7</p>
               </ol>
               <h3 >9.2 Run MetEx</h3>
               <p>Click the run button to start running.</p>
               <h3 >9.3 Download result</h3>
               <p>Note: In the offline standalone program, you don't need to download, just check it directly in the set result file path.</p>
               </ol>
               <p>&nbsp;</p>
               <h2 >How to use the web server?</h2>
               <h3 >1. Open MetEx web server</h3>
               <p>web server <a href='http://www.metaboex.cn/MetEx' target='_blank' class='url'>http://www.metaboex.cn/MetEx</a></p>
               ")),
      column(img(src = "Webserver_MetEx.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 8. Web server of MetEx
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <p>&nbsp;</p>
               <h3 >2. Overview of MetEx</h3>
               <p>You can see that web server of MetEx is same with the offline standalone software. The two are almost the same in use, so we won&#39;t repeat them here. Please note that the web server resources are limited. Please use offline standalone program as much as possible. If the running capacity of the server is exceeded, an error will be reported.</p>
               <p>&nbsp;</p>
               <h2 >How to use the R package?</h2>
               <h3 >1. Installation</h3>
               <ol>
               <h3 >1.1 Install R</h3>
               <p>If you don&#39;t have R language, install R first.   </p>
               <p><a href='https://cran.r-project.org/'>&gt;&gt; R download here</a><br/>Note: We developed MetEx in R 4.10.0. If you find problems when you use other versions, please contact us.<br/><a href='https://cran.r-project.org/bin/windows/base/old/'>&gt;&gt; The old version of R</a></p>
               <h3 >1.2 Install Rstudio </h3>
               <p>We recommended to install Rstudio owing to it is an integrated development environment (IDE) for R.<br/><a href='https://rstudio.com/products/rstudio/'>&gt;&gt; Rstudio download here</a></p>
               <h3 >1.3 Install MetEx</h3>
               <p>Install the R package &quot;devtools&quot; and other reliable packages, then install MetEx using codes below.
               <a href='https://cran.r-project.org/web/packages/devtools/index.html'>&gt;&gt;The devtools package</a></p>
               <pre><code>install.packages(c(&quot;devtools&quot;,&quot;BiocManager&quot;))
BiocManager::install(c(&quot;xcms&quot;,&quot;KEGGREST&quot;,&quot;DIAlignR&quot;,&quot;peakPantheR&quot;), update = TRUE, ask = FALSE)
devtools::install_github(&#39;bentrueman/fffprocessr&#39;)
devtools::install_github(&#39;zhengfj1994/MetEx&#39;)</code></pre>
               <p> It will take few minutes to download the packages.</p>
               <h3 >1.4 Offline install</h3>
               <p>If the third step fails to install, users can download the project and install offline as shown below:  </p>
               </ol>
               ")),
      column(img(src = "Offline-install-1.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 9. Download the MetEx package from github.
               ")),
      column(img(src = "Offline-install-2.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 10. Download the MetEx package from github(2).
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <p>Then, in Rstudio, choose Packages —— Install:  </p>
               ")),
      column(img(src = "Offline-install-3.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 11. Package intallation in Rstudio
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <p>Finally, choose install from Package Archive File (.zip; .tar.gz), and select the MetEx package, click install.</p>
               ")),
      column(img(src = "Offline-install-4.png", align = "center", width = "50%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 12. Choose the MetEx-master.zip and install.
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <ol>
               <h3 >1.5 Call MetEx</h3>
               <p>Call MetEx to see if the installation was successful.</p>
               <pre><code>library(MetEx)</code></pre>
               </ol>
               <h3 >2. Run shinyApp in Rstudio</h3>
               <p>Enter the following line of code:</p>
               <pre><code>shiny::runApp(system.file(&quot;extdata/shinyApp&quot;, package = &quot;MetEx&quot;))</code></pre>
               <p>Then you can run shinyApp in Rstudio.</p>
               ")),
      column(img(src = "Screen-shot-of-Shiny-App.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 13. Screen shot of Shiny App.
               ")),

      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               <h3 >3. Functions and their parameters</h3>
               <p>The main functions and their parameters in MetEx</p>
               <ol>
               <h3 >3.1 dbImporter</h3>
               <p>Import the database which saved in xlsx file.</p>
               <ul>
               <li>dbFile: the path of the database (xlsx file). </li>
               <li>ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is &quot;P&quot; and negative ion mode is &quot;N&quot;.</li>
               <li>CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is &quot;all&quot;.</li>
               </ul>
               <h3 >3.2 retentionTimeCalibration</h3>
               <p>Use internal standard retention to calibrate retention time of metabolites in database.</p>
               <ul>
               <li>is.tR.file: the xlsx file of IS retention times in database and in your experiment.</li>
               <li>database.df: the imported database data frame.</li>
               </ul>
               <h3 >3.3 targetExtraction.parallel</h3>
               <p>Targeted extraction of metabolites using m/z and retention time. </p>
               <ul>
               <li>msRawData: the LC-MS untargeted raw data in the formate of mzXML.  e.g. &quot;D:/github/MetEx/Example Data/mzXML/Urine-30V.mzXML&quot;.</li>
               <li>dbData: the imported dbData by the function named “dbImporter”.</li>
               <li>deltaMZ: the m/z window in targeted extraction.</li>
               <li>deltaTR: the retention time window in targeted extraction.</li>
               <li>trRange: the range of retention time used to calculate information entropy, the default value is 30 (second).</li>
               <li>m: a parameter used for peak detection, the default value is 200.</li>
               <li>cores: The CPU cores for parallel computing.</li>
               </ul>
               <h3 >3.4 extracResFilter</h3>
               <p>Filter the result of targeted extraction based on information entropy and peak height.</p>
               <ul>
               <li>targExtracRes: the result of the function named &quot;targetExtraction&quot;</li>
               <li>classficationMethod: use the SVM method or not. If you want to use SVM, the value is &quot;SVM&quot;, otherwise, the value is &quot;NoSVM&quot;. The default value is &quot;NoSVM&quot;.</li>
               <li>entroThre: When the classficationMethod is &quot;NoSVM&quot;, this parameter is meaningful, The value of information entropy.</li>
               <li>intThre: When the classficationMethod is &quot;NoSVM&quot;, this parameter is meaningful, The value of peak height.</li>
               </ul>
               <h3 >3.5 importMgf</h3>
               <p>Import the mgf file.</p>
               <ul>
               <li>mgfFile: the file of mgf. </li>
               </ul>
               <h3 >3.6 batchMS2Score.parallel</h3>
               <p>MS/MS similarity calculation.</p>
               <ul>
               <li>ms1Info: the result of extracResFilter.</li>
               <li>ms1DeltaMZ: the m/z tolerance between MS1 and MS2.</li>
               <li>ms2DeltaMZ: the m/z tolerance between MS2 in database and experiment.</li>
               <li>deltaTR: the retention time tolerance between MS1 and MS2 (second).</li>
               <li>mgfMatrix: the matrix of mgf that generate by the function named &quot;importMgf&quot;. mgfList$mgfMatrix</li>
               <li>mgfData: the R data of mgf that generate by the function named &quot;importMgf&quot;. mgfList$mgfData</li>
               <li>MS2.sn.threshold: MS2 S/N threshold, the default is 3.</li>
               <li>MS2.noise.intensity: The MS2 noise intensity, &quot;minimum&quot; or a number.</li>
               <li>MS2.missing.value.padding: The MS2 missing value padding method, two options are available, &quot;half&quot; and &quot;minimal.value&quot;. &quot;Half&quot; is referred to MS-DIAL and &quot;minimal&quot; is closer to the actual situation. And now we recommended &quot;minimal.value&quot;.</li>
               <li>ms2Mode: the MS2 acquisition mode which can be IDA and DIA. the default is &quot;ida&quot;, and another option &quot;dia&quot; is developing.</li>
               <li>scoreMode: &quot;obverse&quot; means dot product, &quot;reverse&quot; means reverse dot product, &quot;average&quot; means the mean of dot product and reverse dot product.</li>
               <li>diaMethod: when the ms2Mode is &quot;dia&quot;, you should input an txt file of the dia method. However, the function is in developing, so the default of diaMethod is &quot;NA&quot;.</li>
               <li>cores: The CPU cores for parallel computing.</li>

               </ul>
               <h3 >3.7 identifiedResFilter</h3>
               <p>Filter the identified result and generate an new xlsx file for saving the identification result.</p>
               <ul>
               <li>batchMS2ScoreResult: the result of batchMS2Score.</li>
               <li>MS2score: the MS2 score threshold (0-1).</li>

               </ul>
               <h3 >3.8 MetExAnnotation</h3>
               <p>Integration of the above functions, one line of code can complete the targeted extraction and annotation of metabolites.</p>
               <ul>
               <li>dbFile: the path of the database (xlsx file).  e.g. &quot;D:/github/MetEx/Example Data/Database/MSMLS database.xlsx&quot;.</li>
               <li>ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is &quot;P&quot; and negative ion mode is &quot;N&quot;.</li>
               <li>CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is &quot;all&quot;.</li>
               <li>tRCalibration: Calibrate retention time (T) or not (F). The default is F.</li>
               <li>is.tR.file: the xlsx file of IS retention times in database and in your experiment. If the tRCalibration is F, this parameter should be set as &quot;NA&quot;.</li>
               <li>msRawData: the LC-MS untargeted raw data in the formate of mzXML.</li>
               <li>MS1deltaMZ: the m/z window in targeted extraction.</li>
               <li>MS1deltaTR: the retention time window in targeted extraction.</li>
               <li>entroThre: When the classficationMethod is &quot;NoSVM&quot;, this parameter is meaningful, The value of information entropy.</li>
               <li>intThre: When the classficationMethod is &quot;NoSVM&quot;, this parameter is meaningful, The value of peak height.</li>
               <li>classficationMethod: use the SVM method or not. If you want to use SVM, the value is &quot;SVM&quot;, otherwise, the value is &quot;NoSVM&quot;. The default value is &quot;NoSVM&quot;.</li>
               <li>mgfFile: the file of mgf. </li>
               <li>MS2.sn.threshold: MS2 S/N threshold, the default is 3.</li>
               <li>MS2.noise.intensity: The MS2 noise intensity, &quot;minimum&quot; or a number.</li>
               <li>MS2.missing.value.padding: The MS2 missing value padding method, two options are available, &quot;half&quot; and &quot;minimal.value&quot;. &quot;Half&quot; is referred to MS-DIAL and &quot;minimal&quot; is closer to the actual situation. And now we recommended &quot;minimal.value&quot;.</li>
               <li>MS1MS2DeltaMZ: the m/z tolerance between MS1 and MS2.</li>
               <li>MS2DeltaMZ: the m/z tolerance between MS2 in database and experiment.</li>
               <li>MS1MS2DeltaTR: the retention time tolerance between MS1 and MS2 (second).</li>
               <li>scoreMode: &quot;obverse&quot; means dot product, &quot;reverse&quot; means reverse dot product, &quot;average&quot; means the mean of dot product and reverse dot product.</li>
               <li>MS2scoreFilter: the MS2 score threshold (0-1).</li>
               <li>cores: The CPU cores for parallel computing.</li>

               </ul>
               <h3 >3.9 annotationFromPeakTable.parallel</h3>
               <p>Annotation from peak table.</p>
               <ul>
               <li>peakTable: peak table in specific format.</li>
               <li>mgfFile: the file of mgf. </li>
               <li>database: the path of the database (xlsx file).  e.g. &quot;D:/github/MetEx/Example Data/Database/MSMLS database.xlsx&quot;.</li>
               <li>ionMode: the ion mode of the LC-MS, only support two values,  positive ion mode is &quot;P&quot; and negative ion mode is &quot;N&quot;.</li>
               <li>CE: the collision energy of MS/MS spectrum, it depended on the experimental MS/MS conditions and the CE value in databases. The default is &quot;all&quot;.</li>
               <li>tRCalibration: Calibrate retention time (T) or not (F). The default is F.</li>
               <li>is.tR.file: the xlsx file of IS retention times in database and in your experiment. If the tRCalibration is F, this parameter should be set as &quot;NA&quot;.</li>
               <li>MS1DeltaMZ: the m/z tolerance.</li>
               <li>MS1DeltaTR: the retention time tolerance.</li>
               <li>MS2.sn.threshold: MS2 S/N threshold, the default is 3.</li>
               <li>MS2.noise.intensity: The MS2 noise intensity, &quot;minimum&quot; or a number.</li>
               <li>MS2.missing.value.padding: The MS2 missing value padding method, two options are available, &quot;half&quot; and &quot;minimal.value&quot;. &quot;Half&quot; is referred to MS-DIAL and &quot;minimal&quot; is closer to the actual situation. And now we recommended &quot;minimal.value&quot;.</li>
               <li>ms2Mode: the MS2 acquisition mode which can be IDA and DIA. the default is &quot;ida&quot;, and another option &quot;dia&quot; is developing.</li>
               <li>diaMethod: when the ms2Mode is &quot;dia&quot;, you should input an txt file of the dia method. However, the function is in developing, so the default of diaMethod is &quot;NA&quot;.</li>
               <li>MS1MS2DeltaTR: the retention time tolerance between MS1 and MS2 (second).</li>
               <li>MS1MS2DeltaMZ: the m/z tolerance between MS1 and MS2.</li>
               <li>MS2DeltaMZ: the m/z tolerance between MS2 in database and experiment.</li>
               <li>scoreMode: &quot;obverse&quot; means dot product, &quot;reverse&quot; means reverse dot product, &quot;average&quot; means the mean of dot product and reverse dot product.</li>
               <li>cores: The CPU cores for parallel computing.</li>
               </ol>
               </ul>
               <p>&nbsp;</p>
               <h3 >4. Examples</h3>
               <p>MetEx provide two approaches to annotate metabolites. The first approach is peak-detection-independent method and the second is peak-detection-dependent method. The first approach is newly developed and could avoid the peak loss in conventional peak detection methods.</p>
               <ul>
               <li><p>Peak-detection-independent metabolite annotation method without retention time calibration (signal LC-MS data):  </p>
               <ol>
               <li><p>Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (<a href='http://proteowizard.sourceforge.net/tools.shtml' target='_blank' class='url'>http://proteowizard.sourceforge.net/tools.shtml</a>, provided by ProteoWizard). </p>
               </li>
               <li><p>We used the built-in data files as examples to shown how to do the annotation. the database is:</p>
               <pre><code>system.file(&quot;extdata/database&quot;, &quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;)</code></pre>
               <p>The mzXML file is:</p>
               <pre><code>system.file(&quot;extdata/mzXML&quot;, &quot;example.mzXML&quot;, package = &quot;MetEx&quot;)</code></pre>
               <p>The mgf file is:</p>
               <pre><code>system.file(&quot;extdata/mgf&quot;, &quot;example.mgf&quot;, package = &quot;MetEx&quot;)</code></pre>
               <p>The codes used the example data above to do annotation is shown below:</p>
               </li>

               </ol>
               <pre><code class='language-r' lang='r'>library(MetEx)
dbData &lt;- dbImporter(dbFile = system.file(&quot;extdata/database&quot;, &quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;), ionMode = &#39;P&#39;, CE = &quot;all&quot;) # If you want to use other database, just change the dbFile to your own database such as &quot;D:/MyCompoundDatabase.xlsx&quot;
targExtracRes &lt;- targetExtraction.parallel(msRawData = system.file(&quot;extdata/mzXML&quot;, &quot;example.mzXML&quot;, package = &quot;MetEx&quot;), dbData, deltaMZ=0.01, deltaTR=60, cores = 1) # If you want to use your own data, just change the msRawData to your own data such as &quot;D:/My-mzXML-data.mzXML&quot;
ms1Info &lt;- extracResFilter(targExtracRes, entroThre = 2, intThre = 270)
mgfList &lt;- importMgf(mgfFile=system.file(&quot;extdata/mgf&quot;, &quot;example.mgf&quot;, package = &quot;MetEx&quot;)) # If you want to use you own data, just change the mgfFile to your own data such as &quot;D:/My-mgf-data.mgf&quot;
batchMS2ScoreResult &lt;- batchMS2Score.parallel(ms1Info, ms1DeltaMZ = 0.01, ms2DeltaMZ = 0.02, deltaTR = 12, mgfMatrix = mgfList$mgfMatrix, mgfData = mgfList$mgfData, scoreMode = &quot;average&quot;, cores = 1)
write.table(batchMS2ScoreResult, file = &quot;D:/Example-result.csv&quot;, col.names = NA, sep = &quot;,&quot;, dec = &quot;.&quot;, qmethod = &quot;double&quot;)
identifiedResFilterRes &lt;- identifiedResFilter(batchMS2ScoreResult, MS2score=0.6)
openxlsx::write.xlsx(identifiedResFilterRes, file = &quot;D:/Example-result.xlsx&quot;)</code></pre>
               <p>		We also provide a one-line code method to implement the metabolites targeted extraction and annotation.</p>
               <pre><code class='language-r' lang='r'>library(MetEx)
MetExAnnotationRes &lt;- MetExAnnotation(dbFile = system.file(&quot;extdata/database&quot;, &quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;),
                                         ionMode = &quot;P&quot;,
                                         msRawData = system.file(&quot;extdata/mzXML&quot;, &quot;example.mzXML&quot;, package = &quot;MetEx&quot;),
                                         MS1deltaMZ = 0.01,
                                         MS1deltaTR = 120,
                                         entroThre = 2,
                                         intThre = 270,
                                         mgfFile = system.file(&quot;extdata/mgf&quot;, &quot;example.mgf&quot;, package = &quot;MetEx&quot;),
                                         MS1MS2DeltaMZ = 0.01,
                                         MS2DeltaMZ = 0.02,
                                         MS1MS2DeltaTR = 12,
                                         MS2scoreFilter = 0.6)
openxlsx::write.xlsx(MetExAnnotationRes, file = &quot;D:/Example-result.xlsx&quot;)</code></pre>
               </li>
               <li><p>Peak-detection-independent metabolite annotation method with retention time calibration (signal LC-MS data):</p>
               <ol>
               <li><p>Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (<a href='http://proteowizard.sourceforge.net/tools.shtml' target='_blank' class='url'>http://proteowizard.sourceforge.net/tools.shtml</a>, provided by ProteoWizard). </p>
               </li>
               <li><p>We used the built-in data files as examples to shown how to do the annotation. </p>
               </li>
               <li><p>The retention time of IS used for retention time calibration is:</p>
               <pre><code>system.file(&quot;extdata/trCalibration&quot;, &quot;IS-for-tR-calibration.xlsx&quot;, package = &quot;MetEx&quot;)
               </code></pre>
               <p>If you want to calibrate retention times, you should get the experimental retention time of internal standards which are concluded in &quot;IS for retention time calibration.xlsx&quot; and mentioned in our published paper. Write them in the xlsx file.</p>
               </li>
               <li><p>The codes used the example data above to do annotation is shown below:</p>
               <pre><code class='language-r' lang='r'>library(MetEx)
dbData &lt;- dbImporter(dbFile = system.file(&quot;extdata/database&quot;, &quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;), ionMode = &#39;P&#39;, CE = &quot;all&quot;) # If you want to use other database, just change the dbFile to your own database such as &quot;D:/MyCompoundDatabase.xlsx&quot;
dbData &lt;- retentionTimeCalibration(is.tR.file = system.file(&quot;extdata/trCalibration&quot;, &quot;IS-for-tR-calibration.xlsx&quot;, package = &quot;MetEx&quot;), database.df = dbData)  # The xlsx file is just an example, if you want to calibrate the retention time, please change the file to yours such as &quot;D:/MyCompoundDatabase.xlsx&quot;
targExtracRes &lt;- targetExtraction.parallel(msRawData=system.file(&quot;extdata/mzXML&quot;, &quot;example.mzXML&quot;, package = &quot;MetEx&quot;), dbData, deltaMZ=0.01, deltaTR=60, cores = 1) # If you want to use your own data, just change the msRawData to your own data such as &quot;D:/My-mzXML-data.mzXML&quot;
ms1Info &lt;- extracResFilter(targExtracRes, entroThre = 2, intThre = 270)
mgfList &lt;- importMgf(mgfFile=system.file(&quot;extdata/mgf&quot;, &quot;example.mgf&quot;, package = &quot;MetEx&quot;)) # If you want to use you own data, just change the mgfFile to your own data such as &quot;D:/My-mgf-data.mgf&quot;
batchMS2ScoreResult &lt;- batchMS2Score.parallel(ms1Info, ms1DeltaMZ = 0.01, ms2DeltaMZ = 0.02, deltaTR = 12, mgfMatrix = mgfList$mgfMatrix, mgfData = mgfList$mgfData, scoreMode = &quot;average&quot;, cores = 1)
write.table(batchMS2ScoreResult, file = &quot;D:/Example-result.csv&quot;, col.names = NA, sep = &quot;,&quot;, dec = &quot;.&quot;, qmethod = &quot;double&quot;)
identifiedResFilterRes &lt;- identifiedResFilter(batchMS2ScoreResult, MS2score=0.6)
openxlsx::write.xlsx(identifiedResFilterRes, file = &quot;D:/Example-result.xlsx&quot;)</code></pre>
               <p>We also provide a one-line code method to implement the metabolites targeted extraction and annotation.</p>
               <pre><code class='language-r' lang='r'>library(MetEx)
MetExAnnotationRes &lt;- MetExAnnotation(dbFile = system.file(&quot;extdata/database&quot;, &quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;),
                                         ionMode = &quot;P&quot;,
                                         tRCalibration = T,
                                         is.tR.file =  system.file(&quot;extdata/trCalibration&quot;, &quot;IS-for-tR-calibration.xlsx&quot;, package = &quot;MetEx&quot;),
                                         msRawData = system.file(&quot;extdata/mzXML&quot;, &quot;example.mzXML&quot;, package = &quot;MetEx&quot;),
                                         MS1deltaMZ = 0.01,
                                         MS1deltaTR = 120,
                                         entroThre = 2,
                                         intThre = 270,
                                         mgfFile = system.file(&quot;extdata/mgf&quot;, &quot;example.mgf&quot;, package = &quot;MetEx&quot;),
                                         MS1MS2DeltaMZ = 0.01,
                                         MS2DeltaMZ = 0.02,
                                         MS1MS2DeltaTR = 12,
                                         MS2scoreFilter = 0.6)
openxlsx::write.xlsx(MetExAnnotationRes, file = &quot;D:/Example-result.xlsx&quot;)</code></pre>
               </li>

               </ol>
               </li>
               <li><p>Peak-detection-independent metabolite annotation without retention time calibration (multiple LC-MS data): </p>
               <ol>
               <li><p>Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (<a href='http://proteowizard.sourceforge.net/tools.shtml' target='_blank' class='url'>http://proteowizard.sourceforge.net/tools.shtml</a>, provided by ProteoWizard). </p>
               </li>
               <li><p>Create a new folder,  such as &quot;Data for MetEx&quot;, then create three new subfolders named &quot;mzXML&quot;, &quot;mgf&quot; and &quot;result&quot; under the folder.</p>
               </li>
               <li><p>The codes used the example data above to do annotation is shown below:</p>
               <pre><code class='language-r' lang='r'>library(MetEx)
path &lt;- &quot;E:/Data for MetEx&quot;
mzXML.files &lt;- dir(paste0(path,&quot;/mzXML&quot;))
mgf.files &lt;- gsub(&quot;.mzXML&quot;, &quot;.mgf&quot;, mzXML.files)
index.files &lt;- gsub(&quot;.mzXML&quot;, &quot;&quot;, mzXML.files)
for (i in c(1:length(mzXML.files))){
     print(index.files[i])
     MetExAnnotationRes &lt;- MetExAnnotation(dbFile = system.file(&quot;extdata/database&quot;, &quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;),
                                              ionMode = &quot;P&quot;,
                                              msRawData = paste0(path,&quot;/mzXML/&quot;,mzXML.files[i]),
                                              MS1deltaMZ = 0.01,
                                              MS1deltaTR = 120,
                                              entroThre = 2,
                                              intThre = 270,
                                              mgfFile = paste0(path,&quot;/mgf/&quot;, mgf.files[i]),
                                              MS1MS2DeltaMZ = 0.01,
                                              MS2DeltaMZ = 0.02,
                                              MS1MS2DeltaTR = 12,
                                              MS2scoreFilter = 0.6)
     openxlsx::write.xlsx(MetExAnnotationRes, file = paste0(path, &quot;/&quot;, index.files[i], &quot;.xlsx&quot;))
}</code></pre>
               </li>

               </ol>
               </li>
               <li><p>Peak-detection-independent metabolite annotation method with retention time calibration (multiple LC-MS data):  </p>
               <ol>
               <li><p>Convert the LC-MS raw data to .mzXML and .mgf file using MSConvert (<a href='http://proteowizard.sourceforge.net/tools.shtml' target='_blank' class='url'>http://proteowizard.sourceforge.net/tools.shtml</a>, provided by ProteoWizard). </p>
               </li>
               <li><p>Create a new folder,  such as &quot;Data for MetEx&quot;, then create three new subfolders named &quot;mzXML&quot;, &quot;mgf&quot; and &quot;result&quot; under the folder.</p>
               </li>
               <li><p>The codes used the example data above to do annotation is shown below:</p>
               <pre><code class='language-r' lang='r'>library(MetEx)
path &lt;- &quot;E:/Data for MetEx&quot;
mzXML.files &lt;- dir(paste0(path,&quot;/mzXML&quot;))
mgf.files &lt;- gsub(&quot;.mzXML&quot;, &quot;.mgf&quot;, mzXML.files)
index.files &lt;- gsub(&quot;.mzXML&quot;, &quot;&quot;, mzXML.files)
for (i in c(1:length(mzXML.files))){
     print(index.files[i])
     MetExAnnotationRes &lt;- MetExAnnotation(dbFile = system.file(&quot;extdata/database&quot;, &quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;),
                                              ionMode = &quot;P&quot;,
                                              tRCalibration = T,
                                              is.tR.file = system.file(&quot;extdata/trCalibration&quot;, &quot;IS-for-tR-calibration.xlsx&quot;, package = &quot;MetEx&quot;),
                                              msRawData = paste0(path,&quot;/mzXML/&quot;,mzXML.files[i]),
                                              MS1deltaMZ = 0.01,
                                              MS1deltaTR = 120,
                                              entroThre = 2,
                                              intThre = 270,
                                              mgfFile = paste0(path,&quot;/mgf/&quot;, mgf.files[i]),
                                              MS1MS2DeltaMZ = 0.01,
                                              MS2DeltaMZ = 0.02,
                                              MS1MS2DeltaTR = 12,
                                              MS2scoreFilter = 0.6)
     openxlsx::write.xlsx(MetExAnnotationRes, file = paste0(path, &quot;/&quot;, index.files[i], &quot;.xlsx&quot;))
}</code></pre>
               </li>

               </ol>
               </li>
               <li><p>Peak-detection-dependent method:</p>
               <ul>
               <li><p>MetEx is focus on targeted extraction and annotation without peak detection. But we consider that the annotation method based on the result of peak detection is still used by many researchers, we also provided the annotation method based on peak detection.</p>
               </li>
               <li><pre><code class='language-r' lang='r'># Without tR calibration
library(MetEx)
annotationFromPeakTableRes &lt;- annotationFromPeakTable.parallel(
               peakTable = system.file(&quot;extdata/peakTable&quot;,&quot;example.csv&quot;, package = &quot;MetEx&quot;),
               mgfFile = system.file(&quot;extdata/mgf&quot;,&quot;example.mgf&quot;, package = &quot;MetEx&quot;),
               database = system.file(&quot;extdata/database&quot;,&quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;),
               ionMode = &quot;P&quot;,
               MS1DeltaMZ = 0.01,
               MS1DeltaTR = 120,
               MS1MS2DeltaTR = 5,
               MS1MS2DeltaMZ = 0.01,
               MS2DeltaMZ = 0.02,
               cores = 1)
openxlsx::write.xlsx(annotationFromPeakTableRes, file = &quot;D:/Example-result.xlsx&quot;)</code></pre>
               <pre><code class='language-r' lang='r'># With tR calibration
library(MetEx)
annotationFromPeakTableRes &lt;- annotationFromPeakTable.parallel(
               peakTable = system.file(&quot;extdata/peakTable&quot;,&quot;example.csv&quot;, package = &quot;MetEx&quot;),
               mgfFile = system.file(&quot;extdata/mgf&quot;,&quot;example.mgf&quot;, package = &quot;MetEx&quot;),
               database = system.file(&quot;extdata/database&quot;,&quot;MetEx_OSI+MSMLS.xlsx&quot;, package = &quot;MetEx&quot;),
               ionMode = &quot;P&quot;,
               tRCalibration = T,
               is.tR.file = system.file(&quot;extdata/trCalibration&quot;, &quot;IS-for-tR-calibration.xlsx&quot;, package = &quot;MetEx&quot;),
               MS1DeltaMZ = 0.01,
               MS1DeltaTR = 120,
               MS1MS2DeltaTR = 5,
               MS1MS2DeltaMZ = 0.01,
               MS2DeltaMZ = 0.02,
               cores = 1)
               openxlsx::write.xlsx(annotationFromPeakTableRes, file = &quot;D:/Example-result.xlsx&quot;)</code></pre>
               </li>

               </ul>
               </li>
               </ul>
               <p>&nbsp;</p>
               <h2 >The uniform database format</h2>
               <ul>
               <li><p>The database is stored in .xlsx file. And the first row is column names. Column names are specific, and using an irregular column name would make the database unrecognizable. The database should containing these columns:</p>
               <ul>
               <li><p>confidence_level : Compounds with level 1 have accurate mass, experimental tR and experimental MS2 data. Compounds with level 2 have accurate mass, predicted tR and experimental MS2 data. Compounds with level 3 have accurate mass, predicted tR and predicted MS2 data.</p>
               </li>
               <li><p>ID: The compound ID in database</p>
               </li>
               <li><p>Name: the compound name.</p>
               </li>
               <li><p>Formula</p>
               </li>
               <li><p>ExactMass: MW</p>
               </li>
               <li><p>SMILES</p>
               </li>
               <li><p>InChIKey</p>
               </li>
               <li><p>CAS</p>
               </li>
               <li><p>CID</p>
               </li>
               <li><p>ionMode : the ion mode of LC-MS, positive ion mode is P and negative ion mode is N.</p>
               </li>
               <li><p>Adduct</p>
               </li>
               <li><p>m/z: the accurate mass in LC-MS</p>
               </li>
               <li><p>tr: the retention time (in second)</p>
               </li>
               <li><p>CE: collision energy.</p>
               </li>
               <li><p>MSMS: the MS/MS spectrum. The ion and its intensity are separated by a space (&quot; &quot;), and the ion and the ion are separated by a semicolon (&quot;;&quot;). For example: 428.036305927272 0.0201115093588212;524.057195188813 0.0699256604274525;542.065116124274 0.148347272003186;664.112740221342 1 is the abbreviate of MS/MS spectrum below:  </p>
               <figure><table>
               <thead>
               <tr><th style='text-align:center;' >m/z</th><th style='text-align:center;' >intensity</th></tr></thead>
               <tbody><tr><td style='text-align:center;' >428.036305927272&nbsp&nbsp&nbsp&nbsp</td><td style='text-align:center;' >0.0201115093588212</td></tr><tr><td style='text-align:center;' >524.057195188813&nbsp&nbsp&nbsp&nbsp</td><td style='text-align:center;' >0.0699256604274525</td></tr><tr><td style='text-align:center;' >542.065116124274&nbsp&nbsp&nbsp&nbsp</td><td style='text-align:center;' >0.148347272003186</td></tr><tr><td style='text-align:center;' >664.112740221342&nbsp&nbsp&nbsp&nbsp</td><td style='text-align:center;' >1</td></tr></tbody>
               </table></figure>
               </li>
               <li><p>Instrument_type: for example, Q-TOF.</p>
               </li>
               <li><p>Instrument: for example, AB 5600 +</p>
               </li>
               <li><p>Other information is not mandatory, and users can add it as they see fit.  We have gave an example of database in data.</p>
               ")),
      column(img(src = "example-of-database.png", align = "center", width = "85%"), align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
          HTML("
               Figure 13. An example of database.
               ")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("
               </li>
               </ul>
               </li>
               </ul>
               <h2 >Supported database</h2>
               <ul>
               <li><p>OSI-SMMS: Our in-house database, containing ~2000 metabolites in positive or negative ion modes.</p>
               </li>
               <li><p>MSMLS: Acquired by Mass Spectrometry Metabolite Library (MSMLS) supplied by IROA Technologies. containing ~300 metabolites.</p>
               </li>
               <li><p>MoNA: Download from MoNA and transfer it to the format used for MetEx. The retention time is predicted.</p>
               <ul>
               <li><p>And we provided the method to transfer the MoNA database (saved in MSP) to the format used for MetEx:</p>
               </li>
               <li><pre><code>library(MetEx)
library(openxlsx)
mspData &lt;- readMsp(file = &quot;D:/MoNA-export-All_Spectra.msp&quot;) # The file path should change to yours.
mspDataframe &lt;- exactMsp(mspData)
write.xlsx(mspDataframe, file = &quot;D:/MoNA used for MetEx.xlsx&quot;) # The file path should change to yours.</code></pre>
               </li>
               <li><p>The retention time prediction method can be seen in the Part of Retention time prediction.</p>
               </li>

               </ul>
               </li>
               <li><p>KEGG: Download from KEGG and transfer it to the format used for MetEx. The retention time and MS/MS spectrum are predicted.</p>
               <ul>
               <li><p>We provided the method to download KEGG and transfer it to the format used for MetEx:</p>
               </li>
               <li><pre><code>library(MetEx)
kegg.compound.database.df &lt;- KEGGdownloader()
write.xlsx(kegg.compound.database.df, file = &quot;D:/KEGG used for MetEx.xlsx&quot;) # The file path should change to yours.</code></pre>
               </li>
               <li><p>The retention time prediction method can be seen in the Part of Retention time prediction.</p>
               </li>
               <li><p>The MS/MS spectrum prediction method can be seen in the Part of MS/MS spectrum prediction. </p>
               </li>

               </ul>
               </li>
               <li><p>Other databases（Constantly updating ... ...）</p>
               </li>
               <li><p>User-defined database: All users can defined their own database by our database format. And we will add more database in MetEx.</p>
               </li>

               </ul>
               <p>&nbsp;</p>
               <h2 >Retention time prediction</h2>
               <p>GNN-RT (<a href='https://github.com/Qiong-Yang/GNNRT' target='_blank' class='url'>https://github.com/Qiong-Yang/GNNRT</a>) was used for retention time prediction in multiple chromatographic systems.</p>
               <p>&nbsp;</p>
               <h2 >Maintainers</h2>
               <p>Fujian Zheng <a href='mailto:zhengfj@dicp.ac.cn' target='_blank' class='url'>zhengfj@dicp.ac.cn</a> or <a href='mailto:2472700387@qq.com' target='_blank' class='url'>2472700387@qq.com</a></p>
               ")),
      column(3)

  )
)
)
