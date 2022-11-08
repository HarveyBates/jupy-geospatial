#!/usr/bin/env bash

# Install venv (create python virtual environment)
cd /root
python3.9 -m venv jupy_geospatial
cd jupy_geospatial
chmod +x bin/activate
source bin/activate 

# Install requirements.txt in the container
cd /root/jupy_geospatial
python3 -m pip install --upgrade pip
pip install -r requirements.txt
echo "Installed requirements"

# Run jupyter lab (it opens the volume) 
# To see/run the program navigate to src/spatial_temperature.ipynb
cd /root/jupy_geospatial
jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --allow-root
