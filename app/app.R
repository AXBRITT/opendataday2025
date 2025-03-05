library(shiny)
library(shinythemes)
library(bslib)
library(leaflet)

shiny::addResourcePath("images", "inst/images")

ui <- shiny::fluidPage(
  theme = shinythemes::shinytheme("superhero"),
  shiny::navbarPage(
    title = shiny::div(
      shiny::img(
        src = base::file.path("images", "icon.PNG"),
        height = "35px",
        style = "padding:2px; border-radius:15px"
      ),
      "Brown Fish - The Ecology Reporting App"
    )
  ),
  card(
    card_title("Brown Fish Map"),
    card_body(leafletOutput("map", height = "800px", width = "100%")),
    card_footer("Looking for Brown fish since 2025.")
  )
)

data_env <- base::new.env()

server <- function(input, output) {
  load(here::here("data", "SOs.rda"), envir = data_env)
  load(here::here("data", "fish_data.rda"), envir = data_env)
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(
        data = data_env$SOs,
        popup = ~popup
      ) |>
      leaflet::addCircleMarkers(
        data = data_env$fish_data,
        lng = ~longitude,
        lat = ~latitude,
        color = "#32190a",
        popup = ~popup
      )
  })
}

shiny::shinyApp(ui, server)
