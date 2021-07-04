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
        width = 12,
        div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
            HTML("~~ <em>Dear Users, Welcome to MetEx</em> ~~")),
        div(style="width:fit-content;width:-webkit-fit-content;width:-moz-fit-content;font-size:150%;margin-top:20px",
            HTML("Update plan list: <br>
                 1. More databases support (HMDB,GNPS...) <br>
                 2. More efficient MS2 scoring algorithm. <br>
                 3. Expansion to unknown metabolites. <br>
                 4. Integrated MRM-Ion Pair Finder to achieve more convenient and faster Pesudotargeted metabolomics.<br>
                 5. More..."))
      )
    )
  )
)


