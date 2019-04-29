#!/bin/bash

for dirname in $@; do
    if ([ -f "$dirname" ] || [ -d "$dirname" ]); then
        echo Pushing "$dirname"
        sudo chown $(id -u) -R "$dirname"
        REMOTE_DIR=${TEST_RESULTS_BASE_DIR}/${BUILD_REPOSITORY_PROVIDER}/${BUILD_REPOSITORY_ID}/${BUILD_BUILDID}
        REMOTE=${TEST_RESULTS_USER}@${TEST_RESULTS_HOST}
        ssh ${REMOTE} mkdir -p ${REMOTE_DIR}
        scp -r "$dirname" ${REMOTE}:${REMOTE_DIR}
    else
        echo "$dirname" not found. Skipping
    fi
done