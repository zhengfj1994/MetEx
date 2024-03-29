source(
  file = "global.R",
  local = T,
  encoding = "UTF-8"
)

shinyUI(
  dashboardPage(
    skin = "blue",
    title = "MetEx",
    header = dashboardHeader(
      title = div(tags$a(img(src="MetEx_icon.png",height=40,align="center")),style = "position: relative; center: -5px;","MetEx")
      # titleWidth = 250
    ),
    sidebar = dashboardSidebar(
      sidebarMenu(
        menuItem("Introduction", tabName = "Introduction", icon = icon("laugh-wink")),
        menuItem("MetEx", tabName = "MetEx_S", icon = icon("chart-bar")),
        menuItem("MetEx (Mutiple file)", tabName = "MetEx_M", icon = icon("chart-pie")),
        menuItem("Classic annotation", tabName = "MetEx_P", icon = icon("file-csv")),
        menuItem("Databases", tabName = "Database_download", icon = icon("download")),
        menuItem("Demo data", tabName = "Demo_data", icon = icon("download")),
        menuItem("Chromatographic systems", tabName = "Chromatographic_systems", icon = icon("file-signature")),
        menuItem("Other software tools", tabName = "Other_software_tools", icon = icon("arrows-alt")),
        menuItem("Help document", tabName = "Help", icon = icon("hands-helping")),
        menuItem("Update", tabName = "Update", icon = icon("pencil-alt"))
      )
    ),
    body = body
  )
)

