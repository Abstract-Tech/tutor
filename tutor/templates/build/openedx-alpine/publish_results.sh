#!/bin/bash
REMOTE_DIR=${TEST_RESULTS_BASE_DIR}/${BUILD_REPOSITORY_PROVIDER}/${BUILD_REPOSITORY_ID}/${BUILD_BUILDID}
REMOTE_URL=https://${TEST_RESULTS_HOST}/${BUILD_REPOSITORY_PROVIDER}/${BUILD_REPOSITORY_ID}/${BUILD_BUILDID}
echo Pushing results to ${REMOTE_URL}
for dirname in $@; do
    if ([ -f "$dirname" ] || [ -d "$dirname" ]); then
        echo Pushing "$dirname"
        sudo chown $(id -u) -R "$dirname"
        REMOTE=${TEST_RESULTS_USER}@${TEST_RESULTS_HOST}
        ssh ${REMOTE} mkdir -p ${REMOTE_DIR}
        scp -r "$dirname" ${REMOTE}:${REMOTE_DIR}
        echo copied ${REMOTE_URL}/$dirname
    else
        echo "$dirname" not found. Skipping
    fi
done