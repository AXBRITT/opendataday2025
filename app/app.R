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
    card_title("Map"),
    card_body(leafletOutput("map", width = 330)),
    card_footer("some footer")
  )
)

server <- function(input, output) {
  load(here::here("data", "SOs.rda"))
  load(here::here("data", "fish.rda"))
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(
        data = SOs,
        popup = ~popup
      ) |>
      leaflet::addCircleMarkers(
        data = fish,
        lng = ~X,
        lat = ~Y,
        color = "#32190a",
        popup = shiny::div(
          shiny::img(
            src = ~img,
            height = "25px",
            width = "25px",
            style = "border-radius:25px"
          ),
          ~SPECIES_NAME
        )
      )
  })
}

shiny::shinyApp(ui, server)
