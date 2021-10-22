FROM gitpod/workspace-full-vnc

USER root
RUN apt-get update                                             \
    && apt-get install -y x11-apps


USER gitpod

