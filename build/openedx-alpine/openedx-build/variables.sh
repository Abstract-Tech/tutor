TUTOR_DOCKER_DIR="$(cd "$(dirname "$0")"/../..; pwd)"
export IMAGE_BASENAME=${IMAGE_BASENAME:-openedx}

# TODO: keep in sync with tutor `tutor/templates/build/openedx/Dockerfile`
export EDX_PLATFORM_REPOSITORY=https://github.com/edx/edx-platform.git
export EDX_PLATFORM_VERSION=open-release/ironwood.1

IMAGE_BASENAME=${IMAGE_BASENAME:-openedx}
IMAGE_BUILDWHEELS=${IMAGE_BUILDWHEELS:-${IMAGE_BASENAME}-buildwheels}
IMAGE_BASE=${IMAGE_BASE:-${IMAGE_BASENAME}-base}
IMAGE_WHEELS=${IMAGE_WHEELS:-${IMAGE_BASENAME}-wheels}

PIP_CACHE=${PIP_CACHE:-/var/cache/pip-alpine}
APK_CACHE=${APK_CACHE:-/var/cache/apk}
NPM_CACHE=${NPM_CACHE:-/var/cache/npm}

export DOCKERIZE_VERSION=${DOCKERIZE_VERSION:-v0.6.1}

if [ $(id -u) != '0' ]; then
    alias buildah='sudo buildah'
fi
