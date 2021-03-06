% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/entropyCalculator.R
\name{entropyCalculator}
\alias{entropyCalculator}
\title{Title
Use EIC data to calculate entropy and the position (retention time) of max intensity.}
\usage{
entropyCalculator(eicData)
}
\arguments{
\item{eicData}{a matrix containing EIC data, the first column is rt (retention time) and the second column is intensity.}
}
\value{
maxTRandEntropy
}
\description{
Title
Use EIC data to calculate entropy and the position (retention time) of max intensity.
}
\examples{
load(system.file("extdata/testData", "eicDataTest.rda", package = "MetEx"))
maxTRandEntropy <- entropyCalculator(eicDataTest)
}
\references{
Ju R, Liu X, Zheng F, et al. Removal of False Positive Features to Generate Authentic Peak Table for High-resolution Mass Spectrometry-based Metabolomics Study[J]. Analytica Chimica Acta, 2019.
}
