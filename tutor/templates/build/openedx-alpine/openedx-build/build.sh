#!/bin/sh
set -e
set -x

DIR=$(dirname $(readlink -f "$0"))
. "${DIR}/variables.sh"

"${DIR}/build_base_alpine.sh"

"${DIR}/build_wheels.sh"

"${DIR}/build_openedx_image.sh"
