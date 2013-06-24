#coding=utf8

import os
import config
import common


def run(filename=None):
    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, filename), config.PROCESSING_GAMELOG_PATH))

    lines = open(os.path.join(config.PROCESSING_GAMELOG_PATH, filename), 'r').readlines()
    for l in lines:
        d = common.txt2dict(l)
        sql = """INSERT INTO package (userid, type, itemid, itemtype, count, source, timestamp) \
            VALUES (%s, %s, %s, '%s', %s, '%s', '%s')""" % (
            d.get('userid', 0), {'get':1, 'consume':0}[d.get('type', 'get')], d.get('itemid', 0), d.get('itemtype', ''), d.get('count', 1),
            d.get('source', ''), d.get('time', '').replace('_', ' '))
        try:
            #print sql
            common.conn.execute(sql)
        except Exception, e:
            #pass
            print sql
            print 'error', e, d.get('time')

    os.system('mv %s %s' % (os.path.join(config.PROCESSING_GAMELOG_PATH, filename), config.COMPLETED_GAMELOG_PATH))
