#' ---
#' title: Spatial data manipulation for Eurostat package
#' author: Markus Kainu
#' date: "started Mar 19 2016 - Last updated: **`r Sys.time()`**"
#' output: 
#'   html_document: 
#'     toc: true
#'     toc_float: true
#'     number_sections: yes
#' ---
#'
#' ***
#' 
#' <b>Please email <a href="mailto:markuskainu@gmail.com?Subject=Spatial data manipulation for Eurostat package" target="_top">Markus Kainu</a> 
#' if any questions!</b>
#' 
#' source code: [analysis.R](./analysis.R)
#' 
#' ***

#+ setup, include = F
library(knitr)
knitr::opts_chunk$set(list(echo=TRUE,
                           eval=TRUE,
                           cache=FALSE,
                           warning=FALSE,
                           message=FALSE))

# create folders
dir.create("./zip/", recursive = TRUE)
dir.create("./rawdata/", recursive = TRUE)
dir.create("./rdata/", recursive = TRUE)


#' # Download and manipulate spatial data
#' 
#' We are: 
#' 
#' 1. downloading 2013 polygon shapefiles from [European Commission/Eurostat/GISCO](http://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts)
#' in four different resolution 1:60 mln, 1:20 mln, 1:10 mln, 1:3 mln and 1:1 mln.
#' 2. fortifying the `SpatialPolygonDataFrame`-objects into regular `data.frame`-objects using `ggplot2::fortify()`
#' 3. saving the `data.frame` objects into RData-files with their respective names to be used in 
#' `eurostat::merge_with_shape()`-function
#'
#' ***
#' 
#' ## Conditions for data use 
#' 
#' from [http://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units](http://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units)
#' 
#' **Administrative units / Statistical units**
#' 
#' In addition to the general copyright and licence policy applicable to the whole Eurostat website, the following specific provisions apply to the datasets you are downloading. The download and usage of these data is subject to the acceptance of the following clauses:
#' 
#' 1. The Commission agrees to grant the non-exclusive and not transferable right to use and process the Eurostat/GISCO geographical data downloaded from this page (the "data").
#' 2. The permission to use the data is granted on condition that:
#' 
#'     1. the data will not be used for commercial purposes;
#'     2. the source will be acknowledged. A copyright notice, as specified below, will have to be visible on any printed or electronic publication using the data downloaded from this page.
#'     
#' **Copyright notice**
#' 
#' When data downloaded from this page is used in any printed or electronic publication, in addition to any other provisions applicable to the whole Eurostat website, data source will have to be acknowledged in the legend of the map and in the introductory page of the publication with the following copyright notice:
#' - `EN: © EuroGeographics for the administrative boundaries`
#' - `FR: © EuroGeographics pour les limites administratives`
#' - `DE: © EuroGeographics bezüglich der Verwaltungsgrenzen`
#' 
#' For publications in languages other than English, French or German, the translation of the copyright notice in the language of the publication shall be used.
#' 
#' If you intend to use the data commercially, please contact [EuroGeographics](http://www.eurogeographics.org/) for information regarding their licence agreements
#' 
#' ***
#'  
#'    
#+ load_and_fortify
library(rgdal)
library(ggplot2)
library(maptools)
library(rgeos)
library(dplyr)
library(sf)
# Load the GISCO shapefile
if (!file.exists("./rdata/NUTS_2013_60M_SH.RData")){
  
  if (!file.exists("./rawdata/NUTS_2013_60M_SH/data/NUTS_RG_60M_2013.shp")){
    download.file("http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_60M_SH.zip",
                  destfile="./zip/NUTS_2013_60M_SH.zip")
    unzip("./zip/NUTS_2013_60M_SH.zip", exdir = "./rawdata/")
  } else {
    NUTS_2013_60M_SH_SPDF <- readOGR(dsn = "./rawdata/NUTS_2013_60M_SH/data", 
                                     layer = "NUTS_RG_60M_2013", verbose=FALSE)
    save(NUTS_2013_60M_SH_SPDF, file="./rdata/NUTS_2013_60M_SH_SPDF.RData")
  }
  # into KML
  # shape <- NUTS_2013_60M_SH_SPDF
  # shape <- spTransform(shape, CRS("+proj=longlat +datum=WGS84"))
  # writeOGR(shape, dsn="./rdata/NUTS_2013_60M_SH.kml", layer="", driver="KML", encoding="UTF-8")
  # geoJSON
  # writeOGR(shape, dsn="./rdata/NUTS_2013_60M_SH.geojson", layer="", driver="GeoJSON", encoding="UTF-8")
  # fortify into data.frame for ggplot2
  shape <- NUTS_2013_60M_SH_SPDF
  shape$id <- rownames(shape@data)
  map.points <- fortify(shape, region = "id")
  map.df <- merge(map.points, shape, by = "id")
  map.df <- arrange(map.df, order)
  NUTS_2013_60M_SH_DF <- map.df
  save(NUTS_2013_60M_SH_DF, file="./rdata/NUTS_2013_60M_SH_DF.RData")
  
  if (!file.exists("./rawdata/NUTS_2013_20M_SH/data/NUTS_RG_20M_2013.shp")){
    download.file("http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_20M_SH.zip",
                  destfile="./zip/NUTS_2013_20M_SH.zip")
    unzip("./zip/NUTS_2013_20M_SH.zip", exdir = "./rawdata/")
  } else {
    NUTS_2013_20M_SH_SPDF <- readOGR(dsn = "./rawdata/NUTS_2013_20M_SH/data", 
                                     layer = "NUTS_RG_20M_2013", verbose=FALSE)
    save(NUTS_2013_20M_SH_SPDF, file="./rdata/NUTS_2013_20M_SH_SPDF.RData")
  }
  # into KML
  # shape <- NUTS_2013_20M_SH_SPDF
  # shape <- spTransform(shape, CRS("+proj=longlat +datum=WGS84"))
  # writeOGR(shape, dsn="./rdata/NUTS_2013_20M_SH.kml", layer="", driver="KML", encoding="UTF-8")
  # fortify into data.frame for ggplot2
  shape <- NUTS_2013_20M_SH_SPDF
  shape$id <- rownames(shape@data)
  map.points <- fortify(shape, region = "id")
  map.df <- merge(map.points, shape, by = "id")
  map.df <- arrange(map.df, order)
  NUTS_2013_20M_SH_DF <- map.df
  save(NUTS_2013_20M_SH_DF, file="./rdata/NUTS_2013_20M_SH_DF.RData")
  
  if (!file.exists("./rawdata/NUTS_2013_10M_SH/data/NUTS_RG_10M_2013.shp")){
    download.file("http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_10M_SH.zip",
                  destfile="./zip/NUTS_2013_10M_SH.zip")
    unzip("./zip/NUTS_2013_10M_SH.zip", exdir = "./rawdata/")
  } else {
    NUTS_2013_10M_SH_SPDF <- readOGR(dsn = "./rawdata/NUTS_2013_10M_SH/data", 
                                     layer = "NUTS_RG_10M_2013", verbose=FALSE)
    save(NUTS_2013_10M_SH_SPDF, file="./rdata/NUTS_2013_10M_SH_SPDF.RData")
  }
  # into KML
  shape <- NUTS_2013_10M_SH_SPDF
  # shape <- spTransform(shape, CRS("+proj=longlat +datum=WGS84"))
  # writeOGR(shape, dsn="./rdata/NUTS_2013_10M_SH.kml", layer="", driver="KML", encoding="UTF-8")
  # fortify into data.frame for ggplot2
  shape$id <- rownames(shape@data)
  map.points <- fortify(shape, region = "id")
  map.df <- merge(map.points, shape, by = "id")
  map.df <- arrange(map.df, order)
  NUTS_2013_10M_SH_DF <- map.df
  save(NUTS_2013_10M_SH_DF, file="./rdata/NUTS_2013_10M_SH_DF.RData")
  
  if (!file.exists("./rawdata/NUTS_2013_03M_SH/data/NUTS_RG_03M_2013.shp")){
    download.file("http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_03M_SH.zip",
                  destfile="./zip/NUTS_2013_03M_SH.zip")
    unzip("./zip/NUTS_2013_03M_SH.zip", exdir = "./rawdata/")
  } else {
    NUTS_2013_03M_SH_SPDF <- readOGR(dsn = "./rawdata/NUTS_2013_03M_SH/data", 
                                     layer = "NUTS_RG_03M_2013", verbose=FALSE)
    save(NUTS_2013_03M_SH_SPDF, file="./rdata/NUTS_2013_03M_SH_SPDF.RData")
  }
  # into KML
  shape <- NUTS_2013_03M_SH_SPDF
  # shape <- spTransform(shape, CRS("+proj=longlat +datum=WGS84"))
  # writeOGR(shape, dsn="./rdata/NUTS_2013_03M_SH.kml", layer="", driver="KML", encoding="UTF-8")
  # fortify into data.frame for ggplot2
  shape$id <- rownames(shape@data)
  map.points <- fortify(shape, region = "id")
  map.df <- merge(map.points, shape, by = "id")
  map.df <- arrange(map.df, order)
  NUTS_2013_03M_SH_DF <- map.df
  save(NUTS_2013_03M_SH_DF, file="./rdata/NUTS_2013_03M_SH_DF.RData")

  if (!file.exists("./rawdata/NUTS_2013_01M_SH/data/NUTS_RG_01M_2013.shp")){
    download.file("http://ec.europa.eu/eurostat/cache/GISCO/geodatafiles/NUTS_2013_01M_SH.zip",
                  destfile="./zip/NUTS_2013_01M_SH.zip")
  } else {
    unzip("./zip/NUTS_2013_01M_SH.zip", exdir = "./rawdata/")
    NUTS_2013_01M_SH_SPDF <- readOGR(dsn = "./rawdata/NUTS_2013_01M_SH/data", 
                                     layer = "NUTS_RG_01M_2013", verbose=FALSE)
    save(NUTS_2013_01M_SH_SPDF, file="./rdata/NUTS_2013_01M_SH_SPDF.RData")
  }
  # into KML
  shape <- NUTS_2013_01M_SH_SPDF
  # shape <- spTransform(shape, CRS("+proj=longlat +datum=WGS84"))
  # writeOGR(shape, dsn="./rdata/NUTS_2013_01M_SH.kml", layer="", driver="KML", encoding="UTF-8")
  # fortify into data.frame for ggplot2
  
  shape$id <- rownames(shape@data)
  map.points <- fortify(shape, region = "id")
  map.df <- merge(map.points, shape, by = "id")
  map.df <- arrange(map.df, order)
  NUTS_2013_01M_SH_DF <- map.df
  save(NUTS_2013_01M_SH_DF, file="./rdata/NUTS_2013_01M_SH_DF.RData")

}

# simple features implementation
library(sf)
shps <- list.files("./rawdata", pattern = ".shp$", recursive = TRUE, full.names = TRUE)
shps <- shps[grepl("RG", shps)]
for (i in shps){
  shp <- read_sf(i, stringsAsFactors = FALSE)
  # lets duplicate the NUTS_ID columns as geo for easier merging with eurostat tabular data 
  shp$geo <- shp$NUTS_ID
  name <- gsub(".shp", "", gsub("^.*/", "", i))
  # As simple features
  save(shp, file=paste0("./rdata/",name,"_sf.RData"))
  # As sp-SpatialPolygonDataFrame
  shp <- as(shp, "Spatial")
  save(shp, file=paste0("./rdata/",name,"_spdf.RData"))
  # As fortified-data.frame
  shp@data$id <- row.names(shp@data)
  shape_tidy <- broom::tidy(shp)
  shp <- dplyr::left_join(shape_tidy, shp@data, by='id')
  save(shp, file=paste0("./rdata/",name,"_df.RData"))
}




