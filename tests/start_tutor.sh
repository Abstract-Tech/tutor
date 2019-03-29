#!/bin/bash
TUTOR_DIR="$( cd "$( dirname "$0" )/.." && pwd )"

set -ex

cd ${TUTOR_DIR}
# For reasons beyond my understanding the following command fails the first time it's
# run, but succeeds the second time around. For this reason we repeat it twice
python setup.py develop || python setup.py develop
tutor config save --silent --set ACTIVATE_NOTES=true --set ACTIVATE_XQUEUE=true
time tutor local pullimages
time tutor local databases
time tutor local start -d
curl -v http://localhost/

echo "We made it to the bottom of the file! Time to celebrate. Go have a pint! (just kidding, keep at it! There's much more work to do)"
