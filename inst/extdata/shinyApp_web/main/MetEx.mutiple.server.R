shinyjs::hide(id = "result.plot.table.3")
shinyjs::hide(id = "result.hide.button.3")
shinyjs::hide(id = "parameter.hide.button.3")
shinyjs::hide(id = "Advance.parameters.3")
## observe the button being pressed
observeEvent(input$Advance.parameters.hide.button.3, {

  if(input$Advance.parameters.hide.button.3 %% 2 == 1){
    shinyjs::show(id = "Advance.parameters.3")
  }else{
    shinyjs::hide(id = "Advance.parameters.3")
  }
})

observeEvent(input$result.hide.button.3, {

  if(input$result.hide.button.3 %% 2 == 1){
    shinyjs::hide(id = "result.plot.table.3")
  }else{
    shinyjs::show(id = "result.plot.table.3")
  }
})

observeEvent(input$parameter.hide.button.3, {

  if(input$parameter.hide.button.3 %% 2 == 1){
    shinyjs::hide(id = "parameters.3")
  }else{
    shinyjs::show(id = "parameters.3")
  }
})

observeEvent(input$startMetEx.3, {
  withCallingHandlers({
    shinyjs::html("text.3", "")
    if (length(input$db.path.3$datapath)==0){
      dbFile.MetEx <- system.file("extdata/database", "MetEx_MSMLS.xlsx", package = "MetEx")
    }
    else {
      dbFile.MetEx <- input$db.path.3$datapath
    }

    if (length(strsplit(input$msRawData.3, "", fixed=TRUE)[[1]])==0){
      msRawData.MetEx <- system.file("extdata/mzXML", package = "MetEx")
    }
    else {
      msRawData.MetEx <- input$msRawData.3
    }

    if (length(strsplit(input$mgfFile.3, "", fixed=TRUE)[[1]])==0){
      mgfFile.MetEx <- system.file("extdata/mgf", package = "MetEx")
    }
    else {
      mgfFile.MetEx <- input$mgfFile.3
    }

    mzXML.files.3 <- paste0(msRawData.MetEx, "/", grep('.mzXML', dir(msRawData.MetEx), value = TRUE))
    mgf.files.3 <- paste0(mgfFile.MetEx, "/", gsub(".mzXML", ".mgf", grep('.mzXML', dir(msRawData.MetEx), value = TRUE)))

    MetExAnnotationResList <- list()
    for (mzXML.files.3.i in c(1:length(grep('.mzXML', dir(msRawData.MetEx), value = TRUE)))){
      packageStartupMessage(mzXML.files.3[mzXML.files.3.i])
      MetExAnnotationResList[[grep('.mzXML', dir(msRawData.MetEx), value = TRUE)[mzXML.files.3.i]]] <- MetExAnnotation(dbFile = dbFile.MetEx,
                      ionMode = input$ionMode.3,
                      CE = input$CE.3,
                      tRCalibration = input$tRCalibration.3,
                      is.tR.file = input$is.tR.file.3$datapath,
                      msRawData = mzXML.files.3[mzXML.files.3.i],
                      MS1deltaMZ = input$MS1deltaMZ.3,
                      MS1deltaTR = input$MS1deltaTR.3,
                      entroThre = input$entroThre.3,
                      intThre = input$intThre.3,
                      mgfFile = mgf.files.3[mzXML.files.3.i],
                      MS1MS2DeltaMZ = input$MS1MS2DeltaMZ.3,
                      MS2DeltaMZ = input$MS2DeltaMZ.3,
                      MS1MS2DeltaTR = input$MS1MS2DeltaTR.3,
                      MS2.sn.threshold = input$MS2.sn.threshold.3,
                      MS2.noise.intensity = input$MS2.noise.intensity.3,
                      MS2.missing.value.padding = input$MS2.missing.value.padding.3,
                      MS2scoreFilter = input$MS2scoreFilter.3,
                      cores = input$cores.3)
      res.sheet <- peakGroup(MetExAnnotationResList)
    }

    templist <- list()
    for (i in names(MetExAnnotationResList)){
      templist[[i]] <- MetExAnnotationResList[[i]][[3]]
    }
    output$downloadRawData.3 <- downloadHandler(
      filename = function() {
        paste("result-", Sys.Date(), ".xlsx", sep="")
      },
      content = function(file) {
        openxlsx::write.xlsx(templist, file, overwrite = T)
      }
    )

    output$downloadGroupedData.3 <- downloadHandler(
      filename = function() {
        paste("result-", Sys.Date(), ".xlsx",sep="")
      },
      content = function(file) {
        openxlsx::write.xlsx(res.sheet, file, overwrite = T)
      }
    )

    # data.3$trOfPeak <- round(as.numeric(data.3$trOfPeak), 2)
    res.sheet$peakArea$m.z <- round(res.sheet$peakArea$m.z, 4)
    # data.3$peakHeight <- round(data.3$peakHeight, 0)
    # data.3$entropy <- round(data.3$entropy, 3)
    # data.3$DP <- round(data.3$DP, 3)
    # data.3$RDP <- round(data.3$RDP, 3)
    # data.3$frag.ratio <- round(data.3$frag.ratio, 3)
    # data.3 <- data.3[which(data.3$score != "Can't find MS2 in Database"),]
    # data.3$score <- round(as.numeric(data.3$score), 3)
    pos.data.3 = which(colnames(res.sheet$peakArea) != "Name" &
                         colnames(res.sheet$peakArea) != "tr" &
                         colnames(res.sheet$peakArea) != "m.z" &
                         colnames(res.sheet$peakArea) != "ionMode" &
                         colnames(res.sheet$peakArea) != "CE")
    # colnames(data.3) != "trOfPeak" &
    # colnames(data.3) != "peakHeight" &
    # colnames(data.3) != "entropy" &
    # colnames(data.3) != "DP" &
    # colnames(data.3) != "RDP" &
    # colnames(data.3) != "frag.ratio" &
    # colnames(data.3) != "score")

    # output$Plot.3 <- renderPlot({
    #   ggplot(data.3, aes(x=tr,y=m.z))+
    #     # geom_point(aes(size=peakHeight,fill=entropy),shape=21,colour="black",alpha=0.8)+
    #     # scale_fill_gradient2(low="#377EB8",high="#E41A1C",midpoint = mean(data.3$entropy))+
    #     # scale_size_area(max_size=input$size.points.3)+
    #     # guides(size = guide_legend((title="peakHeight")))+
    #     theme(
    #       legend.text=element_text(size=10,face="plain",color="black"),
    #       axis.title=element_text(size=10,face="plain",color="black"),
    #       axis.text = element_text(size=10,face="plain",color="black"),
    #       legend.position = "right"
    #     )
    # })
    dataTableOutput("Data")
    output$Data.3 = renderDataTable(server = FALSE,{
      dt <- datatable(
        cbind(' ' = '&oplus;', res.sheet$peakArea),
        rownames = FALSE,
        escape = -1,
        options = list(
          columnDefs = list(
            list(visible = FALSE, targets = pos.data.3),
            list(orderable = FALSE, className = 'details-control', targets = 0)
          )
        ),

        callback = JS(paste0("table.column(1).nodes().to$().css({cursor: 'pointer'});var format = function(d){return '<table cellpadding=\"5\" cellspacing=\"0\" border=\"0\" style=\"padding-left:50px;\">'+",
                             paste0("'<tr>'+'<td>",colnames(res.sheet$peakArea)[pos.data.3],":</td>'+'<td>'+d[",pos.data.3,"]+'</td>'+'</tr>'+", sep = "", collapse = ""),
                             "'</table>';};table.on('click', 'td.details-control', function() {var td = $(this), row = table.row(td.closest('tr'));if (row.child.isShown()) {row.child.hide();td.html('&oplus;');} else {row.child(format(row.data())).show();td.html('&CircleMinus;');}});"))
      )
    })

    shinyjs::show(id = "result.plot.table.3")
    shinyjs::show(id = "result.hide.button.3")
    shinyjs::show(id = "parameter.hide.button.3")
  },

  message = function(m) {
    shinyjs::html(id = "text.3", html = m$message, add = F)
  })
})

output$logo.3 <- renderText({
  validate(need(input$startMetEx.3, "")) #I'm sending an empty string as message.
  input$startMetEx.3
  URL <- "Finished.png"
  #print(URL)
  Sys.sleep(2)
  c('<center><img src="', URL, '"width="100%" height="100%" align="middle"></center>')})
##############################################################################
