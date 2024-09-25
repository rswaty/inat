

## trying inat package to get pinus and quercus points for Guatemala

library(rinat)


# from bboxfinder.com -92.614746, 13.132979, -87.934570, 18.104087

# first try

## Search by area
guate_bounds <- c(13.132979, -92.614746, 18.104087, -87.934570)
pinus <- get_inat_obs(taxon_name  = "Pinus", 
                      bounds = guate_bounds,
                      maxresults = 1000,
                      quality = "research")


plot(pinus$longitude, pinus$latitude)
