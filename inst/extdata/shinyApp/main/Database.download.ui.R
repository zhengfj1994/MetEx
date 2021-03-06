fluidPage(
  fluidRow(id = "MoNA.download.5",
           box(
             column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
                        HTML("~~ <em>Download MoNA under multiple chromatographic systems</em> ~~<br>
                             Note: The file size is large, after you click the download button, you need to wait 1-2 minutes!")),
                    align = "center", width = 12),
             width = 12,
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(RP-POS-30min)")),
               downloadButton("MoNA_RP_POS_30min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(RP-NEG-25min)")),
               downloadButton("MoNA_RP_NEG_25min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(RP-POS-12min)")),
               downloadButton("MoNA_RP_POS_12min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(RP-NEG-12min)")),
               downloadButton("MoNA_RP_NEG_12min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(RP-POS-15min)")),
               downloadButton("MoNA_RP_POS_15min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(RP-POS-15.5min)")),
               downloadButton("MoNA_RP_POS_15.5min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(HILIC-POS-25min)")),
               downloadButton("MoNA_HILIC_POS_25min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("MoNA<br>(HILIC-Fiehn-17min)")),
               downloadButton("MoNA_HILIC_Fiehn_17min", "Download", width = "100%", height = "100%")
             )
           )
  ),
  fluidRow(id = "KEGG.download.5",
           box(
             column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
                        HTML("~~ <em>Download KEGG under multiple chromatographic systems</em> ~~<br>
                             Note: Only positive mode can be used now!")),
                    align = "center", width = 12),
             width = 12,
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(RP-POS-30min)")),
               downloadButton("KEGG_RP_POS_30min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(RP-NEG-25min)")),
               downloadButton("KEGG_RP_NEG_25min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(RP-POS-12min)")),
               downloadButton("KEGG_RP_POS_12min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(RP-NEG-12min)")),
               downloadButton("KEGG_RP_NEG_12min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(RP-POS-15min)")),
               downloadButton("KEGG_RP_POS_15min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(RP-POS-15.5min)")),
               downloadButton("KEGG_RP_POS_15.5min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(HILIC-POS-25min)")),
               downloadButton("KEGG_HILIC_POS_25min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("KEGG<br>(HILIC-Fiehn-17min)")),
               downloadButton("KEGG_HILIC_Fiehn_17min", "Download", width = "100%", height = "100%")
             )
           )
  ),
  fluidRow(id = "OSI_MSMLS.download.5",
           box(
             column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
                        HTML("~~ <em>Download OSI-SMMS and MSMLS under multiple chromatographic systems</em> ~~")),
                    align = "center", width = 12),
             width = 12,
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(RP-POS-30min)")),
               downloadButton("OSI_MSMLS_RP_POS_30min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(RP-NEG-25min)")),
               downloadButton("OSI_MSMLS_RP_NEG_25min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(RP-POS-12min)")),
               downloadButton("OSI_MSMLS_RP_POS_12min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(RP-NEG-12min)")),
               downloadButton("OSI_MSMLS_RP_NEG_12min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(RP-POS-15min)")),
               downloadButton("OSI_MSMLS_RP_POS_15min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(RP-POS-15.5min)")),
               downloadButton("OSI_MSMLS_RP_POS_15.5min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(HILIC-POS-25min)")),
               downloadButton("OSI_MSMLS_HILIC_POS_25min", "Download", width = "100%", height = "100%")
             ),
             box(
               width = 3,
               div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
                   HTML("OSI-SMMS + MSMLS<br>(HILIC-Fiehn-17min)")),
               downloadButton("OSI_MSMLS_HILIC_Fiehn_17min", "Download", width = "100%", height = "100%")
             )
           )
  )
)
