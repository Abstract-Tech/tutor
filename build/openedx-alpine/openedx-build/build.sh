#!/bin/sh
set -e
set -x

DIR=$(dirname $(readlink -f "$0"))
. "${DIR}/variables.sh"

"${DIR}/build_base_alpine.sh"


# A git proxy can be run with
# docker run --name gitcache -d --rm -p 8080:8080 -v /var/cache/git:/tmp/cache/git kurzdigital/git-cache-http-server
# and an environment variable can be set, like:
# export GIT_CACHE_PROXY_URL=http://172.17.0.1:8080/
# note it should include protocol and trailing slash

if [ -z "$GIT_CACHE_PROXY_URL" ] && (curl -s localhost:8080 -I|grep -q 500\ Internal\ Server\ Err); then
    GIT_CACHE_PROXY_URL=http://172.17.0.1:8080/
fi


# Setup git cache if configured
if [ ! -z "$GIT_CACHE_PROXY_URL" ] ; then
    buildah run $CONTAINER -- git config --global url."$GIT_CACHE_PROXY_URL".insteadOf https://
fi

# Install openedx
buildah run -v $PIP_CACHE:/root/.cache/pip $CONTAINER -- /openedx/bin/install_openedx.sh

# Copy tutor files
buildah copy $CONTAINER $TUTOR_DOCKER_DIR/openedx/bin/* /openedx/bin/
buildah copy $CONTAINER $TUTOR_DOCKER_DIR/openedx/settings/lms /openedx/edx-platform/lms/envs/tutor
buildah copy $CONTAINER $TUTOR_DOCKER_DIR/openedx/settings/cms /openedx/edx-platform/cms/envs/tutor

# Build Open edX nodejs components
buildah run -v $NPM_CACHE:/root/.npm $CONTAINER -- /openedx/bin/build_openedx_node.sh

# Commit development image
# TODO: base the development image off the regular one,
# so that they'll share a big layer.
# buildah commit $CONTAINER openedx-alpine-dev

# Cleanup-v $NPM_CACHE:/root/.npm
buildah run $CONTAINER -- /openedx/bin/cleanup.sh

sudo buildah config \
    --author='Silvio Tomatis' \
    --entrypoint '["/openedx/bin/docker-entrypoint.sh"]' \
    --cmd '/bin/sh -c "gunicorn --name ${SERVICE_VARIANT} --bind=0.0.0.0:8000 --max-requests=1000 ${SERVICE_VARIANT}.wsgi:application"' \
    --workingdir='/openedx/edx-platform' \
    --env CONFIG_ROOT=/openedx/config \
    --env PATH=/openedx/bin:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
    --env SERVICE_VARIANT=lms \
    --env SETTINGS=tutor.production \
    --env DOCKERIZE_VERSION=$DOCKERIZE_VERSION \
    $CONTAINER

# Commit final image
buildah commit $CONTAINER openedx-alpine

# Push the image to local docker
buildah push openedx-alpine docker-daemon:silviot/openedx-alpine:latest
#buildah push openedx-alpine-dev docker-daemon:silviot/openedx-alpine-dev:latest

# Remove the image and the container from buildah
buildah rmi openedx-alpine
buildah rm $CONTAINER
