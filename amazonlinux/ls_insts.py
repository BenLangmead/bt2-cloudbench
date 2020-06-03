#!/usr/bin/env python3

# Author: Ben Langmead <ben.langmead@gmail.com>
# License: MIT

"""ls_insts

Usage:
  ls_insts <profile> [options]

Options:
  -h, --help                 Show this screen.
  --version                  Show version.
"""

import os
import json
import collections
from docopt import docopt


def parse_profile_json(js, prof):
    region = js['profile'][prof]['region']
    security_group = js['profile'][prof]['security_group']
    aws_prof = js['profile'][prof]['name']
    return prof, aws_prof, region, security_group, \
           [('VAGRANT_AWS_PROFILE', aws_prof),
            ('VAGRANT_AWS_REGION', region),
            ('VAGRANT_AWS_SECURITY_GROUP', security_group)]


def parse_app_json(js):
    app = js['app']['name']
    return app, [('VAGRANT_APPLICATION', app)]


def dict_merge(dct, merge_dct):
    for k, v in merge_dct.items():
        if (k in dct and isinstance(dct[k], dict)
                and isinstance(merge_dct[k], collections.Mapping)):
            dict_merge(dct[k], merge_dct[k])
        else:
            dct[k] = merge_dct[k]


def load_json(json_fn, json_dict, needs_key=None):
    if not os.path.exists(json_fn):
        raise RuntimeError('Could not find JSON file "%s"' % json_fn)
    js = json.loads(open(json_fn, 'rt').read())
    if needs_key is not None:
        if needs_key not in js:
            raise RuntimeError('JSON "%s" did not contain "%s" key at top level' % (json_fn, needs_key))
    dict_merge(json_dict, js)


def go():
    args = docopt(__doc__)
    js = {}
    app_json, profile_json = 'app.json', 'profile.json'
    load_json(profile_json, js, needs_key='profile')
    load_json(app_json, js, needs_key='app')
    prof, aws_prof, region, security_group, profile_param = parse_profile_json(js, args['<profile>'])
    app, app_param = parse_app_json(js)
    print('App: ' + app)
    print('Region: ' + region)
    print('AWS profile: ' + aws_prof)
    cmd = 'aws --profile %s ec2 describe-instances --filters "Name=tag:Application,Values=%s" "Name=instance-state-name,Values=running"' % (aws_prof, app)
    os.system(cmd)


if __name__ == '__main__':
    go()
