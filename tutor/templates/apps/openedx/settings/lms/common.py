"""File with configurations for lms common between production and development.
"""
# Fix media files paths
PROFILE_IMAGE_BACKEND['options']['location'] = os.path.join(MEDIA_ROOT, 'profile-images/')

GRADES_DOWNLOAD = {
    'STORAGE_TYPE': '',
    'STORAGE_KWARGS': {
        'base_url': "/media/grades/",
        'location': os.path.join(MEDIA_ROOT, 'grades'),
    }
}
