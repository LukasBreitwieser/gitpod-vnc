#!/bin/bash

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))

# reset
echo -e '\0033\0143'

echo "Welcome to BioDynaMo on gitpod!"
echo ""

# create setting to open markdown files in preview mode.
mkdir -p /workspace/.vscode
cat << EOF > /workspace/.vscode/settings.json
{
    "workbench.editorAssociations": {
        "*.md": "vscode.markdown.preview.editor"
    },
}
EOF

# unset git credential helper
git config --global --unset credential.helper

# wait until jupyter is ready
gp await-port 8888 &>/dev/null

if [ ! -z $BDM_TRY_NOTEBOOK ]; then
  # Jupyter notebooks
  echo "To open the notebook ($BDM_TRY_NOTEBOOK), click on the following link:"
  echo "  $(notebook-url $BDM_TRY_NOTEBOOK)"
  # This might be blocked by the browser's pop-up blocker
  # open-notebook-window $BDM_TRY_NOTEBOOK
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
  echo "To create a new simulation execute the following command:"
  echo "  bdm new my-sim"
fi

echo ""
echo "Additional resources: "
echo "User guide:    https://biodynamo.org/docs/userguide/"
echo "API reference: https://biodynamo.org/api"
echo "Forum:         https://forum.biodynamo.org/"

