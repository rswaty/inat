

## trying inat package to get pinus and quercus points for Guatemala

library(rinat)
library(tidyverse)
library(lubridate)


# from bboxfinder.com -92.614746, 13.132979, -87.934570, 18.104087

# first try 

## Search by area
guate_bounds <- c(13.132979, -92.614746, 18.104087, -87.934570)
pinus <- get_inat_obs(taxon_name  = "Pinus", 
                      bounds = guate_bounds,
                      maxresults = 1000,
                      quality = "research")


plot(pinus$longitude, pinus$latitude)

# next try quercus

quercus <- get_inat_obs(taxon_name  = "Quercus", 
                        bounds = guate_bounds,
                        maxresults = 1000,
                        quality = "research")

## wrangle the datasets
# need to have both together, limit observations to after 2022, then limit columns to just scientific name, latitude and longitude

pinus_clean <- pinus %>%
  mutate(year = year(ymd(observed_on))) %>%
  select(scientific_name, latitude, longitude, year) %>%
  filter(year > 2021) # this may be too far in the past.  There may have been too many fires and harvests to make this work.

quercus_clean <- quercus %>%
  mutate(year = year(ymd(observed_on))) %>%
  select(scientific_name, latitude, longitude, year) %>%
  filter(year > 2021) # this may be too far in the past.  There may have been too many fires and harvests to make this work.

pinus_quercus <-
  bind_rows(pinus_clean, quercus_clean) %>% # 'stacks' the datasets
  mutate(class = "pine_oak") %>% # add a new column, assign each value as 'pine_oak' for remap app
  select(latitude, longitude, class) # remove unwanted columns and reorder for remap app


