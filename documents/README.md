# Development Guide

This sections describes guide and steps to develop this InaSAFE Web Platform.
The application stacks consists of 3 main components: frontend, backend, and mapping backend.
Aside from these 3 components, we also have general guidelines to develop the platform.

## General guidelines

In general, the documentations assumes the following technical requirement to develop the platform:

- Basic GIS and spatial data terminology and understanding, such as vector layer, raster layer, base map, etc
- An understanding of how Git version control works
- An understanding on how to run common Unix/Linux command or scripts using terminal
- An understanding on Test Driven Development methodology
- Basic knowledge of internet networking and protocol, such as http, reverse proxy, and client-server programming
- Basic knowledge about config file, environment variables, and Makefile build arrangements

## Frontend

Frontend component is a web client code that will run on browsers. 
Technical requirements to develop frontend code usually involves familiarity with web based technology.

- How to use and design web page using HTML
- How to style documents using CSS
- How to implement web page behaviour using Javascript

In addition to that, developer might need further knowledge on using Javascript based stack on developing the web frontend.
It is not necessary, but highly recommended.

- Javascript Web Client standard API (We usually refer to Mozilla Develepor Network)
- Javascript language specification for Web client ES6
- Backbone.js library approach
- Require.js module organization approach
- jQuery utilities library
- Bootstrap framework for CSS and Javascript components
- Leaflet.js library for map client rendering
- Asynchronous request paradigm using async await or promises
- AJAX requests concepts

## Backend

Backend component is a stack and consists of one or more components that serves to handle data layer requests from the frontend.
Our backend also deals with spatial data model, so it is also good if you have an understanding of spatial data.
Backend component needs to be able to serve as REST API endpoint at the bare minimum, to handle outside requests.
We are not supporting GraphQL yet.
For internal processings, functions, methods, and jobs, this backend supports PostgreSQL and PostGIS functions. 
In addition to that, we also support python code executions via PlPython extensions.
We mainly uses python 3.
Since backend also sometimes needs an extra setup to make it run as expected, we sometimes also uses shell script (bash) to help do the job.

In summary, the following technical requirement are needed to develop the backend

- Basic understanding on how to use Relational Database (RDBMS), such as using SQL to execute SQL statements
- Basic understanding on how data model are designed using ER Diagram, with terminologies such as relationships, tables, foreign keys, primary keys, index, etc
- Basic understanding on how REST API works. How to make REST request and received REST responses, how to filter and query dataset via REST endpoint. 
- Can read JSON object
- Can read SQL statement
- Can read YAML file
- Basic understanding of spatial data structure/object, such as Geometry, Polygon, MultiPolygon, Features, Line, etc
- Can read JSON object for spatial data format, which is also called GeoJSON
- Can read and understand spatial data format used in SQL statement. Usually in a WKT format (Well Known Text), sometimes as WKT or WKB (WKT but in binary format) 

In addition to that, we listed below some domain specific technical requirements:

- We uses PostgreSQL, so a good understanding on how to work with PostgreSQL is required, such as using PSQL session, or PostgreSQL dialect and it's keywords
- We sometimes uses Bash scripting, so a good understanding on using Bash helps a lot
- We uses Python 3 to develop for binding and writing core logic of backend processing functions. An understanding on how to run Python script and install Python libraries will help
- We uses PL/Python 3 extensions called plpython3u to run Python 3 code from inside PostgreSQL.
- We uses PostGIS. Some of the functions for spatial processing are provided by PostGIS, such as geometry intersections, indexing, and representations
- We uses PostgREST, a wrapper service to interface with PostgreSQL database by using REST API endpoint and calls
- We mainly uses Docker and Docker Compose to set up database instance and other services
- We uses OpenStreetMap data
- We uses imposm to read/extract PBF files from OSM and to update database with OSM data

## Mapping Backend

Our mapping backend uses GeoServer by binding it with our database to read spatial data.
We setup GeoServer and provide connections to our database so we can define Feature Layer using tables or SQL view.
We also define layer styling and layer group using GeoServer.
The map client in the frontend component then uses GeoServer as it's map API endpoint, typically by using WMS/WFS requests.

In general we only uses GeoServer, not develop an extension to GeoServer itself. So we are mainly a user for this component.

Some general technical requirements for this components:

- Basic understanding on how OGC standard Spatial Endpoint works, such as using WMS or WFS services
- How map tiling works
- How layer stylings using SLD works
- How to use GeoServer in general (create feature type, layers, layergroup, styles, define data stores, etc)

In addition to that, we don't actually develop in GeoServer, but we do uses GeoServer REST API to set up initial fixtures or object definitions in GeoServer.
For this, you can use any tools of your choice to make REST API calls to define the REST objects.
At the moment, we are using Python code via requests library to initiate REST calls. 
However you can use other tools, such as cURL requests (via bash script).
