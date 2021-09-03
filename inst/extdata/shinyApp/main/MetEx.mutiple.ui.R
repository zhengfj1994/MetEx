fluidPage(
  fluidRow(id = "parameters.3",
           column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
                      HTML("~~ <em>MetEx for mutiple file. Please use in offline standalone program. </em> ~~")),
                  align = "center", width = 12),
           box(
             id = "Database.input.3",
             h3("Database input"),
             fileInput(inputId = "db.path.3", label = "Database", multiple = F),
             selectInput("ionMode.3", label = "Ion mode",
                         choices = list("Positive" = "P", "Negative" = "N"),
                         selected = "P"),
             selectInput("CE.3", label = "CE",
                         choices = list("all" = "all", "Low" = 15, "Medium" = 30, "high" = 45),
                         selected = "all"),
             width = 4,
             height = 350,
           ),
           box(
             id = "Retention.time.calibration.3",
             h3("Retention time calibration"),
             h4("If you don't want to calibrate retention time, just ignore this part."),
             # Whether to perform tR calibration
             selectInput("tRCalibration.3", label = "Whether to perform tR calibration",
                         choices = list("Yes" = T, "No" = F),
                         selected = F),
             fileInput(inputId = "is.tR.file.3", label = "tR of internal standards", multiple = F),
             width = 4,
             height = 350
           ),
           box(
             id = "LC-MS.data.import.3",
             h3("LC-MS data import"),
             textInput("msRawData.3", label = "mzXML file path"),
             textInput("mgfFile.3", label = "mgf file path"),
             width = 4,
             height = 350
           ),
           box(
             id = "Parameters.of.MS1.3",
             h3("Parameters of MetEx (MS1)"),
             numericInput(inputId = "MS1deltaMZ.3", label = "Delta m/z of MS1", value = 0.01),
             numericInput(inputId = "MS1deltaTR.3", label = "Delta tR of MS1", value = 60),
             numericInput(inputId = "entroThre.3", label = "Entropy threshold", value = 2),
             numericInput(inputId = "intThre.3", label = "Intensity threshold", value = 270),
             width = 4,
             height = 400
           ),
           box(
             id = "Parameters.of.MS2.3",
             h3("Parameters of MetEx (MS2)"),
             numericInput(inputId = "MS1MS2DeltaMZ.3", label = "Delta m/z of MS1 and MS2", value = 0.01),
             numericInput(inputId = "MS2DeltaMZ.3", label = "Delta m/z of MS2", value = 0.02),
             numericInput(inputId = "MS1MS2DeltaTR.3", label = "Delta tR of MS1 and MS2", value = 12),
             numericInput(inputId = "MS2scoreFilter.3", label = "MS2 score threshold", value = 0.6),
             width = 4,
             height = 400
           ),
           box(
             id = "Other.parameters.3",
             h3("Other parameters"),
             # textInput("csvFile.3", label = "Result (csv file) path", value = "/download/test/result"),
             textInput("xlsxFile.3", label = "Result (xlsx file) path", value = "E:/test"),
             sliderInput("cores.3", "Number of cores for parallel computing:", min = 1, max = 64, value = 1, animate = TRUE),
             actionButton(inputId = "Advance.parameters.hide.button.3", label = "Show / hide Advance parameters"),
             width = 4,
             height = 400
           ),
           box(
             id = "Advance.parameters.3",
             h3("Advance parameters"),
             numericInput(inputId = "MS2.sn.threshold.3", label = "MS2 S/N threshold", value = 3),
             textInput("MS2.noise.intensity.3", label = "MS2 noise intensity", value = "minimum"),
             selectInput("MS2.missing.value.padding.3", label = "MS2 missing value padding method",
                         choices = list("half" = "half", "minimal" = "minimal.value"),
                         selected = "minimal.value"),
             width = 12
           ),

  ),
  fluidRow(
    box(
      id = "start.button.3",
      h3("If all parameters were set, click the button.", align = "center"),
      actionButton("startMetEx.3", h3("Run"), width = "100%", height = "100%"),
      h3("_____________________________________________", align = "center"),
      box(
        h3("Running Information", align = "center"),
        h3("   ", align = "center"),
        shinyjs::useShinyjs(),
        textOutput("text.3"),
        # status = "success",
        background = "light-blue",
        collapsible = TRUE,
        width = 12,
        height = 200
      ),
      width = 8,
      height = 400
    ),

    box(
      id = "icon.figure.3",
      h3("Please wait while the icon appears.", align = "center"),
      withSpinner(uiOutput("logo.3"), type = 1, size = 1),
      actionButton(inputId = "result.hide.button.3", label = "Show / hide results"),
      actionButton(inputId = "parameter.hide.button.3", label = "Show / hide parameters"),
      width = 4,
      height = 400
    )
  ),
  fluidRow(id = "result.plot.table.3",
           # column(width = 12,box(plotOutput("Plot.3"), width = NULL)),

           box(
             width = 12,
             box(
               width = 6,
               h3("Download data before peak group.", align = "center"),
               downloadButton("downloadRawData.3", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 6,
               h3("Download data after peak group.", align = "center"),
               downloadButton("downloadGroupedData.3", "Download", width = "100%", height = "100%")
             )
           ),

           column(width = 12,box(dataTableOutput("Data.3"), width = NULL))
  )
)
