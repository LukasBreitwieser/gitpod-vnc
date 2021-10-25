#!/bin/bash

set -x

cp -r $BDMSYS/notebook /workspace 
cd /workspace 
$GP_EXTERNAL_BROWSER $(gp url 6080)
jupyter-notebook
