FROM gitpod/workspace-full-vnc

USER root

# Required to get paraview to work
RUN apt-get update                                             \
    && apt install -y libxkbcommon-x11-0

# Add script to open vnc window in seperate window
RUN cat <<EOF > /usr/bin/open-vnc-window
#!/usr/bin/env bash

\$GP_EXTERNAL_BROWSER \$(gp url 6080)
EOF
RUN chmod +x /usr/bin/open-vnc-window

# Add script to open vnc window in seperate window
RUN cat <<EOF > /usr/bin/open-notebook-window
#!/usr/bin/env bash

\$GP_EXTERNAL_BROWSER "\$(notebook-url \$1)"
EOF
RUN chmod +x /usr/bin/open-notebook-window

RUN cat <<EOF > /usr/bin/notebook-url
#!/usr/bin/env bash

eval \$(gp env -e)
if [ $# -eq 0 ]; then
  echo "\$(gp url 8888)/?token=\$BDMGP_JUPYTER_TOKEN"
elif [ $# -eq 1 ]; then
  echo "\$(gp url 8888)/notebooks/\$1?token=\$BDMGP_JUPYTER_TOKEN"
else 
  exit -1
fi
EOF
RUN chmod +x /usr/bin/notebook-url

eval $(gp env -e)
USER gitpod

RUN PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.9.1 \
    && pyenv global 3.9.1

RUN git clone https://github.com/BioDynaMo/biodynamo.git    \
    && cd biodynamo                                         \
    && export SILENT_INSTALL=1                              \
    && ./prerequisites.sh all                               \
    && mkdir build                                          \
    && cd build                                             \
    && cmake -Dnotebooks=on ..                              \
    && make -j16

# Patch paraview shell function to open VNC window before
RUN cat <<EOF > /home/gitpod/biodynamo/bin/sh_functions/paraview
#!/usr/bin/env bash

paraview() {
  open-vnc-window
  "\${ParaView_DIR}/bin/paraview" "\$@"
}
EOF
RUN chmod u+x /home/gitpod/biodynamo/bin/sh_functions/paraview

# Patch jupyter notebook configuration
RUN echo "c.NotebookApp.allow_origin = '*'" >> ~/biodynamo/build/third_party/root/etc/notebook/jupyter_notebook_config.py

# Source BioDynaMo by default
RUN echo 'source $HOME/biodynamo/build/bin/thisbdm.sh' >> $HOME/.bashrc

# Set default branch name
RUN git config --global init.defaultBranch master

