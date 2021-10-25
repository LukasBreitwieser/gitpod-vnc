#!/bin/bash

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))

# reset
echo -e '\0033\0143'

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
echo "To compile and run the simulation, first change into the demo directory:"
echo "cd $BDM_TRY_DEMO"
echo "and then call:"
echo "bdm run"
