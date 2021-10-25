#!/bin/bash

set -x

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))

cp -r $BDMSYS/notebook /workspace 
cd /workspace 

# open vnc window
bash -c "sleep 5; $GP_EXTERNAL_BROWSER $(gp url 6080)" &

# jupyter notebooks
export BDMGP_JUPYTER_TOKEN=$(echo $RANDOM | sha256sum | cut -c -64)
bash -c "sleep 5; $GP_EXTERNAL_BROWSER \"$(gp url 8888)/?token=$BDMGP_JUPYTER_TOKEN\"" &
jupyter-notebook \
  --NotebookApp.token=$BDMGP_JUPYTER_TOKEN \
  --no-browser

