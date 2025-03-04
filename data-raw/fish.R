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
#' @import here dplyr

fish_counts_all <- utils::read.csv(
  here::here(
    "inst",
    "data",
    "FW_Fish_Counts.csv"
  )
)

fish_counts_wessex <- fish_counts_all |>
  dplyr::filter(
    AREA == "Wessex"
  )

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

fish <- fish_counts_wessex |>
  dplyr::filter(
    SPECIES_NAME %in% fish_list[[1]]
  )

usethis::use_data(fish, overwrite = TRUE)
