#!/bin/bash

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))
echo "Welcome to BioDynaMo on gitpod!"

# Jupyter notebooks
echo ""
echo "To open the list of available notebooks, click on the following link:"
echo "  $(notebook-url)"
export BDM_TRY_NOTEBOOK=ST01-model-initializer.ipynb
echo "To open the notebook ($BDM_TRY_NOTEBOOK), click on the following link:"
echo "  $(notebook-url $BDM_TRY_NOTEBOOK)"

# Demo
export BDM_TRY_DEMO=soma_clustering
bdm demo $BDM_TRY_DEMO
cd $BDM_TRY_DEMO
echo ""
echo "We created the demo $BDM_TRY_DEMO and changed into this directory."
echo "Compile and run the simulation by calling:"
echo "bdm run"
gp open .
