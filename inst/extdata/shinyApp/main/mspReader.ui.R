fluidPage(
  fluidRow(id = "parameters.MSP_reader",
           box(
             id = "MSP.file",
             h3("MSP file"),
             fileInput(inputId = "MSP.file", label = "MSP.file", multiple = F),
             width = 4,
             height = 350,
           )

  ),
  fluidRow(
    box(
      id = "start.button.MSP_reader",
      h3("If all parameters were set, click the button.", align = "center"),
      actionButton("startMetEx.MSP_reader", h3("Run"), width = "100%", height = "100%"),
      h3("_____________________________________________", align = "center"),
      box(
        h3("Running Information", align = "center"),
        h3("   ", align = "center"),
        shinyjs::useShinyjs(),
        textOutput("text.MSP_reader"),
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
      id = "icon.figure.MSP_reader",
      h3("Please wait while the icon appears.", align = "center"),
      withSpinner(uiOutput("logo.MSP_reader"), type = 2, size = 1, color.background = "#3182BD"),
      actionButton(inputId = "result.hide.button.MSP_reader", label = "show / hide results"),
      actionButton(inputId = "parameter.hide.button.MSP_reader", label = "show / hide parameters"),
      width = 4,
      height = 400
    )
  )
)
