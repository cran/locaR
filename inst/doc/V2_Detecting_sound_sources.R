## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(locaR)

## -----------------------------------------------------------------------------

#list mp3 files.
f.in <- list.files(system.file('extdata', package = 'locaR'), full.names = T, pattern='mp3$')
#create wav names.
f.out <- file.path(tempdir(), basename(f.in))
#change extension.
substr(f.out, nchar(f.out)-2, nchar(f.out)) <- 'wav'

for(i in 1:length(f.in)) {
  y <- tuneR::readMP3(f.in[i])
  tuneR::writeWave(y, filename = f.out[i])
}


## -----------------------------------------------------------------------------
survey <- setupSurvey(folder = tempdir(), projectName = 'Ex', run = 1,
                      coordinatesFile = system.file('extdata', 'Vignette_Coordinates.csv', package = 'locaR'),
                      siteWavsFolder = tempdir(),
                      date = '20200617', time = '090000', surveyLength = 7)

## -----------------------------------------------------------------------------
all.equal(survey, read.csv(file.path(tempdir(), "20200617_090000/Run1/Ex_20200617_090000_Run1_Settings.csv"), stringsAsFactors = F))

## -----------------------------------------------------------------------------
st <- processSettings(settings = survey, getFilepaths = TRUE, types = 'wav')

## -----------------------------------------------------------------------------
matrix(1:9, byrow = T, nrow = 3)

## -----------------------------------------------------------------------------
matrix(1:9, byrow = F, nrow = 3)

## -----------------------------------------------------------------------------
lm <- layoutMatrix(st = st, start = 'topleft', byrow = T, nrow = 3, ncol = 3)
lm

## ----eval=FALSE---------------------------------------------------------------
#  omniSpectro(st, lm, intervalLength = 7)

## -----------------------------------------------------------------------------
read.csv(system.file('extdata', 'Vignette_Detections_20200617_090000.csv', package = 'locaR'))

