library(readxl)
library(leaflet)
library(sf)
library(tidygeocoder)
library(tidyverse)
library(htmltools)
library(htmlwidgets)
library(ggplot2)
library(sf)
library(ggspatial)
library(prettymapr)

unicafe <- read_excel("C:/Users/User/Downloads/unicafe location(1).xlsx")

unicafe <- unicafe %>%
  geocode(address = Address, method = 'osm', lat = latitude, long = longitude)

unicafe <- unicafe[-6, ]

unicafe[10, "latitude"] <- 60.17181529526857
unicafe[10, "longitude"] <- 24.949239712915798

unicafe[2, "latitude"] <- 60.17141380713472
unicafe[2, "longitude"] <- 24.947775884553554


unicafe_sf <- st_as_sf(unicafe, coords = c("longitude", "latitude"), crs = 4326, remove = FALSE)

unicafe_sf <- st_transform(unicafe_sf, crs = 3067) 
unicafe_buffer <- st_buffer(unicafe_sf, dist = 500)
unicafe_buffer <- st_transform(unicafe_buffer, crs = 4326) 

map <- leaflet() %>%
  addTiles() %>%
  addPolygons(data = unicafe_buffer, color = "green", weight = 1, fillOpacity = 0.1) %>%
  addCircleMarkers(data = unicafe_sf, lat = ~latitude, lng = ~longitude, radius = 4, color = "red",
                   popup = ~paste("<strong>", Name, "</strong><br>", Address))


saveWidget(map, "unicafe_map.html")


ggplot() +
  annotation_map_tile(type = "osm", zoomin = 0) +  
  geom_sf(data = unicafe_buffer, fill = "green", color = "green", alpha = 0.1) +
  geom_sf(data = unicafe_sf, color = "red", size = 3) +
  ggtitle("Location of UniCafes in Helsinki and a 500m radius around them") +
  labs(subtitle = "Day 1: Points #30daymapchallenge", caption = "Social Data Science Club Helsinki, \n Original Data, collected from https://unicafe.fi/en/") +
  theme_bw() +
  theme(
    axis.text.x = element_text(face='bold'),
    axis.title.x = element_text(color="black", size=25, face="bold"),
    plot.subtitle = element_text(color = 'black',size = 11, hjust = 0.5),
    axis.title.y = element_text(color="black", size=20, face="bold"),
    plot.title = element_text(color="black", size=12, hjust = 0.5),
    plot.caption = element_text(face="italic")
  )


ggsave("unicafe_map_with_basemap.png", width = 10, height = 8, dpi = 300)