# Creating integration tests data

We sometimes want to clip out OSM data for smaller extent. This smaller dataset then can be used for integration tests to quickly check the algorithm and output.

## Prerequisites

 - PBF file of the source you want to extract
 - Osmosis tools installed. [https://wiki.openstreetmap.org/wiki/Osmosis](https://wiki.openstreetmap.org/wiki/Osmosis)
 - Your clip bounding box/extent
 
 
## Steps

Use Osmosis with the following command line:

```shell script
osmosis --read-pbf <country.pbf> --bounding-box left=<x1> right=<x2> top=<y1> bottom=<y2> --write-pbf <extract.pbf>
```

The above command will use bounding box in lon/lat format x1,y1 - x2,y2 and clip the content of the PBF file `country.pbf`
The output then will be stored in `extract.pbf`

You can than import the pbf file using `imposm`

Since this will become the initial osm data, you need to rename the file 
`extract.pbf` as `country.pbf` in the `docker-osm-settings/custom_settings` 
directory and run `make first-pbf-import` again to import the data

## Packaging OSM data for integration tests using docker

We use the folowing simple way to package the osm data into a docker image

```shell script
docker run --rm -d --name resources busybox
```
