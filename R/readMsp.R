#' Title
#' This function is come form R package named "metaMS". The original name of this function is "read.msp"
#' Beacuse of this function have bug when reading msp files with some complicated compound name. So I changed
#' it to fit my objective. Function reads an msp file, and returns one list of compounds. Argument only.org allow
#' to exclude all molecular formulas with non-organic elements. What exactly are organic elements can be defined with
#' the optional argument org.set. A second optional argument indicates which fields should never be converted into numbers,
#' even if possible.
#'
#' @param file, the msp file
#' @param only.org FALSE
#' @param org.set c("C", "H", "D", "N", "O", "P", "S")
#' @param noNumbers NULL
#'
#' @return mspData
#' @export readMsp
#' @importFrom stats aggregate
#'
#' @references
#' This function is come form R package named "metaMS". The original name of this function is "read.msp"

readMsp <- function(file,
                    only.org = FALSE,
                    org.set = c("C", "H", "D", "N", "O", "P", "S"),
                    noNumbers = NULL) {
  ## first define three auxiliary functions, not used outside this function
  ## return the value of the given field in string x. If the field is
  ## not present, either stop with an error or return NULL (e.g. if it
  ## is not a required field)
  get.text.value <- function(x, field, do.err = TRUE) {
    woppa <- strsplit(x, field)
    woppa.lengths <- sapply(woppa, length)
    if (all(woppa.lengths == 2)) {  ## remove leading white space
      sapply(woppa, function(y) gsub("^ +", "", y[2]))
    } else {
      if (do.err) {
        stop(paste("Invalid field", field, "in", x[woppa.lengths != 2]))
      } else {
        NULL
      }
    }
  }

  ## see if only organic elements are present. Strategy: replace these
  ## by "" and convert to numbers. If not possible, then return FALSE.
  ## Jan 26, 2012: add deuterium as an organic element - sometimes
  ## deuterated standards are used
  is.org <- function(strs, org.set)
  {
    formulas <- get.text.value(strs, "Formula:")
    org.string <- paste("[", paste(org.set, collapse=""), "]",
                        collapse = "")
    suppressWarnings(which(!is.na(as.numeric(gsub(org.string, "",
                                                  formulas)))))
  }

  ## read ALL fields in a set of strings from an msp file and return as
  ## an msp object. All elements that can be converted into numbers are
  ## converted, unless explicitly stated in the exception list. Element
  ## "Num Peaks" is treated separately.
  read.compound <- function(strs, noNumbers) {
    if (is.null(noNumbers))
      noNumbers <-  c("Name", "CAS", "stdFile",
                      "date", "validated", "ChemspiderID",
                      "SMILES", "InChI", "Class", "comment",
                      "csLinks")

    fields.idx <- grep(":", strs)
    fields <- sapply(strsplit(strs[fields.idx], ":"), "[[", 1)

    pk.idx <- which(fields == "Num Peaks")
    if (length(pk.idx) == 0) ## should not happen
      stop("No spectrum found")

    ## read all normal fields
    cmpnd <- lapply(fields.idx[-pk.idx],
                    function(x)
                      get.text.value(strs[x],
                                     paste(fields[x], ":", sep = "")))
    names(cmpnd) <- fields[-pk.idx]
    ## convert numeric ones
    cnvrt.idx <- which(!(names(cmpnd) %in% noNumbers))
    cmpnd[cnvrt.idx] <- lapply(cmpnd[cnvrt.idx],
                               function(x) {
                                 if (is.na((y <- as.numeric(x)))) {
                                   x
                                 } else {
                                   y
                                 }
                               })

    ## now add pseudospectrum
    nlines <- length(strs)
    npeaks <- as.numeric(get.text.value(strs[pk.idx], "Num Peaks:"))
    peaks.idx <- (pk.idx+1):nlines
    pks <- gsub("^ +", "", unlist(strsplit(strs[peaks.idx], ";")))
    pks <- pks[pks != ""]
    if (length(pks) != npeaks)
      stop("Not the right number of peaks in compound", cmpnd$Name)
    pklst <- strsplit(pks, " ")
    pklst <- lapply(pklst, function(x) x[x != ""])
    cmz <- as.numeric(sapply(pklst, "[[", 1))
    cintens <- as.numeric(sapply(pklst, "[[", 2))
    ##  intens.OK <- cintens >= minintens

    finaltab <- matrix(c(cmz, cintens), ncol = 2)
    if (any(table(cmz) > 1)) {
      warning("Duplicate mass in compound ", cmpnd$Name,
              " (CAS ", cmpnd$CAS, ")... summing up intensities")
      finaltab <- aggregate(finaltab[,2],
                            by = list(finaltab[,1]),
                            FUN = sum)
    }
    colnames(finaltab) <- c("mz", "intensity")

    c(cmpnd, list(pspectrum = finaltab))
  }


  ## Go!

  huhn <- scan(file, what = "", sep = "\n", quiet = TRUE, encoding = 'UTF-8')

  starts <- which(regexpr("Name: ", huhn) == 1)
  if (length(starts) == 0){
    starts <- which(regexpr("NAME: ", huhn) == 1)
  }
  ends <- c(starts[-1] - 1, length(huhn))

  if (only.org) { ## filter out those compounds with non-organic elements
    formulas <- which(regexpr("Formula:", huhn) == 1)

    if (length(formulas) > 0) {
      orgs <- is.org(huhn[formulas], org.set)
      starts <- starts[orgs]
      ends <- ends[orgs]
    }
  }


  lapply(1:length(starts),
         function(i)
           read.compound(huhn[starts[i]:ends[i]], noNumbers = noNumbers))
}
