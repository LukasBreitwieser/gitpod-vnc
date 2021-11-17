FROM gitpod/workspace-full-vnc

USER root

# Required to get paraview to work
RUN apt-get update                                             \
    && apt install -y libxkbcommon-x11-0

# required by optim
RUN apt-get -y install libgsl-dev libarmadillo-dev

# Add script to open vnc window in seperate window
COPY open-vnc-window.sh /usr/bin/open-vnc-window
RUN chmod +x /usr/bin/open-vnc-window

# Add script to open vnc window in seperate window
COPY open-notebook-window.sh /usr/bin/open-notebook-window
RUN chmod +x /usr/bin/open-notebook-window

COPY notebook-url.sh /usr/bin/notebook-url
RUN chmod +x /usr/bin/notebook-url

USER gitpod

RUN PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.9.1 \
    && pyenv global 3.9.1

# Turn off NUMA, to avoid "mbind: Operation not permitted", 
# errors caused by docker security constraints
RUN git clone https://github.com/BioDynaMo/biodynamo.git     \
    && cd biodynamo                                          \
    && git checkout e1088d4ae3fed9e75bc2468dc54f95895108d31e \
    && export SILENT_INSTALL=1                               \
    && ./prerequisites.sh all                                \
    && mkdir build                                           \
    && cd build                                              \
    && cmake -Dnotebooks=on -Dnuma=off ..                    \
    && make -j8

# Patch paraview shell function to open VNC window before
COPY paraview.sh /home/gitpod/biodynamo/build/bin/sh_functions/paraview

# Patch jupyter notebook configuration
RUN echo "c.NotebookApp.allow_origin = '*'" >> ~/biodynamo/build/third_party/root/etc/notebook/jupyter_notebook_config.py

# Source BioDynaMo by default
RUN echo 'source $HOME/biodynamo/build/bin/thisbdm.sh &>/dev/null' >> $HOME/.bashrc

# Set default branch name
RUN git config --global init.defaultBranch master

