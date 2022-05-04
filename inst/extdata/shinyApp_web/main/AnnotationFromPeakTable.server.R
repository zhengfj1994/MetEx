shinyjs::hide(id = "result.plot.table.4")
shinyjs::hide(id = "result.hide.button.4")
shinyjs::hide(id = "parameter.hide.button.4")
shinyjs::hide(id = "Advance.parameters.4")
## observe the button being pressed
observeEvent(input$Advance.parameters.hide.button.4, {

  if(input$Advance.parameters.hide.button.4 %% 2 == 1){
    shinyjs::show(id = "Advance.parameters.4")
  }else{
    shinyjs::hide(id = "Advance.parameters.4")
  }
})

observeEvent(input$result.hide.button.4, {

  if(input$result.hide.button.4 %% 2 == 1){
    shinyjs::hide(id = "result.plot.table.4")
  }else{
    shinyjs::show(id = "result.plot.table.4")
  }
})

observeEvent(input$parameter.hide.button.4, {

  if(input$parameter.hide.button.4 %% 2 == 1){
    shinyjs::hide(id = "parameters.4")
  }else{
    shinyjs::show(id = "parameters.4")
  }
})

observeEvent(input$startMetEx.4, {
  withCallingHandlers({
    shinyjs::html("text.4", "")
    if (length(input$db.path.4$datapath)==0){
      dbFile.MetEx <- system.file("extdata/database", "MetEx_MSMLS.xlsx", package = "MetEx")
    }
    else {
      dbFile.MetEx <- input$db.path.4$datapath
    }

    if (length(input$MS1.peak.table.4$datapath)==0){
      MS1.peak.table.MetEx <- system.file("extdata/peakTable", "example.csv", package = "MetEx")
    }
    else {
      MS1.peak.table.MetEx <- input$MS1.peak.table.4$datapath
    }

    if (input$mgfFile.4==""){
      mgfFile.MetEx <- system.file("extdata/mgf", package = "MetEx")
    }
    else {
      mgfFile.MetEx <- input$mgfFile.4
    }

    ClassicalAnnotationResult <- ClassicalAnnotation(peakTable = MS1.peak.table.MetEx,
                                                     mgfFilePath = mgfFile.MetEx,
                                                     database = dbFile.MetEx,
                                                     ionMode = input$ionMode.4,
                                                     CE = input$CE.4,
                                                     tRCalibration = input$tRCalibration.4,
                                                     is.tR.file = input$is.tR.file.4$datapath,
                                                     MS1DeltaMZ = input$MS1deltaMZ.4,
                                                     MS1DeltaTR = input$MS1deltaTR.4,
                                                     MS1MS2DeltaTR = input$MS1MS2DeltaTR.4,
                                                     MS1MS2DeltaMZ = input$MS1MS2DeltaMZ.4,
                                                     MS2DeltaMZ = input$MS2DeltaMZ.4,
                                                     NeedCleanSpectra = input$NeedCleanSpectra.4,
                                                     MS2NoiseRemoval = input$MS2NoiseRemoval.4,
                                                     onlyKeepMax = input$onlyKeepMax.4,
                                                     minScore = input$minScore.4,
                                                     KeepNotMatched = input$KeepNotMatched.4,
                                                     cores = input$cores.4)

    annotationFromPeakTableRes.list <- ClassicalAnnotationResult$ClassicalAnnotationResult
    # print(annotationFromPeakTableRes.list)
    # write.csv(annotationFromPeakTableRes.list, file = input$csvFile.4, row.names = F)

    output$downloadTop1Data.4 <- downloadHandler(
      filename = function() {
        paste("result-", Sys.Date(), ".csv", sep="")
      },
      content = function(file) {
        write.csv(annotationFromPeakTableRes.list, file)
      }
    )
    #
    # output$downloadTop5Data.4 <- downloadHandler(
    #   filename = function() {
    #     paste("result-", Sys.Date(), ".xlsx",sep="")
    #   },
    #   content = function(file) {
    #     openxlsx::write.xlsx(annotationFromPeakTableRes.list, file, overwrite = T)
    #   }
    # )

    data.4 <- annotationFromPeakTableRes.list
    data.4 <- data.4[!is.na(data.4$MS2_similarity),]
    if (nrow(data.4) == 0){
      data.4[1,] <- NA
    }

    data.4$MS2_similarity <- round(as.numeric(data.4$MS2_similarity), 3)
    data.4$mz <- round(as.numeric(data.4$mz), 4)
    data.4$tr <- round(as.numeric(data.4$tr), 1)

    pos.data.4 = which(colnames(data.4) != "mz" &
                       colnames(data.4) != "tr" &
                       colnames(data.4) != "MS2_similarity" &
                       colnames(data.4) != "ID" &
                       colnames(data.4) != "Name" &
                       colnames(data.4) != "Formula")

    # output$Plot.4 <- renderPlot({
    #   # ggplot(data.4, aes(x=tr,y=mz))
    #   ggplot(data.4, aes(x=tr,y=mz))+
    #     geom_point(aes(size=MS2_similarity,fill=MS2_similarity),shape=21,colour="black",alpha=0.8)+
    #     scale_fill_gradient2(low="#377EB8",high="#E41A1C",midpoint = mean(data.4$MS2_similarity))+
    #     scale_size_area(max_size=input$size.points.4)+
    #     guides(size = guide_legend((title="MS2_similarity")))+
    #     theme(
    #       legend.text=element_text(size=10,face="plain",color="black"),
    #       axis.title=element_text(size=10,face="plain",color="black"),
    #       axis.text = element_text(size=10,face="plain",color="black"),
    #       legend.position = "right"
    #     )
    # })

    dataTableOutput("Data")
    output$Data.4 = renderDataTable(server = FALSE,{

      dt <- datatable(
        cbind(' ' = '&oplus;', data.4),
        rownames = FALSE,
        escape = -1,
        options = list(
          columnDefs = list(
            list(visible = FALSE, targets = pos.data.4),
            list(orderable = FALSE, className = 'details-control', targets = 0)
          )
        ),

        callback = JS(paste0("table.column(1).nodes().to$().css({cursor: 'pointer'});var format = function(d){return '<table cellpadding=\"5\" cellspacing=\"0\" border=\"0\" style=\"padding-left:50px;\">'+",
                             paste0("'<tr>'+'<td>",colnames(data.4)[pos.data.4],":</td>'+'<td>'+d[",pos.data.4,"]+'</td>'+'</tr>'+", sep = "", collapse = ""),
                             "'</table>';};table.on('click', 'td.details-control', function() {var td = $(this), row = table.row(td.closest('tr'));if (row.child.isShown()) {row.child.hide();td.html('&oplus;');} else {row.child(format(row.data())).show();td.html('&CircleMinus;');}});"))
      )
    })

    shinyjs::show(id = "result.plot.table.4")
    shinyjs::show(id = "result.hide.button.4")
    shinyjs::show(id = "parameter.hide.button.4")
  },
  message = function(m) {
    shinyjs::html(id = "text.4", html = m$message, add = F)
  })
})

output$logo.4 <- renderText({
  validate(need(input$startMetEx.4, "")) #I'm sending an empty string as message.
  input$startMetEx.4
  URL <- "Finished.png"
  #print(URL)
  Sys.sleep(2)
  c('<center><img src="', URL, '"width="100%" height="100%" align="middle"></center>')})
##############################################################################
