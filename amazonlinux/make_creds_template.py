#!/usr/bin/env python3

import os


def make_creds_file(prof, creds_file):
    credential_fn = os.path.expanduser(creds_file)
    if not os.path.exists(credential_fn):
        raise RuntimeError('No such credentials file "%s"' % credential_fn)
    with open('.creds.tmp', 'wt') as ofh:
        ofh.write('[default]\n')
        with open(credential_fn, 'rt') as fh:
            while True:
                ln = fh.readline()
                if len(ln) == 0:
                    break
                ln = ln.rstrip()
                if ln == ('[%s]' % prof):
                    def _parse(key_to_parse):
                        tokens = fh.readline().rstrip().split('=')
                        ky, vl = tokens[0].strip(), tokens[1].strip()
                        assert ky == key_to_parse
                        ofh.write('%s = %s\n' % (key_to_parse, vl))
                    _parse('aws_access_key_id')
                    _parse('aws_secret_access_key')
