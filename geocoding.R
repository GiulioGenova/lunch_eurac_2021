library(dplyr)
library(tidygeocoder)

origAddress <- read.csv("Locali_convenzionati_01.09.2021.csv", 
                        stringsAsFactors = FALSE)

origAddress = origAddress %>% 
mutate(Indirizzo_all = paste(Indirizzo,Cap,Citta,Prov.,sep= ","))

origAddress_geocoded = origAddress %>%
geocode(Indirizzo_all, method = 'arcgis')
names(origAddress_geocoded)[1] <- "Descrizione"

origAddress_geocoded = origAddress_geocoded %>%
  dplyr::select(-Indirizzo_all)

write.csv(origAddress_geocoded,"origAddress_geocoded.csv",row.names = FALSE)
