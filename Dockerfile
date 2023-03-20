ARG ARCH
FROM ${ARCH}/mono:latest
MAINTAINER yhaenggi <yhaenggi-git-public@darkgamex.ch>

ARG ARCH
ENV ARCH=${ARCH}

ARG VERSION
ENV VERSION=${VERSION}

COPY ./qemu-arm-static /usr/bin/qemu-arm
COPY ./qemu-aarch64-static /usr/bin/qemu-aarch64

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates wget liblua5.1 libsdl2-2.0-0 libopenal1 make \
&& apt-get clean && rm -Rf /var/cache/apt/ && rm -Rf /var/lib/apt/lists

RUN groupadd openra -g 911
RUN useradd openra -u 911 -g 911 -m -s /bin/bash

WORKDIR /home/openra

RUN mkdir src
RUN cd src && wget https://github.com/OpenRA/OpenRA/releases/download/release-${VERSION}/OpenRA-release-${VERSION}-source.tar.bz2 -O - | bzip2 -d | tar xf -

RUN cd src && make TARGETPLATFORM=unix-generic RUNTIME=mono && rm -R /root/.local/ /root/.nuget/

RUN mkdir .openra .openra/Logs .openra/Content .openra/Replays
RUN chown -Rv openra:openra .openra

EXPOSE 1234

USER openra

WORKDIR /home/openra/src
ENTRYPOINT ["/bin/bash"]
CMD ["/home/openra/src/launch-dedicated.sh"]
