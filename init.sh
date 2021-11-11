#!/bin/bash

BDM_SCRIPT_DIR=$(readlink -e $(dirname "${BASH_SOURCE[0]}"))

# create setting to open markdown files in preview mode.
mkdir -p /workspace/.vscode
cat << EOF > /workspace/.vscode/settings.json
{
    "workbench.editorAssociations": {
        "*.md": "vscode.markdown.preview.editor"
    },
}
EOF

echo "Welcome to BioDynaMo on gitpod!"
echo ""

# wait until jupyter is ready
gp await-port 8888 &>/dev/null

if [ ! -z $BDM_TRY_NOTEBOOK ]; then
  # This might be blocked by the browser's pop-up blocker
  # open-notebook-window $BDM_TRY_NOTEBOOK
  echo ""
elif [ ! -z $BDM_TRY_DEMO ]; then
  # Demo
  bdm demo $BDM_TRY_DEMO
fi

# Create and open the welcome page
$BDM_SCRIPT_DIR/welcome-page/compile.py
gp open /workspace/BioDynaMo-welcome.md

# reset
echo -e '\0033\0143'
