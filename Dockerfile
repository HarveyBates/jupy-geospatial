# All files are handled internally throught volumes so if docker crashes the saved files will
# still be on your host computer.

FROM ubuntu:18.04

ENV HOME /root
WORKDIR /root

# Prevents timezone question being propted when installing python requirements
ENV TZ=Australia/Sydney \
    DEBIAN_FRONTEND=noninteractive

# Mandetory update and upgrade 
RUN apt-get update
RUN apt-get upgrade -y

# Install required dependencies for GEOS, PROJ and CMAKE
# Also install other useful items such as git 
RUN apt-get install -y \
	'build-essential' \
	'software-properties-common' \
	'libssl-dev' \
	'zlib1g' \
	'zlib1g-dev' \
	'libjpeg-dev' \
	'libpng-dev' \
	'libtiff5-dev' \
	'tzdata' \
	'libcurl4-openssl-dev' \
	'curl' \
	'wget' \
	'git' \
	'make' 

# Install sqlite and lib dev env as required for building PROJ
RUN apt install --quiet -y \
	'sqlite3' \
	'libsqlite3-dev'

# Install cmake (3.23.0) from source (required for proj and geos builds)
# Default cmake is only version 3.10.2 thus a build from source is needed 
# This takes a while (approx 8 minutes) and the output is too long for dockers 
# build log so you will get the message "[output clipped, log limit 100KiB/s reached]". 
# This is fine and the builder is still running in the background.
RUN \
	cd /opt && \
	wget https://github.com/Kitware/CMake/releases/download/v3.23.0/cmake-3.23.0.tar.gz && \
	tar -xvzf cmake-3.23.0.tar.gz && \
	rm cmake-3.23.0.tar.gz && \
	cd cmake-3.23.0/ && \
	./configure && \
	make -s && \
	make install -s && \
	ln -s /opt/cmake-3.23.0/bin/* /usr/bin

# Install GEOS (3.10.2) from source
RUN \
	cd /opt && \
	wget https://github.com/libgeos/geos/archive/refs/tags/3.10.2.tar.gz && \
	tar -xvzf 3.10.2.tar.gz && \
	rm 3.10.2.tar.gz && \
	cd geos-3.10.2 && \
	mkdir build && cd build && \
	cmake -DCMAKE_BUILD_TYPE=Release .. && \
	make -s && \
	make install -s

# Install PROJ (9.0.0) from source (requires sqlite3)
RUN \
	cd /opt && \
	wget https://github.com/OSGeo/PROJ/releases/download/9.0.0/proj-9.0.0.tar.gz && \
	tar -xvzf proj-9.0.0.tar.gz && \
	rm proj-9.0.0.tar.gz && \
	cd proj-9.0.0 && \
	mkdir build && cd build && \
	cmake .. && \
	cmake --build . && \
	cmake --build . --target install

# Install python virtual environment requirements
RUN apt-get update && \
	add-apt-repository ppa:deadsnakes/ppa -y && \
	apt-get update && \
	apt-get install -y \
	'python3.9-venv' \
	'python3.9-dev' \
	'python3-pip' \
	'python3.9' 

# This sets up a virtual python environment and starts jupyter lab
ENTRYPOINT ["bash", "/root/jupy-geospatial/entrypoint.sh"]
