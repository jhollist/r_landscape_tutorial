library(sp)
library(rgdal)

# Point Pattern Data

rand <- SpatialPointsDataFrame(matrix(c(rnorm(100, mean = -73, sd = .2), 
                               rnorm(100, mean = 42, sd = .2)),
                             ncol = 2), data = data.frame(rand_data = rnorm(100)),
                      proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))
unif <- SpatialPointsDataFrame(jitter(matrix(c(rep(seq(from = -73.2, to = -72.8, by = (73.2-72.8)/9), 10), 
                               sort(rep(seq(from = 41.8, to = 42.2, by = (40.2-39.8)/9), 10))),
                             ncol = 2),factor = 1), data = data.frame(rand_data = rnorm(100)),
                      proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))
clumped <- SpatialPointsDataFrame(matrix(c(rnorm(25,mean = -72.8, sd = 0.04),
                                  rnorm(25,mean = -72.9, sd = 0.04),
                                  rnorm(25,mean = -73.1, sd = 0.04),
                                  rnorm(25,mean = -73.2, sd = 0.04),
                                  rnorm(25,mean = 42.2, sd = 0.04),
                                  rnorm(25,mean = 41.8, sd = 0.04),
                                  rnorm(25,mean = 41.9, sd = 0.04),
                                  rnorm(25,mean = 42.1, sd = 0.04)),
                         ncol = 2), data = data.frame(rand_data = rnorm(100)),
                         proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))

big <- SpatialPointsDataFrame(matrix(c(rnorm(1000000, mean = -70, sd = .2), 
                              rnorm(1000000, mean = 42, sd = .2)),
                     ncol = 2), data = data.frame(rand_data = rnorm(1000000)),
                     proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))
writeOGR(rand, ".","rand", driver ="ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(unif, ".","unif", driver ="ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(clumped, ".","clumped", driver ="ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(big, ".","big", driver ="ESRI Shapefile", overwrite_layer = TRUE)
