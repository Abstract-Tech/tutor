import os
from lms.envs.production import *


execfile(os.path.join(os.path.dirname(__file__), '..', 'common.py'), globals())

# Fix media files paths
PROFILE_IMAGE_BACKEND['options']['location'] = os.path.join(MEDIA_ROOT, 'profile-images/')

ALLOWED_HOSTS = [
    ENV_TOKENS.get('LMS_BASE'),
    FEATURES['PREVIEW_LMS_BASE'],
    '127.0.0.1', 'localhost', 'preview.localhost',
    '127.0.0.1:8000', 'localhost:8000', 'preview.localhost:8000',
]

# Required to display all courses on start page
SEARCH_SKIP_ENROLLMENT_START_DATE_FILTERING = True

# Allow insecure oauth2 for local interaction with local containers
OAUTH_ENFORCE_SECURE = False

DEFAULT_FROM_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
DEFAULT_FEEDBACK_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
SERVER_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
TECH_SUPPORT_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
CONTACT_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
BUGS_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
UNIVERSITY_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
PRESS_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
PAYMENT_SUPPORT_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
BULK_EMAIL_DEFAULT_FROM_EMAIL = 'no-reply@' + ENV_TOKENS['LMS_BASE']
API_ACCESS_MANAGER_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
API_ACCESS_FROM_EMAIL = ENV_TOKENS['CONTACT_EMAIL']

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
