-   [Core Spatial Packages](#core-spatial-packages)
    -   [Required packages (the good old days)](#required-packages-the-good-old-days)
        -   [sp](#sp)
        -   [rgdal](#rgdal)
        -   [raster](#raster)
        -   [rgeos](#rgeos)
    -   [Cutting edge: sf](#cutting-edge-sf)
    -   [Exercise 1](#exercise-1)
    -   [Interacting with an external GIS](#interacting-with-an-external-gis)
    -   [Spatial analysis packages](#spatial-analysis-packages)
        -   [SDMTools](#sdmtools)
        -   [spatstat](#spatstat)
        -   [spdep](#spdep)
    -   [Exercise 2](#exercise-2)
-   [Reading in spatial data](#reading-in-spatial-data)
    -   [sp](#sp-1)
    -   [raster](#raster-1)
    -   [sf](#sf)
-   [Landscape Metrics](#landscape-metrics)
    -   [With SDMTools](#with-sdmtools)
        -   [Patch Statistics](#patch-statistics)
        -   [Class Statistics](#class-statistics)
    -   [Roll your own](#roll-your-own)
-   [Spatial Statistics](#spatial-statistics)
    -   [Point Pattern Analysis](#point-pattern-analysis)
        -   [Ripley's K](#ripleys-k)
    -   [Autocorrelation and Variography](#autocorrelation-and-variography)
        -   [Moran's I - Testing Residuals](#morans-i---testing-residuals)
        -   [Variogram](#variogram)
    -   [Spatial Interpolation](#spatial-interpolation)
        -   [Inverse Distance Weighting](#inverse-distance-weighting)
        -   [Splines](#splines)
        -   [Kriging](#kriging)

In this tutorial we will introduce the packages required for geospatial work in R, show how to read in a few spatial data types, demonstrate several ways to calculate landscape metrics, and briefly touch on spatial statistics. It is assumed that you have [R and RStudio installed](https://github.com/rhodyrstats/intro_r_workshop#software) and that you, at a minimum, understand the basic concepts of the R language (e.g. you can work through[R For Cats](https://rforcats.net)).

Core Spatial Packages
=====================

Required packages (the good old days)
-------------------------------------

Within in the last several years there has been a lot of effort spent on adding spatial data handling and analysis capability to R. Thanks to the very significant effort of the package authors we now have the foundation for doing GIS entirely within R.

The four packages that provide this foundation are:

-   [sp](https://cran.r-project.org/web/packages/sp/index.html)
-   [rgdal](https://cran.r-project.org/web/packages/rgdal/index.html)
-   [raster](https://cran.r-project.org/web/packages/raster/index.html)
-   [rgeos](https://cran.r-project.org/web/packages/rgeos/index.html)

Let's dig in a bit deeper on each of these.

### sp

The `sp` package provides the primary spatial data structures for use in R. Many other packages assume your data is stored as one of the `sp` data structures. Getting into the details of these is beyond the scope of this workshop, but look at the [introduction to sp vignette for more details](https://cran.r-project.org/web/packages/sp/vignettes/intro_sp.pdf). That being said, we will be working mostly with `SpatialPointsDataFrame` and `SpatialPolygonsDataFrame`. More on that later.

Getting `sp` added is no different than adding any other package that is on CRAN.

``` r
install.packages("sp")
```

    ## Installing package into '/home/jhollist/R/x86_64-pc-linux-gnu-library/3.3'
    ## (as 'lib' is unspecified)

``` r
library("sp")
```

### rgdal

The `rgdal` package provides tools for reading and writing multiple spatial data formats. It is based on the [Geospatial Data Abstraction Library (GDAL)](http://www.gdal.org/) which is a project of the Open Source Geospatial Foundation (OSGeo). The primary use of `rgdal` is to read various spatial data formats into R and store them as `sp` objects. In this workshop, we will be only using `rgdal` to read in shape files, but it has utility far beyond that.

As before, nothing special to get set up with `rgdal` on windows. Simply:

``` r
install.packages("rgdal")
```

    ## Installing package into '/home/jhollist/R/x86_64-pc-linux-gnu-library/3.3'
    ## (as 'lib' is unspecified)

``` r
library("rgdal")
```

Getting set up on Linux or Mac requires more effort (i.e. need to have GDAL installed). As this is for a USEPA audience the windows installs will work for most. Thus, discussion of this is mostly beyond the scope of this workshop.

### raster

Although `sp` and `rgdal` provide raster data capabilities, they do require that the full raster dataset be read into memory. This can have some performance implications as well as limits the size of datasets you can readily work with. The `raster` package works around this by working with raster data on the disk. That too has some performance implications, but for the most part, in my opinion anyway, `raster` makes it easier to work with raster data. It also provides several additional functions for analyzing raster data.

To install, just do:

``` r
install.packages("raster")
```

    ## Installing package into '/home/jhollist/R/x86_64-pc-linux-gnu-library/3.3'
    ## (as 'lib' is unspecified)

``` r
library("raster")
```

### rgeos

The last of the core packages for doing GIS in R is `rgeos`. Like `rgdal`, `rgeos` is a project of OSgeo. It is a wrapper around the [Geometry Engine Open Source](https://trac.osgeo.org/geos/) c++ library and provides a suite of tools for conducting vector GIS analyses.

To install on windows

``` r
install.packages("rgeos")
```

    ## Installing package into '/home/jhollist/R/x86_64-pc-linux-gnu-library/3.3'
    ## (as 'lib' is unspecified)

``` r
library("rgeos")
```

For Linux and Mac the GEOS library will also need to be available. As with `rgdal` this is a bit beyond the scope of this tutorial.

Cutting edge: sf
----------------

Things are changing quickly in the R/spatial analysis world and the most fundamental change is via the `sf` package. This package aims to replace `sp`, `rgdal`, and `rgeos`. There are a lot of reasons why this is a good thing, but that is a bit beyond the scope of this tutorial. Suffice it to say it should make things faster and simpler!

To install `sf`:

``` r
install.packages("sf")
```

    ## Installing package into '/home/jhollist/R/x86_64-pc-linux-gnu-library/3.3'
    ## (as 'lib' is unspecified)

``` r
library("sf")
```

Exercise 1
----------

The first exercise won't be too thrilling, but we need to make sure everyone has the packages installed.

1.) Install `sp` and load `sp` into your library. 2.) Repeat, with `sf`,`rgdal`, `raster`, and `rgeos`.

Interacting with an external GIS
--------------------------------

Although we won't be working with external GIS in this tutorial, there are several packages that provide ways to move back and forth from another GIS and R. For your reference, here are some.

-   [spgrass6](https://cran.r-project.org/web/packages/spgrass6/index.html): Provides an interface between R and [GRASS 6+](https://grass.osgeo.org/download/software/#g64x). Allows for running R from within GRASS as well as running GRASS from within R.
-   [rgrass7](https://cran.r-project.org/web/packages/rgrass7/index.html): Same as `spgrass6`, but for the latest version of GRASS, [GRASS 7](https://grass.osgeo.org/download/software/#g70x).
-   [RPyGeo](https://cran.r-project.org/web/packages/RPyGeo/index.html): A wrapper for accessing ArcGIS from R. Utilizes intermediate python scripts to fire up ArcGIS. Hasn't been updated in some time.
-   [RSAGA](https://cran.r-project.org/web/packages/RSAGA/index.html): R interface to the command line version of [SAGA GIS](http://www.saga-gis.org/en/index.html).

Spatial analysis packages
-------------------------

There are many packages for doing various types of spatial analysis in R. For this tutorial we will look at only a few

### SDMTools

This package is a large suite of tools for species distribution modelling. As part of that suite, the FRAGSTATS metrics are inlcuded.

### spatstat

This is a huge package and will take care of pretty much all of your point pattern analysis needs.

### spdep

Also another huge package for spatial analysis. This one is dense, but has all of your autocorrelation/variogram functions!

Exercise 2
----------

1.  Install and load `SDMTools`, `spatstat`, and `spdep`.

Reading in spatial data
=======================

sp
--

Reading in data with `sp` requires `rgdal` which supports many different data formats. For this quick tutorial lets see an example of reading in a shapefile in the current working directory.

``` r
rand <- readOGR(".","rand")
```

    ## OGR data source with driver: ESRI Shapefile 
    ## Source: ".", layer: "rand"
    ## with 100 features
    ## It has 1 fields

``` r
plot(rand)
```

![](tutorial_files/figure-markdown_github/unnamed-chunk-6-1.png)

raster
------

To read in raster datasets we can use the `raster` packages `raster()` function. For most raster formats it is simply a matter of telling `raster()` to file location.

``` r
nlcd <- raster("nlcd.tif")
plot(nlcd)
```

![](tutorial_files/figure-markdown_github/unnamed-chunk-7-1.png)![](tutorial_files/figure-markdown_github/unnamed-chunk-7-2.png)

sf
--

Lastly, reading in data with `sf` is also pretty straightforward.

``` r
sf_rand <- st_read("rand.shp")
```

    ## Reading layer `rand' from data source `/home/jhollist/projects/r_landscape_tutorial/rand.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 100 features and 1 field
    ## geometry type:  POINT
    ## dimension:      XY
    ## bbox:           xmin: -73.41471 ymin: 41.51605 xmax: -72.57539 ymax: 42.41291
    ## epsg (SRID):    4326
    ## proj4string:    +proj=longlat +datum=WGS84 +no_defs

One of the benefits of using `sf` is the speed. In my tests it is about twice as fast. Let's look at a biggish shape file with 1 million points!

![1 million points](https://media4.giphy.com/media/13B1WmJg7HwjGU/giphy.gif)

``` r
#The old way
system.time(readOGR(".","big"))
```

    ## OGR data source with driver: ESRI Shapefile 
    ## Source: ".", layer: "big"
    ## with 1000000 features
    ## It has 1 fields

    ##    user  system elapsed 
    ##  14.460   0.220  14.684

``` r
#The sf way
system.time(st_read("big.shp"))
```

    ## Reading layer `big' from data source `/home/jhollist/projects/r_landscape_tutorial/big.shp' using driver `ESRI Shapefile'
    ## Simple feature collection with 1000000 features and 1 field
    ## geometry type:  POINT
    ## dimension:      XY
    ## bbox:           xmin: -71.03768 ymin: 41.05976 xmax: -69.09763 ymax: 43.00856
    ## epsg (SRID):    4326
    ## proj4string:    +proj=longlat +datum=WGS84 +no_defs

    ##    user  system elapsed 
    ##   6.188   0.132   6.319

Landscape Metrics
=================

With SDMTools
-------------

### Patch Statistics

### Class Statistics

Roll your own
-------------

Spatial Statistics
==================

Point Pattern Analysis
----------------------

### Ripley's K

Autocorrelation and Variography
-------------------------------

### Moran's I - Testing Residuals

### Variogram

Spatial Interpolation
---------------------

### Inverse Distance Weighting

### Splines

### Kriging