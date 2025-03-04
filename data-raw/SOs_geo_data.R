library(dplyr)
load("data/historic_event.rda")

SOs = historic_event %>%
  select(ï..SiteId,
          SiteName,
          OutfallLatitude,
          OutfallLongitude) %>%
  rename("SiteID" = ï..SiteId,
         "latitude" = OutfallLatitude,
         "longitude" = OutfallLongitude) %>%
  distinct() %>%
  tidyr::drop_na() %>%
  mutate(popup = glue::glue("<b> Site Name :</b> {SiteName} <br>
                            <b> Site ID :</b> {SiteID} <br>"))

usethis::use_data(SOs, overwrite = TRUE)
