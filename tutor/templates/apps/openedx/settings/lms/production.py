import os
from openedx.core.lib.derived import derive_settings
from lms.envs.production import *


execfile(os.path.join(os.path.dirname(__file__), 'common.py'), globals())
execfile(os.path.join(os.path.dirname(__file__), '..', 'tutor_common', 'common_production.py'), globals())
execfile(os.path.join(os.path.dirname(__file__), '..', 'tutor_common', 'common.py'), globals())


# Required to display all courses on start page
SEARCH_SKIP_ENROLLMENT_START_DATE_FILTERING = True

# Allow insecure oauth2 for local interaction with local containers
OAUTH_ENFORCE_SECURE = False

TECH_SUPPORT_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
CONTACT_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
BUGS_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
UNIVERSITY_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
PRESS_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
PAYMENT_SUPPORT_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
BULK_EMAIL_DEFAULT_FROM_EMAIL = 'no-reply@' + ENV_TOKENS['LMS_BASE']
API_ACCESS_MANAGER_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
API_ACCESS_FROM_EMAIL = ENV_TOKENS['CONTACT_EMAIL']

devive_settings(__name__)
