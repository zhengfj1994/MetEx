fluidPage(
  fluidRow(id = "parameters",
           column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
                      HTML("~~ <em>MetEx for single file</em> ~~")),
                  align = "center", width = 12),
           box(
             id = "Database.input",
             h3("Database input"),
             fileInput(inputId = "db.path", label = "Database", multiple = F),
             selectInput("ionMode", label = "Ion mode",
                         choices = list("Positive" = "P", "Negative" = "N"),
                         selected = "P"),
             selectInput("CE", label = "CE",
                         choices = list("all" = "all", "Low" = 15, "Medium" = 30, "high" = 45),
                         selected = "all"),
             width = 4,
             height = 350,
           ),
           box(
             id = "Retention.time.calibration",
             h3("Retention time calibration"),
             h4("If you don't want to calibrate retention time, just ignore this part."),
             # Whether to perform tR calibration
             selectInput("tRCalibration", label = "Whether to perform tR calibration",
                         choices = list("Yes" = T, "No" = F),
                         selected = F),
             fileInput(inputId = "is.tR.file", label = "tR of internal standards", multiple = F),
             width = 4,
             height = 350
           ),
           box(
             id = "LC-MS.data.import",
             h3("LC-MS data import"),
             fileInput(inputId = "msRawData", label = "mzXML file", multiple = F),
             fileInput(inputId = "mgfFile", label = "mgf file", multiple = F),
             width = 4,
             height = 350
           ),
           box(
             id = "Parameters.of.MS1",
             h3("Parameters of MetEx (MS1)"),
             numericInput(inputId = "MS1deltaMZ", label = "Delta m/z of MS1", value = 0.01),
             numericInput(inputId = "MS1deltaTR", label = "Delta tR of MS1", value = 60),
             numericInput(inputId = "entroThre", label = "Entropy threshold", value = 2),
             numericInput(inputId = "intThre", label = "Intensity threshold", value = 270),
             width = 4,
             height = 400
           ),
           box(
             id = "Parameters.of.MS2",
             h3("Parameters of MetEx (MS2)"),
             numericInput(inputId = "MS1MS2DeltaMZ", label = "Delta m/z of MS1 and MS2", value = 0.01),
             numericInput(inputId = "MS2DeltaMZ", label = "Delta m/z of MS2", value = 0.02),
             numericInput(inputId = "MS1MS2DeltaTR", label = "Delta tR of MS1 and MS2", value = 12),
             numericInput(inputId = "MS2scoreFilter", label = "MS2 score threshold", value = 0.6),
             width = 4,
             height = 400
           ),
           box(
             id = "Other.parameters",
             h3("Other parameters"),
             # textInput("csvFile", label = "Result (csv file)", value = "/download/test.csv"),
             textInput("xlsxFile", label = "Result (xlsx file)", value = "E:/test.xlsx"),
             sliderInput("cores", "Number of cores for parallel computing:", min = 1, max = 64, value = 1, animate = TRUE),
             actionButton(inputId = "Advance.parameters.hide.button", label = "show / hide Advance parameters"),
             width = 4,
             height = 400
           ),
           box(
             id = "Advance.parameters",
             h3("Advance parameters"),
             numericInput(inputId = "MS2.sn.threshold", label = "MS2 S/N threshold", value = 3),
             textInput("MS2.noise.intensity", label = "MS2 noise intensity", value = "minimum"),
             selectInput("MS2.missing.value.padding", label = "MS2 missing value padding method",
                         choices = list("half" = "half", "minimal" = "minimal.value"),
                         selected = "minimal.value"),
             width = 12
           ),

  ),
  fluidRow(
    box(
      id = "start.button",
      h3("If all parameters were set, click the button.", align = "center"),
      actionButton("startMetEx", h3("Run"), width = "100%", height = "100%"),
      h3("_____________________________________________", align = "center"),
      box(
        h3("Running Information", align = "center"),
        h3("   ", align = "center"),
        shinyjs::useShinyjs(),
        textOutput("text"),
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
      id = "icon.figure",
      h3("Please wait while the icon appears.", align = "center"),
      withSpinner(uiOutput("logo"), type = 6, size = 1),
      actionButton(inputId = "result.hide.button", label = "Show / hide results"),
      actionButton(inputId = "parameter.hide.button", label = "Show / hide parameters"),
      width = 4,
      height = 400
    )
  ),

  fluidRow(id = "result.plot.table",
           column(width = 12,box(plotOutput("Plot"), width = NULL)),

           box(
             width = 12,
             box(
               width = 12,
               sliderInput("size.points", "The size of points:", min = 0, max = 20, value = 6, animate = TRUE)
             ),
             box(
               width = 6,
               selectInput("download.file",
                         label = h3("Which file do you want to shown?", align = "center"),
                         choices = list("MS1 identified Result" = "MS1 identified Result",
                                        "MS2 identified Result" = "MS2 identified Result",
                                        "peak duplicated Result" = "peak duplicated Result",
                                        "MSMS duplicated Result" = "MSMS duplicated Result",
                                        "all" = "all"),
                         selected = "MS1 identified Result")
              ),
              box(
                width = 6,
                h3("Download the selected file.", align = "center"),
                downloadButton("downloadData", "Download", width = "100%", height = "100%")
              )
           ),

           column(width = 12,box(dataTableOutput("Data"), width = NULL)),
           # h3("Result download"),


  )
)
