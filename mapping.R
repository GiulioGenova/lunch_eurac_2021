library(dplyr)
library(sf)
library(mapview)
library(leaflet)
library(leaflet.extras)

mapviewOptions(basemaps = c("OpenStreetMap","CartoDB.Positron",
                            "CartoDB.DarkMatter","Esri.WorldImagery",
                            "OpenTopoMap"),fgb = FALSE)

origAddress_geocoded = read.csv("origAddress_geocoded.csv")

Lunch =  st_as_sf(origAddress_geocoded,coords =c("long","lat"))
Lunch =  Lunch %>%  distinct(.keep_all = TRUE)

st_write(Lunch, update = TRUE, driver = 'kml', 
dsn = "Lunch.kml")

rownames(Lunch) <- paste(Lunch$Descrizione,Lunch$Tipo,Lunch$Indirizzo,sep=" | ")

map_viz = mapview()+mapview(Lunch)

map_viz_controls = map_viz@map %>%
  #leaflet.extras::addSearchOSM(options = searchOptions(collapsed = TRUE))%>%
  addControlGPS(options = gpsOptions(autoCenter = TRUE, 
                                    maxZoom= 18,setView=TRUE)) %>% 
  addSearchFeatures(targetGroups='Lunch', 
                    options = searchFeaturesOptions(openPopup=TRUE,
                    propertyName = 'label',
                     zoom = 18))



mapshot(map_viz_controls,url = "index.html",remove_controls = NULL)
