## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(locaR)

## -----------------------------------------------------------------------------
f <- list.files(system.file('extdata', package = 'locaR'), pattern = '.mp3', full.names = T)
basename(f)

## -----------------------------------------------------------------------------
#Get a list of file paths to the example data.
filepaths <- list.files(system.file('extdata', package = 'locaR'), pattern = '.mp3', full.names = T)

#Add location names as names to the vector, to create a named vector of filepaths. 
#In this case, the location names appear as the first part of the file name before the first underscore.
#Adding these as names to the vector will be useful later.
names(filepaths) <- sapply(strsplit(basename(filepaths), '_'), '[[', 1)

## -----------------------------------------------------------------------------
#Read detection data.
detections <- read.csv(system.file('extdata', 'Vignette_Detections_20200617_090000.csv', package = 'locaR'), stringsAsFactors = FALSE)

## -----------------------------------------------------------------------------
#Extract the first row of the detections data.
row <- detections[1,]

#get names of relevant stations for this detection. These are in the first six columns.
stationSubset <- unlist(row[1,paste0('Station',1:6)])
#remove stations with NA or stations with and empty string (""), if applicable.
stationSubset <- stationSubset[!is.na(stationSubset) & stationSubset != '']

#Use those station (i.e. mic location) names to extract the correct file paths in the correct order.
paths <- filepaths[stationSubset]

#Now we can use createWavList to create a named list of wav files.
#The buffer argument adds a bit of extra space before and after. 
#The index argument is only important if you're running within a loop; if an error occurs, 
#the error message will include the index, which helps troubleshoot the problem.
wl <- createWavList(paths = paths, names = stationSubset,
                      from = row$From, to = row$To, buffer = 0.2, index=1)

## -----------------------------------------------------------------------------
head(wl)

## -----------------------------------------------------------------------------
coordinates <- read.csv(system.file('extdata', 'Vignette_Coordinates.csv', package = 'locaR'), stringsAsFactors = F)

#Add location names (in the Station column) as row names. This will be useful later.
row.names(coordinates) <- coordinates$Station

#Extract the pertinent stations for the first detection. We will incorporate this into a loop later.
crd <- coordinates[stationSubset,]

## -----------------------------------------------------------------------------
locFolder <- tempdir()

## -----------------------------------------------------------------------------
jpg <- '0001.jpeg'

## ----eval=FALSE---------------------------------------------------------------
# loc <- localize(wavList = wl, coordinates = crd, locFolder = locFolder,
#                   F_Low = row$F_Low, F_High = row$F_High, jpegName = jpg, keep.SearchMap = T, plot_label = 'Example event')

## ----eval=FALSE---------------------------------------------------------------
# loc$location

## ----echo=FALSE---------------------------------------------------------------
read.csv(system.file('/extdata/Vignette_location1.csv', package = 'locaR'), stringsAsFactors = FALSE)

## -----------------------------------------------------------------------------
utils::browseURL(locFolder)

## ----eval=FALSE---------------------------------------------------------------
# for(i in 1:nrow(detections)) {
#   #Select the ith row.
#   row <- detections[i,]
# 
#   #Skip rows that don't have a value in the Station1 column.
#   if(row$Station1 == "" | is.na(row$Station1)) {next}
# 
#   #get names of relevant stations for this detection.
#   stationSubset <- unlist(row[1,paste0('Station',1:6)])
#   #remove NA stations, if applicable.
#   stationSubset <- stationSubset[!is.na(stationSubset)]
#   stationSubset <- stationSubset[stationSubset != '']
# 
# 
#   #make a new wavList containing only the stations of interest.
#   pathSubset <- filepaths[stationSubset]
# 
#   #use createWavList() to create a list of wave objects.
#   #We can set index = i, so that if there is an error, we can pinpoint which detection
#   #it came from.
#   wl <- createWavList(paths = pathSubset, names = stationSubset,
#                       from = row$From, to = row$To, buffer = 0.2, index=i)
# 
#   #Get low and high frequency.
#   F_Low <- row$F_Low
#   F_High <- row$F_High
# 
#   #make a new coordinates data.frame with only relevant stations.
#   crd <- coordinates[stationSubset,]
# 
#   #Create jpeg name.
#   jpg <- paste0(formatC(i,width=4,flag='0'), '.jpeg')
# 
#   #localize(). Will leave most parameters at their default values.
#   loc <- localize(wavList = wl, coordinates = crd, locFolder = locFolder,
#                   F_Low = F_Low, F_High = F_High, jpegName = jpg, keep.SearchMap = T, plot_label = paste0('Species: ', row$Species, '\nFrom: ', row$From))
# 
#   if(i == 1) {OUT <- cbind(row,loc$location)} else {OUT <- rbind(OUT, cbind(row,loc$location))}
# 
# }
# 

## ----echo=FALSE---------------------------------------------------------------
read.csv(system.file('/extdata/Vignette_Detections_20200617_090000_Localized.csv', package = 'locaR'),
         stringsAsFactors = FALSE)

