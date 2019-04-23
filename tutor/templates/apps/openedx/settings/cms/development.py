import os
from openedx.core.lib.derived import derive_settings
from cms.envs.devstack import *


execfile(os.path.join(os.path.dirname(__file__), '..', 'tutor_common', 'common.py'), globals())

# Setup correct webpack configuration file for development
WEBPACK_CONFIG_PATH = 'webpack.dev.config.js'

devive_settings(__name__)
