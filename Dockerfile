ARG BASE_CONTAINER=jupyter/base-notebook:aec555e49be6
FROM $BASE_CONTAINER

MAINTAINER Fanda Blahoudek <fandikb+dev@gmail.com>

USER root

# Dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  graphviz \
  libncurses5-dev
RUN pip3 install -U cython

# Install Awali
COPY install_awali.sh fix_awalipy.patch /tmp/
RUN cd /tmp && ./install_awali.sh && rm -f install_awali.sh

# Copy content
COPY README.md ${HOME}

# Clear the empty directory inherited
# from jupyter/base-notebook
RUN rm -r ${HOME}/work

RUN chown -R ${NB_UID} ${HOME}

# Switch back to jovyan user to avoid accidental container
# runs as root
USER $NB_UID
