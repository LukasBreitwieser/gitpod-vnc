#!/bin/bash

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))

cp -r $BDMSYS/notebook /workspace 
cd /workspace/notebook 
rm ST*.html

# start Jupyter notebooks server
export BDMGP_JUPYTER_TOKEN=$(echo $RANDOM | sha256sum | cut -c -64)
gp env BDMGP_JUPYTER_TOKEN=$BDMGP_JUPYTER_TOKEN
jupyter-notebook \
  --NotebookApp.token=$BDMGP_JUPYTER_TOKEN \
  --no-browser

