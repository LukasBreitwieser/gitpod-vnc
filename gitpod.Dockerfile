FROM gitpod/workspace-full-vnc

USER root

RUN apt-get update                                             \
    && apt install -y libxkbcommon-x11-0

USER gitpod

RUN PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.9.1 \
    && pyenv global 3.9.1

RUN cd /workspace \
    && git clone https://github.com/BioDynaMo/biodynamo.git \
    && cd biodynamo                                         \
    && ./prerequisites.sh all                               \
    && ln -s /workspace/.pip-modules/share/jupyter /home/gitpod/.pyenv/versions/3.9.1/share/jupyter \
    && ln -s /workspace/.pip-modules/etc ~/.pyenv/versions/3.9.1/etc \
    && mkdir build                                          \
    && cd build                                             \
    && cmake -Dnotebooks=on ..                              \
    && make -j16                                            \
    && echo "c.NotebookApp.allow_origin = '*'" >> /workspace/biodynamo/build/third_party/root/etc/notebook/jupyter_notebook_config.py

