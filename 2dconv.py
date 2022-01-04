import argparse
import json

import matplotlib.pyplot as plt
import os
import numpy as np
import csv

from acconeer.exptool import recording, utils

# Paths
directory_src = "data_src/"
directory_dst = "data_dst/"
filename_converted = "data_converted.csv"


def main():
    data = []
    for file in os.listdir("data_src/"):
        print(file)	# Prints file name to console
        
	# Retrieves the current file 
        record = recording.load(directory_src + file)
	# Reads specified data
        depths = utils.get_range_depths(record.sensor_config, record.session_info)
	
	# Datatype check
        if len(record.data.shape) == 3: # Envelope, IQ, Power bind
            z = np.mean(np.abs(record.data[:, 0, :]), axis=0).T
	    # This line compresses the data over one dimension, takes the average of each point and transposes the matrix.
            
            data.append(z)
            # Adding to list of files
        else:
            print("Wrong format! Are settings default?")

    # Rotate into correct direction
    data = np.flipud(np.rot90(np.vstack(data)))
    # Add file names as data legends
    data_legend = str(os.listdir(directory_src))[1:-1]

    # Export the processed data as a .CSV file. 
    np.savetxt(directory_dst + filename_converted, data, delimiter=',', header=data_legend)

if __name__ == "__main__":
    main()
