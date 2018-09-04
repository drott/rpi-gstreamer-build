FROM resin/rpi-raspbian:stretch

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y \
    python3 \
    git-core
RUN git clone git://anongit.freedesktop.org/gstreamer/cerbero
RUN mkdir -p /root/.cerbero/
COPY cerbero.cbc /root/.cerbero/cerbero.cbc
RUN set -x \
    && cd cerbero \
    && python3 ./cerbero-uninstalled bootstrap \
    && python3 ./cerbero-uninstalled package gstreamer-1.0

RUN [ "cross-build-end" ]