#coding=utf8

import pgutils
import config

def txt2dict(txt):
    return dict([i.split('=') for i in txt.split(' ')])


conn = pgutils.Connection(host='127.0.0.1', database=config.DBNAME, user=config.DBUSER, mincached=5)

if __name__ == '__main__':
    print txt2dict('old_data=100592776 delta_type=0 attr=gold delta_data=6000 userid=1088 source=shortcut_start time=2013-03-14_17:38:03.005773')