import os
from lms.envs.devstack import *
from .common import *


# Load module store settings from config files
update_module_store_settings(MODULESTORE, doc_store_settings=DOC_STORE_CONFIG)

ORA2_FILEUPLOAD_BACKEND = 'filesystem'
ORA2_FILEUPLOAD_ROOT = '/openedx/data/ora2'
ORA2_FILEUPLOAD_CACHE_NAME = 'ora2-storage'

GRADES_DOWNLOAD = {
    'STORAGE_TYPE': '',
    'STORAGE_KWARGS': {
        'base_url': "/media/grades/",
        'location': os.path.join(MEDIA_ROOT, 'grades'),
    }
}

LOCALE_PATHS.append('/openedx/locale')

# Setup correct webpack configuration file for development
WEBPACK_CONFIG_PATH = 'webpack.dev.config.js'

# Create folders if necessary
for folder in [LOG_DIR, MEDIA_ROOT, STATIC_ROOT_BASE, ORA2_FILEUPLOAD_ROOT]:
    if not os.path.exists(folder):
        os.makedirs(folder)
