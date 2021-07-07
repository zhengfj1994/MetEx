library(shiny)
library(shinydashboard)
library(shinycssloaders)
library(shinyjs)
library(ggplot2)
library(RColorBrewer)
library(ggrepel)
library(MetEx)
library(openxlsx)
library(DT)
library(doSNOW)
library(dplyr)

options(shiny.maxRequestSize=5000*1024^2)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "Introduction",
      source(
        file = "main/introduction.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    # Second tab content
    tabItem(
      tabName = "MetEx_S",
      source(
        file = "main/MetEx.single.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    # Third tab content
    tabItem(
      tabName = "MetEx_M",
      source(
        file = "main/MetEx.mutiple.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    # Fourth tab content
    tabItem(
      tabName = "MetEx_P",
      source(
        file = "main/AnnotationFromPeakTable.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),

    ############################################################################
    # Fifth tab content
    tabItem(
      tabName = "MSP_reader",
      source(
        file = "main/mspReader.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    tabItem(
      tabName = "Database_download",
      source(
        file = "main/Database.download.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    tabItem(
      tabName = "Chromatographic_systems",
      source(
        file = "main/ChromatographicSystems.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    tabItem(
      tabName = "Other_software_tools",
      source(
        file = "main/OtherSoftwareTools.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    tabItem(
      tabName = "Help",
      source(
        file = "main/Help.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    ),
    ############################################################################
    tabItem(
      tabName = "Update",
      source(
        file = "main/Update.ui.R",
        local = T,
        encoding = "UTF-8"
      )$value
    )
  )
)
