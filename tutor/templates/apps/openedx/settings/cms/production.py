import os
from cms.envs.production import *


execfile(os.path.join(os.path.dirname(__file__), '..', 'tutor_common', 'common_production.py'), globals())
execfile(os.path.join(os.path.dirname(__file__), '..', 'tutor_common', 'common.py'), globals())
