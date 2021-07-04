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
        12,
        div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
            HTML("~~ <em>Dear Users, Welcome to MetEx</em> ~~")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:150%;margin-top:20px",
            HTML("MetEx provides three versions for different application scenarios, and users can choose the right version according to their actual requirements. The three versions are:
                 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='https://github.com/zhengfj1994/MetEx' target='_blank'>Offline standalone program</a>;
                 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='http://www.metaboex.cn/MetEx/' target='_blank'>web server</a>;
                 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='https://github.com/zhengfj1994/MetEx' target='_blank'>R package</a>.
                 <br>The tutorials for using the three versions are as follows:"))
      ),
      column(
        width = 12,
        div(style="text-align:left;margin-top:10px;font-size:180%;color:darkred",
            HTML("<em>Offline standalone program</em>")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("Offline standalone program is our most recommended for the reason that it is the most robust. Especially when MetEx processes raw data with a large file size, it consumes more computing resources. Therefore, a powerful computer is required, which may exceed the computing power provided by the server. The detials about how to use the offline standalone program is shown as below:")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("1. Download the offline standalone.")),
        column(img(src = "MetExAppZip.png", align = "center", width = "10%"),
               align = "center", width = 12),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("2. Unzip the offline standalone.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("3. Please ensure that there is a browser available on your computer, because the MetEx program will be opened in your default browser. We tested Google Chrome browser, Microsoft Edge browser, 360 speed browser, all of which can run MetEx.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("4. There is a file named MetEx.vbs in the decompressed folder. Double-click the file. Please wait patiently. The loading of the operating environment may take about 1 minute.")),
        column(img(src = "Unzipped_MetExApp.png", align = "center", width = "25%"),
               align = "center", width = 12),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("5. Then you can see the MetEx page is opened in your default browser.")),
        column(img(src = "Page_MetEx.png", align = "center", width = "90%"),
               align = "center", width = 12),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("6. You can see that there are some options to choose from on the left side of the MetEx page, namely Introduction, MetEx (Single file), MetEx (Mutilple), Classic annotation, Other software tools, Help document, Update. If you want to annotate a mass spectrum file with MetEx, please select MetEx (Single file). If you want to annotate multiple mass spectrum files, and multiple mass spectrum files will eventually be merged into one table, please select MetEx (Mutilple). If you want to annotate compounds based on the results of peak matching, please select Classic annotation.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("7. Below we will introduce MetEx (Single file): Use MetEx to annotate a single LC-MS file.")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1. Parameters:  On the page of MetEx (Single file), you can see that there are some parameters that need to be set. Their meanings and recommended values are as follows: <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.1 Database input：<br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.1.1 Database: A database file that meets MetEx's formatting requirements. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.1.2 Ion mode: The ion mode used for annotation, 'positive' or 'negative'. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.1.3 CE: Collision energy used for MS/MS acquisition, 'all', 'low', 'medium' or 'high'. Only when the low, medium and high collision energies of the database are 15, 30, 45 eV, the 'low', 'medium' and 'high' options can be used, otherwise, please use the 'all' option. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.2 Retention time calibration：<br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.2.1 Whether to perform tR calibration: 'Yes' means the tR prediction will be preformed and you should provide an xlsx for tR prediction. 'No' means tR prediction will not be preformed. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.2.2 tR of internal standards: a xlsx file, which contain the retention time of internal standards in database and experiment. It should be looked like Figure 7. <br>")),
        column(img(src = "IS-for-tR-calibration.png", align = "center", width = "50%"),
               align = "center", width = 12),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
            HTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.3 LC-MS data import <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.3.1 mzXML file: The mzXML file which is transfered from raw LC-MS data (by using MSconvert in proteowizard). <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.3.2 mgf file: The mgf file which is transfered from raw LC-MS data (by using MSconvert in proteowizard). <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.4 Parameters of MetEx (MS1) <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.4.1 Delta m/z of MS1: The tolerance of MS1 between database and experiment (0.01 Da is recommended for Q-TOF and 0.005 Da is recommended for Obitrap). <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.4.2 Delta tR of MS1: the tolerance of retention time between database and experiment. The unit is seconds. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.4.3 Entropy threshold: The information entropy threshold, 1.75 - 2 is recommended. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.4.4 Intensity threshold: The peak height threshold. 600-270 is recommended for Q-TOF. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.5 Parameters of MetEx (MS2) <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.5.1 Delta m/z of MS1 and MS2: The tolerance between MS1 and MS2 in experiment. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.5.2 Delta m/z of MS2: The tolerance of MS2 between database and experiment. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.5.3 Delta tR of MS1 and MS2: The tolerance of tR between MS1 and MS2 <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.5.4 MS2 score threshold: The MS2 score threshold (0-1) <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.6 Other parameters <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.6.1 Number of cores for parallel computing: The number of CPU cores for parallel computing, it is depend on your computer's CPU and RAM. Users can refer to the following rules: The number of cores for parallel computing < The number of CPU cores of your computer & The number of cores for parallel computing × 4 GB < The RAM of you computer<br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.6.2 show/hide Advance parameters <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.7 Advance parameters <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.7.1 MS2 S/N threshold: The MS2 S/N threshold <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.7.2 MS2 noise intensity: The MS2 noise intensity, 'minimum' or a number. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 7.1.7.3 MS2 missing value padding method: The MS2 missing value padding method, two options are available, 'half' and 'minimal'. 'half' is referred to MS-DIAL and 'minimal' is closer to the actual situation. And now we recommended 'minimal'. <br>")),
      ),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("&nbsp;&nbsp;&nbsp;&nbsp;
               7.2. Click the run button to start running")),
      column(img(src = "Run_MetEx.png", align = "center", width = "75%"),
             align = "center", width = 12),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("&nbsp;&nbsp;&nbsp;&nbsp;
               7.3. Download the results.")),
      column(img(src = "Download_result.png", align = "center", width = "75%"),
             align = "center", width = 12),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("8. Below we will introduce MetEx (Mutiple file): Use MetEx to annotate mutiple LC-MS files.")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("&nbsp;&nbsp;&nbsp;&nbsp;
               8.1. Parameters: Except for the different parameters in the 'LC-MS data import' part, other parameters are the same as MetEx (Single file) The 'mzXML file path' is a file folder in your computer which save mzXML files and the 'mgf file path' is a file folder in your computer which save mgf files.")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("&nbsp;&nbsp;&nbsp;&nbsp;
               8.2. Click the run button to start running")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("&nbsp;&nbsp;&nbsp;&nbsp;
               8.3. Download the results.")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("9. Below we will introduce Classic annotation: Annotation from peak detection result.")),
      div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
          HTML("&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1. Parameters:  On the page of Classic annotation, you can see that there are some parameters that need to be set. Their meanings and recommended values are as follows: <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.1 Database input：same with 7.1.1 <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.2 Retention time calibration：same with 7.1.2 <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.3 LC-MS data import: <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.3.1 MS1 peak table (.csv file): The peak detection result which is saved in csv file. We provided an example shown in (inst/extdata/peakTable). Two columns named 'mz' and 'rt' are necessary, other columns are not required. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.3.2 mgf file path: same with 7.1.3.2 <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.4 Parameters of MetEx (MS1): <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.4.1 Delta m/z of MS1: same with 7.1.4.1 <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.4.2 Delta tR of MS1: It is slightly different from 7.1.4.2. 7.1.4.2 refers to the retention time range, and 9.1.4.2 refers to the retention time deviation, so 120 s in 7.1.4.2 and 60 s in 9.1.4.2 are equivalent. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.5 Parameters of MetEx (MS2): same with 7.1.5 <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 9.1.6 Other parameters: same with 7.1.6 <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;
                 9.2. Click the run button to start running. <br>
                 &nbsp;&nbsp;&nbsp;&nbsp;
                 9.3. Download the results. <br>
                 ")),

      column(3)
    )
  )
)


