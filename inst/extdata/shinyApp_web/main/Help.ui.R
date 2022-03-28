fluidPage(
  fluidRow(
    div(
      id="mainbody",
      column(img(src = "flower_left.png", align = "center", width = "10%"),
             img(src = "MetEx_icon_2.png", align = "center", width = "35%"),
             img(src = "flower_right.png", align = "center", width = "10%"),
             align = "center", width = 12),
      div(style="text-align:center;margin-top:0px;font-size:200%;color:darkred",
          HTML("~~ <em>Dear Users, Welcome to check the help document</em> ~~")),
      includeMarkdown("README.md"),
      column(3)
    )
  )
)
