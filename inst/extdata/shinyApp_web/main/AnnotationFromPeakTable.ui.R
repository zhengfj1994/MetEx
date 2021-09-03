fluidPage(
  fluidRow(id = "parameters.4",
           column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
                      HTML("~~ <em>Annotation from peak table</em> ~~")),
                  align = "center", width = 12),
           box(
             id = "Database.input.4",
             h3("Database input"),
             fileInput(inputId = "db.path.4", label = "Database", multiple = F),
             selectInput("ionMode.4", label = "Ion mode",
                         choices = list("Positive" = "P", "Negative" = "N"),
                         selected = "P"),
             selectInput("CE.4", label = "CE",
                         choices = list("all" = "all", "Low" = 15, "Medium" = 30, "high" = 45),
                         selected = "all"),
             width = 4,
             height = 350,
           ),
           box(
             id = "Retention.time.calibration.4",
             h3("Retention time calibration"),
             h4("If you don't want to calibrate retention time, just ignore this part."),
             # Whether to perform tR calibration
             selectInput("tRCalibration.4", label = "Whether to perform tR calibration",
                         choices = list("Yes" = T, "No" = F),
                         selected = F),
             fileInput(inputId = "is.tR.file.4", label = "tR of internal standards", multiple = F),
             width = 4,
             height = 350
           ),
           box(
             id = "LC-MS.data.import.4",
             h3("LC-MS data import"),
             fileInput(inputId = "MS1.peak.table.4", label = "MS1 peak table (.csv file)", multiple = F),
             fileInput(inputId = "mgfFile.4", label = "mgf file path", multiple = F),
             width = 4,
             height = 350
           ),
           box(
             id = "Parameters.of.MS1.4",
             h3("Parameters of MetEx (MS1)"),
             numericInput(inputId = "MS1deltaMZ.4", label = "Delta m/z of MS1", value = 0.01),
             numericInput(inputId = "MS1deltaTR.4", label = "Delta tR of MS1", value = 60),
             width = 4,
             height = 400
           ),
           box(
             id = "Parameters.of.MS2.4",
             h3("Parameters of MetEx (MS2)"),
             numericInput(inputId = "MS1MS2DeltaMZ.4", label = "Delta m/z of MS1 and MS2", value = 0.01),
             numericInput(inputId = "MS2DeltaMZ.4", label = "Delta m/z of MS2", value = 0.02),
             numericInput(inputId = "MS1MS2DeltaTR.4", label = "Delta tR of MS1 and MS2", value = 12),
             numericInput(inputId = "MS2scoreFilter.4", label = "MS2 score threshold", value = 0.6),
             width = 4,
             height = 400
           ),
           box(
             id = "Other.parameters.4",
             h3("Other parameters"),
             # textInput("xlsxFile.4", label = "Result (.xlsx)", value = "/download/test.xlsx"),
             sliderInput("cores.4", "Number of cores for parallel computing:", min = 1, max = 64, value = 1, animate = TRUE),
             actionButton(inputId = "Advance.parameters.hide.button.4", label = "Show / hide Advance parameters"),
             width = 4,
             height = 400
           ),
           box(
             id = "Advance.parameters.4",
             h3("Advance parameters"),
             numericInput(inputId = "MS2.sn.threshold.4", label = "MS2 S/N threshold", value = 3),
             textInput("MS2.noise.intensity.4", label = "MS2 noise intensity", value = "minimum"),
             selectInput("MS2.missing.value.padding.4", label = "MS2 missing value padding method",
                         choices = list("half" = "half", "minimal" = "minimal.value"),
                         selected = "minimal.value"),
             width = 12
           ),

  ),
  fluidRow(
    box(
      id = "start.button.4",
      h3("If all parameters were set, click the button.", align = "center"),
      actionButton("startMetEx.4", h3("Run"), width = "100%", height = "100%"),
      h3("_____________________________________________", align = "center"),
      box(
        h3("Running Information", align = "center"),
        h3("   ", align = "center"),
        shinyjs::useShinyjs(),
        textOutput("text.4"),
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
      id = "icon.figure.4",
      h3("Please wait while the icon appears.", align = "center"),
      withSpinner(uiOutput("logo.4"), type = 4, size = 1),
      actionButton(inputId = "result.hide.button.4", label = "Show / hide results"),
      actionButton(inputId = "parameter.hide.button.4", label = "Show / hide parameters"),
      width = 4,
      height = 400
    )
  ),
  fluidRow(id = "result.plot.table.4",
           box(
             width = 12,
             box(
               width = 6,
               h3("Download the TOP 1 candidate.", align = "center"),
               downloadButton("downloadTop1Data.4", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 6,
               h3("Download the TOP 5 candidates.", align = "center"),
               downloadButton("downloadTop5Data.4", "Download", width = "100%", height = "100%")
             )
           ),
           column(width = 12,box(plotOutput("Plot.4"), width = NULL)),
           box(sliderInput("size.points.4", "The size of points:", min = 0, max = 20, value = 6, animate = TRUE),width = 12),
           column(width = 12,box(dataTableOutput("Data.4"), width = NULL))
  )
)
