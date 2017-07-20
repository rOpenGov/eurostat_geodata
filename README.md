# Directory contents

[rdata](rdata) Key data sets from Geographical information system of the Commission (GISCO) as RData files. 

[rscripts](rscripts) Automated scripts that were used to convert Geographical information system of the Commission (GISCO) GIS data into RData format.

This repository is associated with Eurostat-packege within the rOpenGov project.

# Available data sets in R

[CISGO provides geospatial data in five different resolutions and in many different formats](http://ec.europa.eu/eurostat/web/gisco/geodata/reference-data/administrative-units-statistical-units/nuts). For these collections we use `Shapefile` type and withing the zipfile we use `NUTS_RG_XXM_2013.shp` version of the shapefile in all five resolution.

As for **object classes** in R, we provide the data in three different classes

1. `sf`: *simple features* as in package [`sf`](https://cran.r-project.org/web/packages/sf/index.html)
2. `spdf`: *SpatialPolygonDataFrame* as in package [`sp`](https://cran.r-project.org/web/packages/sp/index.html)
3. `df`: *"fortified" data.frame* for plotting with  [`ggplot2`](https://cran.r-project.org/web/packages/ggplot2/index.html)-package

Eventually as `sf` matures we are planning to migrate solely to `sf´.

# License

In addition to the general copyright and licence policy applicable to the whole Eurostat website, the following specific provisions apply to the datasets you are downloading. The download and usage of these data is subject to the acceptance of the following clauses:

1. The Commission agrees to grant the non-exclusive and not transferable right to use and process the Eurostat/GISCO geographical data downloaded from this page (the "data").
2. The permission to use the data is granted on condition that:
    1. the data will not be used for commercial purposes;
    2. the source will be acknowledged. A copyright notice, as specified below, will have to be visible on any printed or electronic publication using the data downloaded from this page.

When data downloaded from this page is used in any printed or electronic publication, in addition to any other provisions applicable to the whole Eurostat website, data source will have to be acknowledged in the legend of the map and in the introductory page of the publication with the following copyright notice:

- `EN: (C) EuroGeographics for the administrative boundaries`
- `FR: (C) EuroGeographics pour les limites administratives`
- `DE: (C) EuroGeographics bezÃ¼glich der Verwaltungsgrenzen`

For publications in languages other than English, French or German, the translation of the copyright notice in the language of the publication shall be used.

If you intend to use the data commercially, please contact [EuroGeographics](http://www.eurogeographics.org/) for information regarding their licence agreements

***

All scripts in this directory are available with the FreeBSD (BSD-2-clause) license:

Copyright (c) 2016-2017, Markus Kainu / rOpenGov All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.