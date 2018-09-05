FROM resin/rpi-raspbian:stretch

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y \
    python3 \
    git-core \
    libx11-dev \
    libgl1-mesa-dev \
    libraspberrypi-dev \
    pkg-config
RUN pkg-config --exists x11
RUN git clone git://anongit.freedesktop.org/gstreamer/cerbero
RUN git config --global user.email "test@example.com" \
    && git config --global user.name "Dummy User"
RUN mkdir -p /root/.cerbero/
COPY cerbero.cbc /root/.cerbero/cerbero.cbc
RUN set -x \
    && cd cerbero \
    && python3 ./cerbero-uninstalled bootstrap \
    && python3 ./cerbero-uninstalled build gst-plugins-base-1.0

RUN [ "cross-build-end" ]