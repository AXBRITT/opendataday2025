library(dplyr)
load("data/historic_event.rda")

SOs = historic_event %>%
  select(ï..SiteId,
          SiteName,
          OutfallLatitude,
          OutfallLongitude) %>%
  rename("SiteID" = ï..SiteId) %>%
  distinct() %>%
  tidyr::drop_na() %>%
  sf::st_as_sf(coords = c("OutfallLatitude", "OutfallLongitude"),
               crs = 4326)

usethis::use_data(SOs)
