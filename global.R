library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)
library(scales)
library(glue)
library(DT)
library(ggpubr)
library(ggplot2)
library(maps)
library(maptools)
library(readxl)

forbes <- read_csv("Forbes2019.csv")
forbes_clean <- forbes %>% 
  drop_na(Revenue, Profits, Assets, Sector, Industry, Continent, CEO) %>% 
  select(-c(State, `Profits as % of Assets`, `Profits as % of Revenue`, Headquarters)) %>% 
  mutate(`ReturnonAsset(%)` = Profits / Assets * 100,
         `NetProfitMargin(%)` = Profits / Revenue * 100) %>% 
  mutate(`NetProfitMargin(%)` = round(`NetProfitMargin(%)`, digits = 2),
         `ReturnonAsset(%)` = round(`ReturnonAsset(%)`, digits = 2))



theme_algoritma <- theme(legend.key = element_rect(fill="black"),
                         legend.background = element_rect(color="white", fill="#263238"),
                         plot.subtitle = element_text(size=6, color="white"),
                         panel.background = element_rect(fill="#dddddd"),
                         panel.border = element_rect(fill=NA),
                         panel.grid.minor.x = element_blank(),
                         panel.grid.major.x = element_blank(),
                         panel.grid.major.y = element_line(color="darkgrey", linetype=2),
                         panel.grid.minor.y = element_blank(),
                         plot.background = element_rect(fill="#263238"),
                         text = element_text(color="white"),
                         axis.text = element_text(color="white")
)
