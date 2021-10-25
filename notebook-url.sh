#!/usr/bin/env bash

eval $(gp env -e)
if [ $# -eq 0 ]; then
  echo "$(gp url 8888)/?token=$BDMGP_JUPYTER_TOKEN"
elif [ $# -eq 1 ]; then
  echo "$(gp url 8888)/notebooks/$1?token=$BDMGP_JUPYTER_TOKEN"
else 
  exit -1
fi
