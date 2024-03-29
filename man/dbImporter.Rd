% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dbImporter.R
\name{dbImporter}
\alias{dbImporter}
\title{Title
Import metabolomics database which saved in xlsx file and screen the database by ion mode and CE voltage.}
\usage{
dbImporter(dbFile, ionMode, CE = "all")
}
\arguments{
\item{dbFile, }{the xlsx file of metabolomics database with a changeless format.}

\item{ionMode, }{screen the database by ion mode (P or N, others are not available)}

\item{CE, }{screen the database by CE voltage (15, 30, 45 and 'all' are available)}
}
\value{
dbData
}
\description{
Title
Import metabolomics database which saved in xlsx file and screen the database by ion mode and CE voltage.
}
\examples{
dbData <- dbImporter(
          dbFile=system.file("extdata/database", "MetEx_MSMLS.xlsx", package = "MetEx"),
          ionMode='P',
          CE="all")
}
