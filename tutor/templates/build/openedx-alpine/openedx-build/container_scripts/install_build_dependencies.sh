#!/bin/sh
set -e
set -x

wget -q -O - https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xzf - --directory /usr/local/bin

echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

apk add \
    freetype-dev \
    g++ \
    gcc \
    geos-dev@testing \
    gettext \
    gfortran \
    git \
    graphviz \
    graphviz-dev \
    jpeg-dev \
    lapack-dev \
    libffi-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    mariadb-dev \
    nodejs \
    pkgconfig \
    python-dev \
    sqlite-dev \
    swig \
    xmlsec-dev
