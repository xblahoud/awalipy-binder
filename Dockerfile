ARG BASE_CONTAINER=jupyter/base-notebook:aec555e49be6
FROM $BASE_CONTAINER

MAINTAINER Fanda Blahoudek <fandikb+dev@gmail.com>

USER root

RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  graphviz

RUN pip3 install -U cython

COPY install_awali.sh /tmp/install_awali.sh
RUN cd /tmp && ./install_awali.sh && rm -f install_awali.sh

COPY . ${HOME}
RUN chown -R ${NB_UID} ${HOME}

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
