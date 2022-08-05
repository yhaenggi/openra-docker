These images have been built and tested on docker amd64, arm32v7 and arm64v8. This is a multi platform image.

## Usage ##

    docker run -d -p 1234:1234/tcp yhaenggi/openra:20210321

Its set up to not load any games by default (new game) but you can change it with the CMD argument. 


## Build ##

If you want to build the images yourself, you'll have to adapt the registry file, copy qemu and enable binfmt.

    cp /usr/bin/qemu-{x86_64,arm,aarch64}-static .

In case you want other arches, just add them in the ARCHES files and copy the corresponding qemu user static binary. If you want support for another archtitecture, open an issue.

You can verify binfmt support for multiarch builds with (should show enabled):

    grep -E "arm|aarch" -A1 -R /proc/sys/fs/binfmt_misc/

## Tags ##
   * 20210321
