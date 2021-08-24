rm(list=ls())                                              # always start with a clean slate

setwd(choose.dir())                                        # sets the directory with the file to process
getwd()

speciesData <- read.xlsx(file.choose())                    # occurrences data
head(speciesData, 10)

speciesName <- 'Population'                                # headers data for species name
xy <- species[,c("Longitude","Latitude")]                  # xy location
envVar <- list.files(pattern=".tif$", full.names = TRUE)   # environmental variables (pattern = .asc, .tif, .grd...)
rasterStack <- raster::stack(envVar)                       # a set of rasters with the same spatial range and resolution 
valueExtract <- raster::extract(rasterStack, xy)           # extract values from rasters
envSample <- cbind(speciesData, valueExtract)              # combining (merging) the source table and the obtained values 
head(envSample, 10)

write.csv2(envSample, file = "Species_envSample.csv")             # write .csv file
openxlsx::write.xlsx(envSample, file = "Species_envSample.xlsx")  # write excel file
