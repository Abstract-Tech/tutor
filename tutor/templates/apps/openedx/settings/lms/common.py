"""File with configurations for lms common between production and development.
"""
# Fix media files paths
PROFILE_IMAGE_BACKEND['options']['location'] = os.path.join(MEDIA_ROOT, 'profile-images/')

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
