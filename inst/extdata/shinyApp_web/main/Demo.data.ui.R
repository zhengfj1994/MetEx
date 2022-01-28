fluidPage(
  # helpText(h3("We present data from 5 biological samples acquired using two different mass spectrometers (AB SCIEX Triple Q-TOF 5600+ and Agilent 6546 LC/Q-TOF). The LC-MS raw data have been uploaded to Metabolomics Workbench (Metabolomics Workbench) and study ID are ST001873, ST001874, ST001875 and ST001876."))

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
            HTML("We present data from 5 biological samples acquired using two different mass spectrometers (AB SCIEX Triple Q-TOF 5600+ and Agilent 6546 LC/Q-TOF). The LC-MS raw data have been uploaded to Metabolomics Workbench (Metabolomics Workbench) and study ID are ST001873, ST001874, ST001875 and ST001876."))
      ),
      column(3)
    )
  )
)


