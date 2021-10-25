#!/bin/bash

set -x

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))

cp -r $BDMSYS/notebook /workspace 
cd /workspace 

# open vnc window
$GP_EXTERNAL_BROWSER $(gp url 6080)

# jupyter notebooks
export BDMGP_JUPYTER_TOKEN=$(echo $RANDOM | sha256sum | cut -c -64)
jupyter-notebook \
  --NotebookApp.token=$BDMGP_JUPYTER_TOKEN \
  --browser="$BDM_SCRIPT_DIR/open-jupyter-url.sh %s"
