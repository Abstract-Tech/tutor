#!/bin/sh

# Build an image including all dependencies needed to build openedx

set -e
set -x

IMAGE_BASENAME=${IMAGE_BASENAME:-openedx}
IMAGE_BUILDWHEELS=${IMAGE_BUILDWHEELS:-${IMAGE_BASENAME}-buildwheels}
IMAGE_BASE=${IMAGE_BASE:-${IMAGE_BASENAME}-base}
IMAGE_WHEELS=${IMAGE_WHEELS:-${IMAGE_BASENAME}-wheels}

PIP_CACHE=${PIP_CACHE:-/var/cache/pip-alpine}
APK_CACHE=${APK_CACHE:-/var/cache/apk}
NPM_CACHE=${NPM_CACHE:-/var/cache/npm}

export DOCKERIZE_VERSION=${DOCKERIZE_VERSION:-v0.6.1}

DIR=$(dirname $(readlink -f "$0"))

if [ $(id -u) != '0' ]; then
    alias buildah='sudo buildah'
fi

if (buildah images|grep ^localhost/${BASE_BUILD_IMAGE}\ ); then
    echo '\e[1;32m'Not building ${BASE_BUILD_IMAGE}: already built'\e[0m'
else
    CONTAINER=$(buildah from python:2-alpine3.7)
    CONTAINER=${CONTAINER%%[[:space:]]}

    buildah config \
        --env DOCKERIZE_VERSION=$DOCKERIZE_VERSION \
        $CONTAINER

    # Copy our scripts to the container
    buildah copy $CONTAINER $DIR/container_scripts /openedx/bin/

    # Install dependencies with package manager
    buildah run -v $APK_CACHE:/var/cache/apk $CONTAINER -- /openedx/bin/install_build_dependencies.sh

    buildah commit --rm $CONTAINER ${BASE_BUILD_IMAGE}

    echo Built base build image '\e[1;32m'${BASE_BUILD_IMAGE}'\e[0m'.
fi

if (buildah images|grep ^localhost/${BASE_IMAGE}\ ); then
    echo '\e[1;32m'Not building ${BASE_IMAGE}: already built'\e[0m'
else
    CONTAINER=$(buildah from python:2-alpine3.7)
    CONTAINER=${CONTAINER%%[[:space:]]}

    buildah config \
        --env DOCKERIZE_VERSION=$DOCKERIZE_VERSION \
        $CONTAINER

    # Copy our scripts to the container
    buildah copy $CONTAINER $DIR/container_scripts /openedx/bin/

    # Install dependencies with package manager
    buildah run -v $APK_CACHE:/var/cache/apk $CONTAINER -- /openedx/bin/install_run_dependencies.sh

    buildah commit --rm $CONTAINER ${BASE_IMAGE}

    echo Built base build image '\e[1;32m'${BASE_IMAGE}'\e[0m'.
fi
