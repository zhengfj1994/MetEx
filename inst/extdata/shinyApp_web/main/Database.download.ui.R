fluidPage(
  div(
    id="MoNA.download.5",
    column(img(src = "flower_left.png", align = "center", width = "10%"),
           img(src = "MetEx_icon_2.png", align = "center", width = "35%"),
           img(src = "flower_right.png", align = "center", width = "10%"),
           align = "center", width = 12),
    div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
        HTML("~~ <em>Databases for MetEx</em> ~~")),
    div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
        HTML("
  <h2 >The uniform database format</h2>
                            <ul>
                            <li><p>The database is stored in .xlsx file. And the first row is column names. Column names are specific, and using an irregular column name would make the database unrecognizable. The database should containing these columns:</p>
                            <ul>
                            <li><p>confidence_level : Compounds with level 1 have accurate mass, experimental tR and experimental MS2 data. Compounds with level 2 have accurate mass, predicted tR and experimental MS2 data. Compounds with level 3 have accurate mass, predicted tR and predicted MS2 data.</p>
                            </li>
                            <li><p>ID: The compound ID in database.</p>
                            </li>
                            <li><p>Name: The compound name.</p>
                            </li>
                            <li><p>Formula: Molecular formula.</p>
                            </li>
                            <li><p>ExactMass: Monoisotopic mass.</p>
                            </li>
                            <li><p>SMILES: Simplified molecular input line entry specification.</p>
                            </li>
                            <li><p>InChIKey: The InChIKey is a fixed-length (27-character) condensed digital representation of an InChI, developed to make it easy to perform web searches for chemical structures.</p>
                            </li>
                            <li><p>CAS: Chemical Abstracts Service number.</p>
                            </li>
                            <li><p>CID: Pubchem CID.</p>
                            </li>
                            <li><p>ionMode: The ion mode of LC-MS, positive ion mode is P and negative ion mode is N.</p>
                            </li>
                            <li><p>Adduct: Such as [M+H]+. </p>
                            </li>
                            <li><p>m/z: The accurate mass in LC-MS</p>
                            </li>
                            <li><p>tr: The retention time (in second)</p>
                            </li>
                            <li><p>CE: Collision energy.</p>
                            </li>
                            <li><p>MSMS: the MS/MS spectrum. The ion and its intensity are separated by a space (&quot; &quot;), and the ion and the ion are separated by a semicolon (&quot;;&quot;). For example: 428.036305927272 0.0201115093588212;524.057195188813 0.0699256604274525;542.065116124274 0.148347272003186;664.112740221342 1 is the abbreviate of MS/MS spectrum below:  </p>
                            <figure><table>
                            <thead>
                            <tr><th style='text-align:center;' >m/z</th><th style='text-align:center;' >intensity</th></tr></thead>
                            <tbody><tr><td style='text-align:center;' >428.036305927272&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp</td><td style='text-align:center;' >0.0201115093588212</td></tr><tr><td style='text-align:center;' >524.057195188813&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp</td><td style='text-align:center;' >0.0699256604274525</td></tr><tr><td style='text-align:center;' >542.065116124274&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp</td><td style='text-align:center;' >0.148347272003186</td></tr><tr><td style='text-align:center;' >664.112740221342&nbsp&nbsp&nbsp|&nbsp&nbsp&nbsp</td><td style='text-align:center;' >1</td></tr></tbody>
                            </table></figure>
                            </li>
                            <li><p>Instrument_type: for example, Q-TOF.</p>
                            </li>
                            <li><p>Instrument: for example, AB 5600 +</p>
                            </li>
                            <li><p>Other information is not mandatory, and users can add it as they see fit.  We have gave an example of database in data.</p>
                            </li>

                            </ul>
                            </li>

                            </ul>
               ")),
  column(img(src = "example-of-database.png", align = "center", width = "85%"), align = "center", width = 12),
  div(style="text-align:center;margin-top:0px;font-size:150%;color:black",
      HTML("
               Figure 1. An example of database.<br>
               ")),
  div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:130%;margin-top:5px",
      HTML("We provide parts of MetExDB to help users use MetEx, which can be downloaded at <a href='https://sourceforge.net/projects/metex/files/Databases' target='_blank' class='url'>sourceforge</a>."))
))
  # fluidRow(id = "MoNA.download.5",
  #          box(
  #            column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
  #                       HTML("~~ <em>Download MoNA under multiple chromatographic systems</em> ~~<br>
  #                            Note: The file size is large, after you click the download button, you need to wait 1-2 minutes!<br>
  #                            You can also download databases in <a href='https://sourceforge.net/projects/metex/files/Databases/MoNA%20for%20MetEx.xlsx/download' target='_blank' class='url'>sourceforge</a>")),
  #                   align = "center", width = 12),
  #            width = 12,
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(RP-POS-30min)")),
  #              downloadButton("MoNA_RP_POS_30min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(RP-NEG-25min)")),
  #              downloadButton("MoNA_RP_NEG_25min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(RP-POS-12min)")),
  #              downloadButton("MoNA_RP_POS_12min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(RP-NEG-12min)")),
  #              downloadButton("MoNA_RP_NEG_12min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(RP-POS-15min)")),
  #              downloadButton("MoNA_RP_POS_15min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(RP-POS-15.5min)")),
  #              downloadButton("MoNA_RP_POS_15.5min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(HILIC-POS-25min)")),
  #              downloadButton("MoNA_HILIC_POS_25min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MoNA<br>(HILIC-Fiehn-17min)")),
  #              downloadButton("MoNA_HILIC_Fiehn_17min", "Download", width = "100%", height = "100%")
  #            )
  #          )
  # ),
  # fluidRow(id = "KEGG.download.5",
  #          box(
  #            # You can also download databases in <a href='https://sourceforge.net/projects/metex/files/Databases/KEGG%20for%20MetEx.xlsx/download' target='_blank' class='url'>sourceforge</a>
  #            column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
  #                       HTML("~~ <em>Download KEGG under multiple chromatographic systems</em> ~~<br>
  #                            Note: Only positive mode can be used now!<br>")),
  #                   align = "center", width = 12),
  #            width = 12,
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(RP-POS-30min)")),
  #              downloadButton("KEGG_RP_POS_30min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(RP-NEG-25min)")),
  #              downloadButton("KEGG_RP_NEG_25min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(RP-POS-12min)")),
  #              downloadButton("KEGG_RP_POS_12min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(RP-NEG-12min)")),
  #              downloadButton("KEGG_RP_NEG_12min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(RP-POS-15min)")),
  #              downloadButton("KEGG_RP_POS_15min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(RP-POS-15.5min)")),
  #              downloadButton("KEGG_RP_POS_15.5min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(HILIC-POS-25min)")),
  #              downloadButton("KEGG_HILIC_POS_25min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("KEGG<br>(HILIC-Fiehn-17min)")),
  #              downloadButton("KEGG_HILIC_Fiehn_17min", "Download", width = "100%", height = "100%")
  #            )
  #          )
  # ),
  # fluidRow(id = "MSMLS.download.5",
  #          box(
  #            # You can also download databases in <a href='https://sourceforge.net/projects/metex/files/Databases/MSMLS%20for%20MetEx.xlsx/download' target='_blank' class='url'>sourceforge</a>
  #            column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
  #                       HTML("~~ <em>Download MSMLS under multiple chromatographic systems</em> ~~<br>")),
  #                   align = "center", width = 12),
  #            width = 12,
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(RP-POS-30min)")),
  #              downloadButton("MSMLS_RP_POS_30min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(RP-NEG-25min)")),
  #              downloadButton("MSMLS_RP_NEG_25min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(RP-POS-12min)")),
  #              downloadButton("MSMLS_RP_POS_12min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(RP-NEG-12min)")),
  #              downloadButton("MSMLS_RP_NEG_12min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(RP-POS-15min)")),
  #              downloadButton("MSMLS_RP_POS_15min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(RP-POS-15.5min)")),
  #              downloadButton("MSMLS_RP_POS_15.5min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(HILIC-POS-25min)")),
  #              downloadButton("MSMLS_HILIC_POS_25min", "Download", width = "100%", height = "100%")
  #            ),
  #            box(
  #              width = 3,
  #              div(style="text-align:center;margin-top:0px;font-size:175%;color:black",
  #                  HTML("MSMLS<br>(HILIC-Fiehn-17min)")),
  #              downloadButton("MSMLS_HILIC_Fiehn_17min", "Download", width = "100%", height = "100%")
  #            )
  #          )
  # ),
  # fluidRow(id = "OSI.download.5",
  #      box(
  #        column(div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
  #                   HTML("~~ <em>The OSI-SMMS database is in preparation and will be open sourced in the near future.</em> ~~")),
  #               align = "center", width = 12),
  #        width = 12
  #      )
  # )
