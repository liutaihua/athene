#coding=utf8

import os
import config
import common


def run(filename=None):
    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, filename), config.PROCESSING_GAMELOG_PATH))

    lines = open(os.path.join(config.PROCESSING_GAMELOG_PATH, filename), 'r').readlines()
    for l in lines:
        d = common.txt2dict(l)
        sql = """INSERT INTO attr_log(userid, attr, time, old_data, delta_type, delta_data, source) VALUES (%s, '%s', '%s', %s, '%s', %s, '%s')""" % (
            d.get('userid', 0), d.get('attr', 0), d.get('time', ''), d.get('old_data', 0), d.get('delta_type', 0),
            d.get('delta_data', 0), d.get('source', ''))
        try:
            #print sql
            common.conn.execute(sql)
        except:
            pass
            #print 'error', e

    os.system('mv %s %s' % (os.path.join(config.PROCESSING_GAMELOG_PATH, filename), config.COMPLETED_GAMELOG_PATH))
