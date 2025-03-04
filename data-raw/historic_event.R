# dependencies ----
library(here)

# load "old" historic events ----
historic_event_old <- utils::read.csv(
  file = here::here(
    "data-raw",
    "Wessex_Water_historical_Event_Duration_Monitoring_2020_2023.csv"
  )
)

# load "new" historic events ----
historic_event_new <- utils::read.csv(
  file = here::here(
    "data-raw",
    "Wessex_Water_historical_Event_Duration_Monitoring_2024.csv"
  )
)

# ensure field names are the same ----
names(historic_event_new) <- names(historic_event_old)

# row bind the datasets together ----
historic_event <- base::rbind(
  histthisoric_event_old,
  historic_event_new
)

usethis::use_data(historic_event, overwrite = TRUE)
