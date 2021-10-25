#!/bin/bash

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))

# reset
echo -e '\0033\0143'

echo "Welcome to BioDynaMo on gitpod!"
echo ""

if [ ! -z $BDM_TRY_NOTEBOOK ]; then
  # Jupyter notebooks
  echo "To open the notebook ($BDM_TRY_NOTEBOOK), click on the following link:"
  echo "  $(notebook-url $BDM_TRY_NOTEBOOK)"
elif [ ! -z $BDM_TRY_DEMO ]; then
  # Demo
  bdm demo $BDM_TRY_DEMO
  cd $BDM_TRY_DEMO
  echo ""
  echo "To compile and run the simulation, first change into the demo directory:"
  echo "cd $BDM_TRY_DEMO"
  echo "and then call:"
  echo "bdm run"
else
  # Develop new simulation 
  echo "To open the list of available notebooks, click on the following link:"
  echo "  $(notebook-url)"
  echo ""
  echo "Create a new simulation with: bdm new my-sim"
fi

echo ""
echo "Additional resources: "
echo "User guide:    https://biodynamo.org/docs/userguide/"
echo "API reference: https://biodynamo.org/api"
echo "Forum:         https://forum.biodynamo.org/"

