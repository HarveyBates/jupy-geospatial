# Jupy-Geospatial

A complete jupyter lab setup for geospatial development in python. 
Builds and installs all dependencies in a docker container, 
then runs a jupyter lab server which can be accessed from the host
machine.

## Why

Geospatial development in python should be fun! Instead every-time I find 
myself reinstalling packages (Cartopy, PROJ and GEOS) and getting installation conflicts along the way. This docker image aims to handle the installation process and 
provide a clean **working** environment.

## Installation

*Requires [docker](https://www.docker.com/)*

### Clone

```bash
git clone https://github.com/HarveyBates/jupy-geospatial
cd jupy-geospatial
```

### Build docker container

Runs once, takes about 20 mins. 

```bash
docker build -t pygeo .
```

### Run

Installs required python dependencies (if required). 

```bash
docker run --name pygeo_container -it -p 8888:8888 -v ${PWD}:/root/jupy-geospatial pygeo
```

The terminal will output a url that can be navigated to on the host computer. 
Something like: 127.0.0.1:8888/lab/?token=<unique_token>. Or you can navigate 
to localhost:8888/lab and enter the token provided to you.

# License

This work is MIT licensed, as found in the [LICENSE](https://github.com/HarveyBates/jupy-geospatial/blob/master/LICENCE) file.
