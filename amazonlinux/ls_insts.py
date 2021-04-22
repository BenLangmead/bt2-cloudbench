#!/usr/bin/env python3

# Author: Ben Langmead <ben.langmead@gmail.com>
# License: MIT

"""ls_insts

Usage:
  ls_insts [options]

Options:
  --profile <string>    Use specified profile.  Default: default_profile from profile.json.
  -h, --help            Show this screen.
  --version             Show version.
"""

import os
from conf import load_json, parse_app_json, parse_profile_json
from docopt import docopt


def go():
    args = docopt(__doc__)
    js = {}
    app_json, profile_json = 'app.json', 'profile.json'
    load_json(profile_json, js, needs_key='profile')
    load_json(app_json, js, needs_key='app')
    if args['--profile'] is not None:
        prof = args['--profile']
    elif 'default_profile' in js:
        prof = js['default_profile']
    else:
        raise RuntimeError('neither default_profile nor --profile given')
    prof, aws_prof, region, security_group, profile_param = parse_profile_json(js, prof)
    app, app_param = parse_app_json(js)
    print('App: ' + app)
    print('Region: ' + region)
    print('AWS profile: ' + aws_prof)
    cmd = 'aws --profile %s ec2 describe-instances --filters "Name=tag:Application,Values=%s" "Name=instance-state-name,Values=running"' % (aws_prof, app)
    os.system(cmd)


if __name__ == '__main__':
    go()
