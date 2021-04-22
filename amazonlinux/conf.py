#!/usr/bin/env python3

# Author: Ben Langmead <ben.langmead@gmail.com>
# License: MIT

import json
import os
import collections


def parse_profile_json(js, prof):
    region = js['profile'][prof]['region']
    security_group = js['profile'][prof]['security_group']
    aws_prof = js['profile'][prof]['name']
    return prof, aws_prof, region, security_group, \
           [('VAG_PROFILE', aws_prof),
            ('VAG_REGION', region),
            ('VAG_SECURITY_GROUP', security_group)]


def parse_app_json(js):
    app = js['app']['name']
    return app, [('VAG_APPLICATION', app)]


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
