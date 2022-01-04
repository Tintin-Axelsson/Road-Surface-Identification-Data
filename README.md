# Identifying of road surface material using 60 GHz pulsed coherent radar.
This repository contains all the RAW data captured for the project. 
It also contains the python script 2dconv.py for processing Acconeers .H5 files into CSV files.
The CSV files can then be used in conjunction with the matlab script show2d.m for further processing and visualization.

# Usage of 2dconv.py
Install the requiered dependenceis found in requirements.txt. Place the .H5 files to be processed in a folder named ~/data_src/ and run python3 2dconv.py. If all goes well a new CSV file will be created in ~/data_dst/ with the processed data.

# Usage of show2d.m
Open the file in matlab and specify CSV path. Experiment with different noise floor levels.
