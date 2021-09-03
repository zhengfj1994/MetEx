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
      dbFile.MetEx <- system.file("extdata/database", "MetEx_OSI+MSMLS.xlsx", package = "MetEx")
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

    if (length(input$mgfFile.4$datapath)==0){
      mgfFile.MetEx <- system.file("extdata/mgf", "example.mgf", package = "MetEx")
    }
    else {
      mgfFile.MetEx <- input$mgfFile.4$datapath
    }

    annotationFromPeakTableRes.list <- annotationFromPeakTable.parallel(peakTable = MS1.peak.table.MetEx,
                                                                        mgfFile = mgfFile.MetEx,
                                                                        database = dbFile.MetEx,
                                                                        ionMode = input$ionMode.4,
                                                                        CE = input$CE.4,
                                                                        tRCalibration = input$tRCalibration.4,
                                                                        is.tR.file = input$is.tR.file.4$datapath,
                                                                        MS1DeltaMZ = input$MS1deltaMZ.4,
                                                                        MS1DeltaTR = input$MS1deltaTR.4,
                                                                        MS2.sn.threshold = input$MS2.sn.threshold.4,
                                                                        MS2.noise.intensity = input$MS2.noise.intensity.4,
                                                                        MS2.missing.value.padding = input$MS2.missing.value.padding.4,
                                                                        ms2Mode = 'ida',
                                                                        diaMethod = 'NA',
                                                                        MS1MS2DeltaTR = input$MS1MS2DeltaTR.4,
                                                                        MS1MS2DeltaMZ = input$MS1MS2DeltaMZ.4,
                                                                        MS2DeltaMZ = input$MS2DeltaMZ.4,
                                                                        scoreMode = 'average',
                                                                        cores = input$cores.4)
    # print(annotationFromPeakTableRes.list)

    output$downloadTop1Data.4 <- downloadHandler(
      filename = function() {
        paste("result-", Sys.Date(), ".xlsx", sep="")
      },
      content = function(file) {
        openxlsx::write.xlsx(annotationFromPeakTableRes.list[1], file, overwrite = T)
      }
    )

    output$downloadTop5Data.4 <- downloadHandler(
      filename = function() {
        paste("result-", Sys.Date(), ".xlsx",sep="")
      },
      content = function(file) {
        openxlsx::write.xlsx(annotationFromPeakTableRes.list, file, overwrite = T)
      }
    )

    data.4 <- annotationFromPeakTableRes.list[[1]]
    data.4 <- data.4[!is.na(data.4$score),]

    data.4$score <- round(as.numeric(data.4$score), 3)
    data.4$mz <- round(as.numeric(data.4$mz), 4)
    data.4$tr <- round(as.numeric(data.4$tr), 1)
    data.4$DP <- round(as.numeric(data.4$DP), 3)
    data.4$RDP <- round(as.numeric(data.4$RDP), 3)
    data.4$frag.ratio <- round(as.numeric(data.4$frag.ratio), 3)
    data.4$mzInDB <- round(as.numeric(data.4$mzInDB), 4)
    data.4$trInDB <- round(as.numeric(data.4$trInDB), 1)

    pos.data.4 = which(colnames(data.4) != "mz" &
                               colnames(data.4) != "tr" &
                               colnames(data.4) != "DP" &
                               colnames(data.4) != "RDP" &
                               colnames(data.4) != "frag.ratio" &
                               colnames(data.4) != "score" &
                               colnames(data.4) != "mzInDB" &
                               colnames(data.4) != "trInDB" &
                               colnames(data.4) != "ID" &
                               colnames(data.4) != "Name")

    output$Plot.4 <- renderPlot({
      # ggplot(data.4, aes(x=tr,y=mz))
      ggplot(data.4, aes(x=tr,y=mz))+
        geom_point(aes(size=score,fill=score),shape=21,colour="black",alpha=0.8)+
        scale_fill_gradient2(low="#377EB8",high="#E41A1C",midpoint = mean(data.4$score))+
        scale_size_area(max_size=input$size.points.4)+
        guides(size = guide_legend((title="score")))+
        theme(
          legend.text=element_text(size=10,face="plain",color="black"),
          axis.title=element_text(size=10,face="plain",color="black"),
          axis.text = element_text(size=10,face="plain",color="black"),
          legend.position = "right"
        )
    })

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
