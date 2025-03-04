library(shiny)
library(bslib)
library(leaflet)

ui = fluidPage(
  card(card_title("Map"),
       card_body(leafletOutput("map")),
       card_footer("some footer"))
)

server = function(input, output){
  output$map = renderLeaflet({
    leaflet() %>%
      addTiles(providers$OpenStreetMap)
  })
}

shinyApp(ui, server)
