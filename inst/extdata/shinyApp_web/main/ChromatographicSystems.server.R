observeEvent(input$download.ChromatographicSystems, {
  load(system.file("extdata/database/MCS", "MCSRT.Rda", package = "MetEx"))

  MCSRT_select <- MCSRT[[input$download.ChromatographicSystems]]

  output$downloadCS <- downloadHandler(
    filename = function() {
      paste(input$download.ChromatographicSystems, ".csv", sep="")
    },
    content = function(file) {
      write.csv(MCSRT_select, file, row.names = FALSE)
    }
  )

  output$ChromatographicSystem <- renderDataTable(MCSRT_select)
})
