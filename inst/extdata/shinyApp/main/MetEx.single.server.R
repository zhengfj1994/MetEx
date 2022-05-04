##############################################################################
shinyjs::hide(id = "result.plot.table")
shinyjs::hide(id = "result.hide.button")
shinyjs::hide(id = "parameter.hide.button")
shinyjs::hide(id = "Advance.parameters")
## observe the button being pressed
observeEvent(input$Advance.parameters.hide.button, {

  if(input$Advance.parameters.hide.button %% 2 == 1){
    shinyjs::show(id = "Advance.parameters")
  }else{
    shinyjs::hide(id = "Advance.parameters")
  }
})

observeEvent(input$result.hide.button, {

  if(input$result.hide.button %% 2 == 1){
    shinyjs::hide(id = "result.plot.table")
  }else{
    shinyjs::show(id = "result.plot.table")
  }
})

observeEvent(input$parameter.hide.button, {

  if(input$parameter.hide.button %% 2 == 1){
    shinyjs::hide(id = "parameters")
  }else{
    shinyjs::show(id = "parameters")
  }
})

observeEvent(input$startMetEx, {
  withCallingHandlers({
    shinyjs::html("text", "")
    if (length(input$db.path$datapath)==0){
      dbFile.MetEx <- system.file("extdata/database", "MetEx_MSMLS.xlsx", package = "MetEx")
    }
    else {
      dbFile.MetEx <- input$db.path$datapath
    }

    if (length(input$msRawData$datapath)==0){
      msRawData.MetEx <- system.file("extdata/mzXML", "example.mzXML", package = "MetEx")
    }
    else {
      msRawData.MetEx <- input$msRawData$datapath
    }

    if (length(input$mgfFile$datapath)==0){
      mgfFile.MetEx <- system.file("extdata/mgf", "example.mgf", package = "MetEx")
    }
    else {
      mgfFile.MetEx <- input$mgfFile$datapath
    }
    MetExAnnotationRes <-  MetExAnnotation(dbFile = dbFile.MetEx,
                                           ionMode = input$ionMode,
                                           CE = input$CE,
                                           tRCalibration = input$tRCalibration,
                                           is.tR.file = input$is.tR.file$datapath,
                                           msRawData = msRawData.MetEx,
                                           MS1deltaMZ = input$MS1deltaMZ,
                                           MS1deltaTR = input$MS1deltaTR,
                                           trRange = 30,
                                           m = 200,
                                           entroThre = input$entroThre,
                                           intThre = input$intThre,
                                           mgfFilePath = mgfFile.MetEx,
                                           MS1MS2DeltaMZ = input$MS1MS2DeltaMZ,
                                           MS1MS2DeltaTR = input$MS1MS2DeltaTR,
                                           MS2DeltaMZ = input$MS2DeltaMZ,
                                           NeedCleanSpectra = input$NeedCleanSpectra,
                                           MS2NoiseRemoval = input$MS2NoiseRemoval,
                                           onlyKeepMax = input$onlyKeepMax,
                                           minScore = input$minScore,
                                           KeepNotMatched = input$KeepNotMatched,
                                           MS2scoreFilter = input$MS2scoreFilter,
                                           cores = input$cores)

    # print(MetExAnnotationRes[[input$download.file]])
    openxlsx::write.xlsx(MetExAnnotationRes, file = input$xlsxFile, overwrite = T)

    # observeEvent(input$download.file, {
    #   if (input$download.file == "all"){
    #     data = MetExAnnotationRes[["MS1 identified Result"]]
    #
    #     output$downloadData <- downloadHandler(
    #       filename = function() {
    #         paste("result-",Sys.Date(), ".xlsx",sep="")
    #       },
    #       content = function(file) {
    #         openxlsx::write.xlsx(MetExAnnotationRes, file, overwrite = T)
    #       }
    #     )
    #   }
    #   else {
    #     data = MetExAnnotationRes[[input$download.file]]
    #
    #     output$downloadData <- downloadHandler(
    #       filename = function() {
    #         paste("result-",Sys.Date(), ".csv",sep="")
    #       },
    #       content = function(file) {
    #         write.csv(data, file, row.names = FALSE)
    #       }
    #     )
    #   }
    #
    #   data$trOfPeak <- round(as.numeric(data$trOfPeak), 2)
    #   data$m.z <- round(data$m.z, 4)
    #   data$peakHeight <- round(data$peakHeight, 0)
    #   data$entropy <- round(data$entropy, 3)
    #   data$DP <- round(data$DP, 3)
    #   data$RDP <- round(data$RDP, 3)
    #   data$frag.ratio <- round(data$frag.ratio, 3)
    #   data <- data[which(data$score != "Can't find MS2 in Database"),]
    #   data$score <- round(as.numeric(data$score), 3)
    #   pos.data = which(colnames(data) != "Name" &
    #                      colnames(data) != "tr" &
    #                      colnames(data) != "m.z" &
    #                      colnames(data) != "ionMode" &
    #                      colnames(data) != "CE" &
    #                      colnames(data) != "trOfPeak" &
    #                      colnames(data) != "peakHeight" &
    #                      colnames(data) != "peakArea" &
    #                      colnames(data) != "entropy" &
    #                      colnames(data) != "DP" &
    #                      colnames(data) != "RDP" &
    #                      colnames(data) != "frag.ratio" &
    #                      colnames(data) != "score")
    #
    #   output$Plot <- renderPlot({
    #     ggplot(data, aes(x=trOfPeak,y=m.z))+
    #       geom_point(aes(size=peakHeight,fill=entropy),shape=21,colour="black",alpha=0.8)+
    #       scale_fill_gradient2(low="#377EB8",high="#E41A1C",midpoint = mean(data$entropy))+
    #       scale_size_area(max_size=input$size.points)+
    #       guides(size = guide_legend((title="peakHeight")))+
    #       theme(
    #         legend.text=element_text(size=10,face="plain",color="black"),
    #         axis.title=element_text(size=10,face="plain",color="black"),
    #         axis.text = element_text(size=10,face="plain",color="black"),
    #         legend.position = "right"
    #       )
    #   })
    #   dataTableOutput("Data")
    #   output$Data = renderDataTable(server = FALSE,{
    #     dt <- datatable(
    #       cbind(' ' = '&oplus;', data),
    #       rownames = FALSE,
    #       escape = -1,
    #       options = list(
    #         columnDefs = list(
    #           list(visible = FALSE, targets = pos.data),
    #           list(orderable = FALSE, className = 'details-control', targets = 0)
    #         )
    #       ),
    #
    #       callback = JS(paste0("table.column(1).nodes().to$().css({cursor: 'pointer'});var format = function(d){return '<table cellpadding=\"5\" cellspacing=\"0\" border=\"0\" style=\"padding-left:50px;\">'+",
    #                            paste0("'<tr>'+'<td>",colnames(data)[pos.data],":</td>'+'<td>'+d[",pos.data,"]+'</td>'+'</tr>'+", sep = "", collapse = ""),
    #                            "'</table>';};table.on('click', 'td.details-control', function() {var td = $(this), row = table.row(td.closest('tr'));if (row.child.isShown()) {row.child.hide();td.html('&oplus;');} else {row.child(format(row.data())).show();td.html('&CircleMinus;');}});"))
    #     )
    #   })
    # })
    #
    # shinyjs::show(id = "result.plot.table")
    # shinyjs::show(id = "result.hide.button")
    shinyjs::show(id = "parameter.hide.button")
  },
  message = function(m) {
    shinyjs::html(id = "text", html = m$message, add = F)
  })
})



output$logo <- renderText({
  validate(need(input$startMetEx, "")) #I'm sending an empty string as message.
  input$startMetEx
  URL <- "Finished.png"
  #print(URL)
  Sys.sleep(2)
  c('<center><img src="', URL, '"width="100%" height="100%" align="middle"></center>')})
##############################################################################
