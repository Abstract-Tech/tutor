import os
from cms.envs.production import *


execfile(os.path.join(os.path.dirname(__file__), '..', 'common.py'), globals())
execfile(os.path.join(os.path.dirname(__file__), '..', 'common_production.py'), globals())
