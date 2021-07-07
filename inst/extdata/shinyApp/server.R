source(
  file = "global.R",
  local = TRUE,
  encoding = "UTF-8"
)

shinyServer(function(input, output, session) {
  source(file = "main/MetEx.single.server.R", local = T, encoding = "UTF-8")
  source(file = "main/MetEx.mutiple.server.R", local = T, encoding = "UTF-8")
  source(file = "main/AnnotationFromPeakTable.server.R", local = T, encoding = "UTF-8")
  source(file = "main/Database.download.server.R", local = T, encoding = "UTF-8")
  source(file = "main/ChromatographicSystems.server.R", local = T, encoding = "UTF-8")

  session$onSessionEnded(function() {
    stopApp()
  })
})
