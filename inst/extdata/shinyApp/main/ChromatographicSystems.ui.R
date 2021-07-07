fluidPage(
  fluidRow(id = "ChromatographicSystems",
           column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
                      HTML("~~ <em>Chromatographic Systems</em> ~~")),
                  align = "center", width = 12),
           box(
             width = 12,
             box(
               width = 6,
               selectInput("download.ChromatographicSystems",
                           label = h3("Which chromatographic system do you want to shown?", align = "center"),
                           choices = list("RP_POS_30min" = "RP_POS_30min",
                                          "RP_NEG_25min" = "RP_NEG_25min",
                                          "RP_POS_12min" = "RP_POS_12min",
                                          "RP_POS_12min" = "RP_POS_12min",
                                          "RP_NEG_12min" = "RP_NEG_12min",
                                          "RP_POS_15min" = "RP_POS_15min",
                                          "RP_POS_15.5min" = "RP_POS_15.5min",
                                          "HILIC_POS_25min" = "HILIC_POS_25min"),
                           selected = "RP_POS_30min")
             ),
             box(
               width = 6,
               h3("Download the selected chromatographic system.", align = "center"),
               downloadButton("downloadCS", "Download", width = "100%", height = "100%")
             )
           ),

           column(width = 12,box(dataTableOutput("ChromatographicSystem"), width = NULL)),
  )
)
