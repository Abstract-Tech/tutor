#!/bin/sh
set -e
set -x

wget -q -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - --directory /usr/local/bin

echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

apk add \
    geos-dev@testing \
    gettext \
    git \
    graphviz \
    nodejs  `# Is this really a run dependency? Maybe we could install/uninstall it as needed` \
    freetype \
    graphviz \
    lapack \
    libjpeg \
    libxslt \
    libc-dev `# needed by libgeos` \
    mariadb-client-libs \
    sqlite \
    xmlsec
