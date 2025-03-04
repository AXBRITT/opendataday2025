library(shiny)
library(bslib)
library(leaflet)

ui <- shiny::fluidPage(
  shiny::navbarPage(
    title = shiny::div(
      shiny::img(
        src = here::here("inst", "images", "icon.PNG"),
        height = "75%",
        style = "padding:3px"
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
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addCircleMarkers(
        data = SOs,
        popup = ~popup
      )
  })
}

#providers$OpenStreetMap

shiny::shinyApp(ui, server)
