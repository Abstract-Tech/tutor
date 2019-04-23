"""Common configuration for lms/production.py and cms/production.py
"""

ALLOWED_HOSTS = [
    ENV_TOKENS.get('LMS_BASE'),
    FEATURES['PREVIEW_LMS_BASE'],
    '127.0.0.1', 'localhost', 'preview.localhost',
    '127.0.0.1:8000', 'localhost:8000', 'preview.localhost:8000',
]

DEFAULT_FROM_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
DEFAULT_FEEDBACK_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
SERVER_EMAIL = ENV_TOKENS['CONTACT_EMAIL']
