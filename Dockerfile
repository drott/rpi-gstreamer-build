FROM resin/rpi-raspbian:stretch

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y \
    python3 \
    git-core \
    libx11-dev \
    libgl1-mesa-dev \
    libraspberrypi-dev \
    pkg-config \
    meson \
    build-essential
RUN pkg-config --exists x11 && echo "x11 found by pkg-config" || echo "x11 not found by pkg-config"
ADD meson-debug-x11 meson-debug-x11
RUN set -x \
    && cd meson-debug-x11 \
    && meson builddir
RUN git config --global user.email "test@example.com" \
    && git config --global user.name "Dummy User"
RUN cd / \
    && rm -rf /cerbero \
    && git clone git://anongit.freedesktop.org/gstreamer/cerbero \
    && cd cerbero \
    && git pull --rebase
RUN mkdir -p /root/.cerbero/
COPY cerbero.cbc /root/.cerbero/cerbero.cbc
RUN set -x \
    && cd /cerbero \
    && python3 ./cerbero-uninstalled bootstrap \
    && python3 ./cerbero-uninstalled build libffi zlib glib gtk-doc-lite \
        gobject-introspection gstreamer-1.0 libxml2 libogg libpng pixman expat \
        bzip2 freetype fontconfig cairo harfbuzz pango libvorbis libtheora \
        libvisual orc opus graphene libjpeg-turbo cdparanoia
RUN set -x \
    && apt-get install -y \
    python3-setuptools \
    strace \
    python3-pip
COPY cerbero-gnueabihf.patch .
RUN set -x \
    && cd /cerbero \
    && patch -p1 < ../cerbero-gnueabihf.patch
RUN echo 'env' | python3 /cerbero/cerbero-uninstalled shell --use-system-libs
RUN set -x \
    && cd /cerbero \
    && python3 ./cerbero-uninstalled build gst-plugins-base-1.0

RUN [ "cross-build-end" ]