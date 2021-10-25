#!/usr/bin/env bash

paraview() {
  open-vnc-window
  "\${ParaView_DIR}/bin/paraview" "\$@"
}
