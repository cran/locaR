## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(locaR)

## -----------------------------------------------------------------------------
head(read.csv(system.file('extdata', "Vignette_Coordinates.csv", package = 'locaR')))

## -----------------------------------------------------------------------------
head(read.csv(system.file('extdata', "Vignette_Channels.csv", package = 'locaR')))

## -----------------------------------------------------------------------------
head(read.csv(system.file('extdata', "Vignette_Adjustments.csv", package = 'locaR')))

## -----------------------------------------------------------------------------
head(read.csv(system.file('extdata', "Vignette_Detections_20200617_090000.csv", package = 'locaR')))

## -----------------------------------------------------------------------------
read.csv(system.file('extdata', "Ex_20200617_090000_Settings.csv", package = 'locaR'), stringsAsFactors = F)

