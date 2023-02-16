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
#read example detections.
dets <- read.csv(system.file('extdata', 'Vignette_Detections_20200617_090000.csv', package = 'locaR'))

#over-write empty detections file.
write.csv(dets, file.path(tempdir(), '20200617_090000', 'Run1', 'Ex_20200617_090000_Run1_Detections.csv'), row.names = F)

## -----------------------------------------------------------------------------
st <- processSettings(settings = survey, getFilepaths = TRUE, types = 'wav')

## ----eval=FALSE---------------------------------------------------------------
#  locs <- localizeMultiple(st = st, indices = 'all')

## ----echo=FALSE---------------------------------------------------------------
read.csv(system.file('/extdata/Vignette_Detections_20200617_090000_Localized.csv', package = 'locaR'),
         stringsAsFactors = FALSE)

## ----echo=FALSE---------------------------------------------------------------
read.csv(system.file('/extdata/Vignette_Detections_20200617_090000_Localized.csv', package = 'locaR'),
         stringsAsFactors = FALSE)[,c('Easting', 'Northing', 'Elevation')]

