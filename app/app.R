library(shiny)
library(bslib)
library(leaflet)

ui = fluidPage(
  card(card_title("Map"),
       card_body(leafletOutput("map", width = 330)),
       card_footer("some footer"))
)

server = function(input, output){
  load("../data/SOs.rda")
  output$map = renderLeaflet({
    leaflet() %>%
      addTiles(providers$OpenStreetMap) %>%
      addCircleMarkers(data = SOs,
                       popup = ~popup)
  })
}

shinyApp(ui, server)
