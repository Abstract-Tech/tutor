"""Settings shared between production and development cms/lms
"""
import os
# This file is not supposed to be imported, but rather exec'd
# pylint: disable=undefined-variable


# Load module store settings from config files
update_module_store_settings(MODULESTORE, doc_store_settings=DOC_STORE_CONFIG)

# Set uploaded media file path
MEDIA_ROOT = "/openedx/data/uploads/"

# Video settings
VIDEO_IMAGE_SETTINGS['STORAGE_KWARGS']['location'] = MEDIA_ROOT
VIDEO_TRANSCRIPTS_SETTINGS['STORAGE_KWARGS']['location'] = MEDIA_ROOT

# Change syslog-based loggers which don't work inside docker containers
LOGGING['handlers']['local'] = {'class': 'logging.NullHandler'}
LOGGING['handlers']['tracking'] = {
    'level': 'DEBUG',
    'class': 'logging.StreamHandler',
    'formatter': 'standard',
}

LOCALE_PATHS.append('/openedx/locale')

ORA2_FILEUPLOAD_BACKEND = 'filesystem'
ORA2_FILEUPLOAD_ROOT = '/openedx/data/ora2'
ORA2_FILEUPLOAD_CACHE_NAME = 'ora2-storage'

CACHES = {
    "default": {
        "KEY_PREFIX": "default",
        "VERSION": "1",
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    },
    "general": {
        "KEY_PREFIX":  "general",
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    },
    "mongo_metadata_inheritance": {
        "KEY_PREFIX": "mongo_metadata_inheritance",
        "TIMEOUT": 300,
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    },
    "staticfiles": {
        "KEY_PREFIX": "staticfiles_cms",
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    },
    "configuration": {
        "KEY_PREFIX": "configuration",
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    },
    "celery": {
        "KEY_PREFIX":  "celery",
        "TIMEOUT": "7200",
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    },
    "course_structure_cache": {
        "KEY_PREFIX": "course_structure",
        "TIMEOUT": "7200",
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    },
    "ora2-storage": {
        "KEY_PREFIX": ORA2_FILEUPLOAD_CACHE_NAME,
        "TIMEOUT": "7200",
        "BACKEND": "django.core.cache.backends.memcached.MemcachedCache",
        "KEY_FUNCTION": "util.memcache.safe_key",
        "LOCATION": "memcached:11211"
    }
}

# Create folders if necessary
for folder in [LOG_DIR, MEDIA_ROOT, STATIC_ROOT_BASE, ORA2_FILEUPLOAD_ROOT]:
    if not os.path.exists(folder):
        os.makedirs(folder)
