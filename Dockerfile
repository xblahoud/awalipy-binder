ARG BASE_CONTAINER=jupyter/base-notebook:4d9c9bd9ced0
FROM $BASE_CONTAINER

MAINTAINER Fanda Blahoudek <fandikb+dev@gmail.com>

USER root

# Clear the empty directory inherited
# from jupyter/base-notebook
RUN rm -r ${HOME}/work

# Dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  graphviz \
  libncurses5-dev
RUN pip3 install -U cython

# Install Awali
COPY install_awali.sh /tmp/
RUN cd /tmp && ./install_awali.sh && rm -f install_awali.sh

# Copy content
COPY README.md ${HOME}

RUN chown -R ${NB_UID} ${HOME}

# Switch back to jovyan user to avoid accidental container
# runs as root
USER $NB_UID
