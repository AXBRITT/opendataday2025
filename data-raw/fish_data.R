#' fish_data
#' @name fish_data
#' @title fish_data
#' @description
#' A view of the fish.rda data to be loaded into the leaflet map
#' @author AXBRITT
#' @import usethis here dplyr glue
#'
#'

base::load(
  file = here::here(
    "data",
    "fish.rda"
  )
)

fish_data <- fish |>
  dplyr::select(
    SPECIES_NAME,
    X,
    Y,
    image
  ) |>
  dplyr::rename(
    "species" = SPECIES_NAME,
    "longitude" = X,
    latitude = Y,
    "image" = image
  ) |>
  dplyr::mutate(
    popup = glue::glue("<img src='{image}' height='25px' width='25px' style='border-radius=25px'><p>{species}</p>") # nolint: line_length_linter.
  )

usethis::use_data(fish_data, overwrite = TRUE)
