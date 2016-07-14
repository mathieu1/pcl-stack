#!/bin/bash

# Store existing GDAL env vars and set to this conda env
# so other GDAL installs don't pollute the environment

if [[ -n "$GDAL_DATA" ]]; then
    export _CONDA_SET_GDAL_DATA=$GDAL_DATA
fi
export GDAL_DATA=$CONDA_PREFIX/share/gdal

if [[ -n "$GDAL_DRIVER_PATH" ]]; then
    export _CONDA_SET_GDAL_DRIVER_PATH=$GDAL_DRIVER_PATH
fi
export GDAL_DRIVER_PATH=$CONDA_PREFIX/lib/gdal

# Support plugins if the plugin directory exists
# i.e if it has been manually created by the user
if [[ ! -d "$GDAL_DRIVER_PATH" ]]; then
    unset GDAL_DRIVER_PATH
fi

