#!/usr/bin/env bash

# Install venv (create python virtual environment)
echo "Creating Python virtual environment..."
cd /root
python3.9 -m venv jupy-geospatial
cd jupy-geospatial
chmod +x bin/activate
source bin/activate 
echo "Python virtual environment created."

# Install requirements.txt in the container
echo "Installing Python requirements..."
cd /root/jupy-geospatial
python3 -m pip install --upgrade pip
pip install -r requirements.txt
echo "Installed Python requirements."

# Run jupyter lab
echo "Running jupyter lab server on port 8888."
cd /root/jupy-geospatial
jupyter lab --ip 0.0.0.0 --port 8888 --no-browser --allow-root
