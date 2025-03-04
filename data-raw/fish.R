#' fish.R
#' @name fish
#' @title fish
#' @author AXBRITT
#' @description
#' Dataset from data.gov.uk
#' https://environment.data.gov.uk/ecology/explorer/downloads/
#' showing the number and types of freshwater fish.
#' Filtered to the top 5 most popular fish
#' for ease of use.
#' @import here dplyr sf

# Load original data set ----
fish_counts_all <- utils::read.csv(
  here::here(
    "inst",
    "data",
    "FW_Fish_Counts.csv"
  )
)

# Filter the data set to the Wessex (geographic) area ----
fish_counts_wessex <- fish_counts_all |>
  dplyr::filter(
    AREA == "Wessex"
  )

# Create a list of unique fish and return just the 5 most common ----
fish_list <- fish_counts_wessex |>
  dplyr::group_by(
    SPECIES_NAME
  ) |>
  dplyr::summarize(
    fish_count = dplyr::n()
  ) |>
  dplyr::arrange(
    -fish_count
  ) |>
  dplyr::select(SPECIES_NAME) |>
  utils::head(
    n = 5
  ) |>
  base::as.list()

# Filter the data by the list of common fish ----
fish_shortlist <- fish_counts_wessex |>
  dplyr::filter(
    SPECIES_NAME %in% fish_list[[1]]
  )

# Identify the coordinate fields from the dataset ----
coord_fields <- c("SURVEY_RANKED_EASTING", "SURVEY_RANKED_NORTHING")

# Build a data.frame of the original Easting/Northing converted to Lat/Lng ----
fish_latlng <- fish_shortlist |>
  sf::st_as_sf(
    coords = coord_fields,
    crs = 27700
  ) |>
  sf::st_transform(4326) |>
  sf::st_coordinates() |>
  base::as.data.frame()

# Join the Lat/Lng to the original data and remove Easting/Northing ----
fish <- base::cbind(
  fish_shortlist,
  fish_latlng
) |>
  dplyr::select(
    -dplyr::all_of(coord_fields)
  )

# Add relative paths to fish images ----
fish <- fish |>
  dplyr::mutate(
    image = base::file.path(
      "images",
      base::paste0(.data$SPECIES_NAME, ".PNG")
    )
  )

# Save the dataset ----
usethis::use_data(fish, overwrite = TRUE)
