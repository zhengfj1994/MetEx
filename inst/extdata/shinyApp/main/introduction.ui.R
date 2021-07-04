fluidPage(
  # helpText(h3("MetEx is a calculation tool for metabolite annotation. It can easily mine metabolite information directly from raw data. We provide the R package, web server version and offline shiny UI version of MetEx, and the three will be updated simultaneously.")),
  # hr(),
  # img(src = "The_workflow_of_MetEx.png", align = "center", width = "100%"),
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
            HTML("~~ <em>Welcome to MetEx</em> ~~")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:150%;margin-top:20px",
            HTML("<b>MetEx</b> is a computational tool for metabolite targered extraction and annotation based on databases. The process of MetEx is convenient and so that we believe that it will narrow the gap between LC-MS raw data and annotated metabolites. MetEx was provided in three forms:
                 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='https://github.com/zhengfj1994/MetEx' target='_blank'>R package</a>: Please refer to the github (https://github.com/zhengfj1994/MetEx) for the specific installation method of the R package. This version is very suitable for users with a certain R foundation.
                 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='http://www.metaboex.cn/MetEx/' target='_blank'>web server</a>: The URL of the web server is http://www.metaboex.cn/MetEx/. It can be used directly by opening it in a browser. However, the server resources are limited. When processing large files or multiple files, we recommend using offline independent programs or R language packages.
                 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='https://github.com/zhengfj1994/MetEx' target='_blank'>Offline standalone program</a>: After downloading the offline independent program, decompress it, install the instructions in it and use it.
                 <br>The three forms will be updated simultaneously.")),
        div(style="text-align:center;margin-top: 50px",
            a(href='#',
              img(src='The_workflow_of_MetEx.png', align = "center", width = "80%"))),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;margin-top:20px;font-size:150%",
            HTML("The basic logic of annotation is as follows:<br />"),
            HTML("&nbsp;&nbsp;1. Construction of a database containing retention times, accurate mass and MS/MS information;<br />"),
            HTML("&nbsp;&nbsp;2. Prepare the original data and convert them into mzXML and mgf formats;<br />"),
            HTML("&nbsp;&nbsp;3. Choose appropriate annotation methods and parameters;<br />"),
            HTML("&nbsp;&nbsp;4. Download result;<br />"),
            HTML("Detailed introduction can be found in the <em><b>Help document</b></em> part.<br />"),
            HTML("<br />"),
            HTML("Currently we provide three databases, MSMLS, MoNA and KEGG, and we plan to add more types of databases in the future. If you have any questions and good suggestions, we welcome you to contact Zheng Fujian at <u>zhengfj@dicp.ac.cn</u>.")),

        div(style="text-align:center;margin-top:20px;font-size:150%;color:darkgreen",
            HTML("<br />"),
            HTML("^_^ <em>Enjoy yourself in MetEx. Have a nice day</em> ^_^")),
        tags$hr(style="border-color: grey60;"),
        div(style="text-align:center;margin-top: 20px;font-size:120%",
            HTML(" &copy; 2021 <a href='http://www.402.dicp.ac.cn/index.htm' target='_blank'>Guowang Xu's Group</a>. All Rights Reserved.")),
        div(style="text-align:center;margin-bottom: 20px;font-size:120%",
            HTML("&nbsp;&nbsp; Created by Fujian Zheng. E-mail: <u>zhengfj@dicp.ac.cn</u>."))
      ),
      column(3)
    )
  )
)


