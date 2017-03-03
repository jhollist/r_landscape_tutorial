library(sp)
library(rgdal)
# Point Pattern Data

rand <- SpatialPointsDataFrame(matrix(c(rnorm(100, mean = -70, sd = 2), 
                               rnorm(100, mean = 40, sd = 2)),
                             ncol = 2), data = data.frame(rand_data = rnorm(100)),
                      proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))
unif <- SpatialPointsDataFrame(jitter(matrix(c(rep(seq(from = -72, to = -68, by = (72-68)/9), 10), 
                               sort(rep(seq(from = 38, to = 42, by = (42-38)/9), 10))),
                             ncol = 2),factor = 1), data = data.frame(rand_data = rnorm(100)),
                      proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))
clumped <- SpatialPointsDataFrame(matrix(c(rnorm(25,mean = -68, sd = 0.4),
                                  rnorm(25,mean = -69, sd = 0.4),
                                  rnorm(25,mean = -71, sd = 0.4),
                                  rnorm(25,mean = -72, sd = 0.4),
                                  rnorm(25,mean = 41, sd = 0.4),
                                  rnorm(25,mean = 39, sd = 0.4),
                                  rnorm(25,mean = 38, sd = 0.4),
                                  rnorm(25,mean = 42, sd = 0.4)),
                         ncol = 2), data = data.frame(rand_data = rnorm(100)),
                         proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))

big <- SpatialPointsDataFrame(matrix(c(rnorm(1000000, mean = -70, sd = 2), 
                              rnorm(1000000, mean = 40, sd = 2)),
                     ncol = 2), data = data.frame(rand_data = rnorm(1000000)),
                     proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs "))
writeOGR(rand, ".","rand", driver ="ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(unif, ".","unif", driver ="ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(clumped, ".","clumped", driver ="ESRI Shapefile", overwrite_layer = TRUE)
writeOGR(big, ".","big", driver ="ESRI Shapefile", overwrite_layer = TRUE)
