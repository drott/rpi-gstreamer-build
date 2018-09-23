# rpi-gstreamer-build

Attempt to build latest gstreamer for Raspberry Pi using a Resin qemu enabled image.

Spun off from this gstreamer-devel thread: https://lists.freedesktop.org/archives/gstreamer-devel/2018-September/069132.html

More details on the approach in:
https://docs.resin.io/reference/base-images/base-images/#resin-xbuild-qemu

Currently completes the build and generates packages inside the container.

## Known issues

* It is complicated to extract the build packages
  for now: They are listed at the end, you can copy them out using `docker cp`
  after having created an image.

## Build

Try a build using

`$ docker -t rpi-gstreamer-build:latest .`
