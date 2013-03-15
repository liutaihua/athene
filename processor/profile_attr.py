#coding=utf8

import os
import config
import common


def run(filename=None):
    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, filename), config.PROCESSING_GAMELOG_PATH))

    lines = open(file, 'r').readlines()
    for l in lines:
        d = common.txt2dict(l)
        sql = """INSERT INTO attr_log(userid, attr, time, old_data, delta_type, delta_data, source) VALUES (%d, %s, %s, %d, %s, %d, %s)"""
        common.conn.execute(sql,
                    (d['userid'], d['attr'], d['time'], d['old_data'], d['delta_type'], d['delta_data'], d['source']))

    os.system('mv %s %s' % (os.path.join(config.PROCESSING_GAMELOG_PATH, filename), config.COMPLETED_GAMELOG_PATH))