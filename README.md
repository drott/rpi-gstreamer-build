# rpi-gstreamer-build

Attempt to build latest gstreamer for Raspberry Pi using a Resin qemu enabled image. 

Spun off from this gstreamer-devel thread: https://lists.freedesktop.org/archives/gstreamer-devel/2018-September/069132.html

More details on the approach in:
https://docs.resin.io/reference/base-images/base-images/#resin-xbuild-qemu

## Known issues
Currently likely fails with a dependency issue on x11, for an unknown reason.

## Build

Try a build using

`$ docker -t rpi-gstreamer-build:dev .`
