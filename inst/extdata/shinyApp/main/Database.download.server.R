output$MoNA_RP_POS_30min <- downloadHandler(
  filename = function() {
    paste("MoNA_RP-POS-30min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`RP-POS-30min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)

output$MoNA_RP_NEG_25min <- downloadHandler(
  filename = function() {
    paste("MoNA_RP-NEG-25min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`RP-NEG-25min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)

output$MoNA_RP_POS_12min <- downloadHandler(
  filename = function() {
    paste("MoNA_RP-POS-12min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`RP-POS-12min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)

output$MoNA_RP_NEG_12min <- downloadHandler(
  filename = function() {
    paste("MoNA_RP-NEG-12min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`RP-NEG-12min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)

output$MoNA_RP_POS_15min <- downloadHandler(
  filename = function() {
    paste("MoNA_RP-POS-15min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`RP-POS-15min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)

output$MoNA_RP_POS_15.5min <- downloadHandler(
  filename = function() {
    paste("MoNA_RP-POS-15.5min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`RP-POS-15.5min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)

output$MoNA_HILIC_POS_25min <- downloadHandler(
  filename = function() {
    paste("MoNA_HILIC-POS-25min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`HILIC-POS-25min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)

output$MoNA_HILIC_Fiehn_17min <- downloadHandler(
  filename = function() {
    paste("MoNA_HILIC-Fiehn-17min.xlsx", sep="")
  },
  content = function(file) {
    MoNA_parts <- paste0(system.file("extdata/database/MoNA", package = "MetEx"), "/",
                         dir(system.file("extdata/database/MoNA", package = "MetEx")))
    for (MoNA_parti in MoNA_parts){
      load(MoNA_parti)
    }
    eval(parse(text = paste0("MoNA_experimental <- rbind(", paste(paste0("MoNA_part",c(1:15)), collapse = ", "), ")")))
    MoNA_experimental$tr <- MCSRT_MoNA$`HILIC-Fiehn-17min`
    openxlsx::write.xlsx(MoNA_experimental[!is.na(MoNA_experimental$tr),], file)
  }
)
#################################################################
output$KEGG_RP_POS_30min <- downloadHandler(
  filename = function() {
    paste("KEGG_RP-POS-30min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`RP-POS-30min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)

output$KEGG_RP_NEG_25min <- downloadHandler(
  filename = function() {
    paste("KEGG_RP-NEG-25min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`RP-NEG-25min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)

output$KEGG_RP_POS_12min <- downloadHandler(
  filename = function() {
    paste("KEGG_RP-POS-12min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`RP-POS-12min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)

output$KEGG_RP_NEG_12min <- downloadHandler(
  filename = function() {
    paste("KEGG_RP-NEG-12min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`RP-NEG-12min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)

output$KEGG_RP_POS_15min <- downloadHandler(
  filename = function() {
    paste("KEGG_RP-POS-15min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`RP-POS-15min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)

output$KEGG_RP_POS_15.5min <- downloadHandler(
  filename = function() {
    paste("KEGG_RP-POS-15.5min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`RP-POS-15.5min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)

output$KEGG_HILIC_POS_25min <- downloadHandler(
  filename = function() {
    paste("KEGG_HILIC-POS-25min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`HILIC-POS-25min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)

output$KEGG_HILIC_Fiehn_17min <- downloadHandler(
  filename = function() {
    paste("KEGG_HILIC-Fiehn-17min.xlsx", sep="")
  },
  content = function(file) {
    KEGG_parts <- paste0(system.file("extdata/database/KEGG", package = "MetEx"), "/",
                         dir(system.file("extdata/database/KEGG", package = "MetEx")))
    for (KEGG_parti in KEGG_parts){
      load(KEGG_parti)
    }
    KEGG$tr <- MCSRT_KEGG$`HILIC-Fiehn-17min`
    openxlsx::write.xlsx(KEGG[!is.na(KEGG$tr),], file)
  }
)
#################################################################
output$MSMLS_RP_POS_30min <- downloadHandler(
  filename = function() {
    paste("MSMLS_RP-POS-30min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`RP-POS-30min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

output$MSMLS_RP_NEG_25min <- downloadHandler(
  filename = function() {
    paste("MSMLS_RP-NEG-25min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`RP-NEG-25min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

output$MSMLS_RP_POS_12min <- downloadHandler(
  filename = function() {
    paste("MSMLS_RP-POS-12min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`RP-POS-12min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

output$MSMLS_RP_NEG_12min <- downloadHandler(
  filename = function() {
    paste("MSMLS_RP-NEG-12min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`RP-NEG-12min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

output$MSMLS_RP_POS_15min <- downloadHandler(
  filename = function() {
    paste("MSMLS_RP-POS-15min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`RP-POS-15min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

output$MSMLS_RP_POS_15.5min <- downloadHandler(
  filename = function() {
    paste("MSMLS_RP-POS-15.5min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`RP-POS-15.5min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

output$MSMLS_HILIC_POS_25min <- downloadHandler(
  filename = function() {
    paste("MSMLS_HILIC-POS-25min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`HILIC-POS-25min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

output$MSMLS_HILIC_Fiehn_17min <- downloadHandler(
  filename = function() {
    paste("MSMLS_HILIC-Fiehn-17min.xlsx", sep="")
  },
  content = function(file) {
    MSMLS_parts <- paste0(system.file("extdata/database/MSMLS", package = "MetEx"), "/",
                              dir(system.file("extdata/database/MSMLS", package = "MetEx")))
    for (MSMLS_parti in MSMLS_parts){
      load(MSMLS_parti)
    }
    MSMLS$tr <- MCSRT_MSMLS$`HILIC-Fiehn-17min`
    openxlsx::write.xlsx(MSMLS[!is.na(MSMLS$tr),], file)
  }
)

