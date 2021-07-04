#' Title
#' Download compounds in KEGG.
#'
#' @param items only for test.
#'
#' @return kegg.compound.database.df
#' @export KEGGdownloader
#' @importFrom KEGGREST keggList keggGet
#' @importFrom stringr str_detect str_split_fixed
#'
#' @examples
#' kegg.compound.database.df <- KEGGdownloader(items = 10)
KEGGdownloader <- function(items = "all"){

  if (items == "all"){
    compound.id <- keggList("compound")
    compound.id <- names(compound.id)
    kegg.compound.database <- vector(mode = 'list', length = length(compound.id))
    for (i in 1:length(compound.id)){
      cat(i, ' ')
      kegg.compound.database[i] <- keggGet(dbentries = compound.id[i])
    }
  }
  else {
    compound.id <- keggList("compound")
    compound.id <- names(compound.id)
    kegg.compound.database <- vector(mode = 'list', length = items)
    for (i in 1:items){
      cat(i, ' ')
      kegg.compound.database[i] <- keggGet(dbentries = compound.id[i])
    }
  }

  list2dataframe <- function(kegg.compound.database){
    kegg.compound.database.df <- data.frame(ENTRY=0,NAME=0,FORMULA=0,EXACT_MASS=0,MOL_WEIGHT=0,
                                            CAS=0,PubChem=0)
    kegg.compound.database.df <- kegg.compound.database.df[-1,]
    for (i in c(1:length(kegg.compound.database))){
      print(i)
      kegg.compound.database.df[i,'ENTRY'] <- kegg.compound.database[[i]]$ENTRY
      kegg.compound.database.df[i,'NAME'] <- paste(kegg.compound.database[[i]]$NAME, collapse = "")
      if (!is.null(kegg.compound.database[[i]]$FORMULA)){
        kegg.compound.database.df[i,'FORMULA'] <- kegg.compound.database[[i]]$FORMULA
      }
      if (!is.null(kegg.compound.database[[i]]$EXACT_MASS)){
        kegg.compound.database.df[i,'EXACT_MASS'] <- as.numeric(kegg.compound.database[[i]]$EXACT_MASS)
      }
      if (!is.null(kegg.compound.database[[i]]$MOL_WEIGHT)){
        kegg.compound.database.df[i,'MOL_WEIGHT'] <- as.numeric(kegg.compound.database[[i]]$MOL_WEIGHT)
      }
      # if (!is.null(kegg.compound.database[[i]]$REMARK)){
      #   kegg.compound.database.df[i,'REMARK'] <- paste(kegg.compound.database[[i]]$REMARK, collapse = ";")
      # }
      # kegg.compound.database.df[i,'REACTION'] <- paste(kegg.compound.database[[i]]$REACTION, collapse = ";")
      # kegg.compound.database.df[i,'PATHWAY'] <- paste(kegg.compound.database[[i]]$PATHWAY, collapse = ";")
      # kegg.compound.database.df[i,'MODULE'] <- paste(kegg.compound.database[[i]]$MODULE, collapse = ";")
      # kegg.compound.database.df[i,'ENZYME'] <- paste(kegg.compound.database[[i]]$ENZYME, collapse = ";")
      # kegg.compound.database.df[i,'BRITE'] <- paste(kegg.compound.database[[i]]$BRITE, collapse = ";")
      # kegg.compound.database.df[i,'DBLINKS'] <- paste(kegg.compound.database[[i]]$DBLINKS, collapse = ";")
      if (!is.null(kegg.compound.database[[i]]$DBLINKS)){
        if (str_detect(kegg.compound.database[[i]]$DBLINKS[1],"CAS")){
          kegg.compound.database.df[i,'CAS'] <- str_split_fixed(kegg.compound.database[[i]]$DBLINKS[1],": ",n=2)[2]
          if (!is.na(str_detect(kegg.compound.database[[i]]$DBLINKS[2],"PubChem"))){
            if (str_detect(kegg.compound.database[[i]]$DBLINKS[2],"PubChem")){
              kegg.compound.database.df[i,'PubChem'] <- str_split_fixed(kegg.compound.database[[i]]$DBLINKS[2],": ",n=2)[2]
            }
          }
        }
        else {
          if (str_detect(kegg.compound.database[[i]]$DBLINKS[1],"PubChem")){
            kegg.compound.database.df[i,'PubChem'] <- str_split_fixed(kegg.compound.database[[i]]$DBLINKS[1],": ",n=2)[2]
          }
        }
      }
      # kegg.compound.database.df[i,'ATOM'] <- paste(kegg.compound.database[[i]]$ATOM, collapse = ";")
      # kegg.compound.database.df[i,'BOND'] <- paste(kegg.compound.database[[i]]$BOND, collapse = ";")
    }
    return(kegg.compound.database.df)
  }
  kegg.compound.database.df <- list2dataframe(kegg.compound.database)
  return(kegg.compound.database.df)
}
