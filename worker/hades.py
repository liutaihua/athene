#coding=utf8

import os
import config
import common


def process_line(l):
    d = common.txt2dict(l)
    serverid = int(d.get('userid', 0)) % 65536
    action =  d.get('uri', '').split('/')[-1]
    if action not in ['go_to_boss', 'jump_to_team_instance', 'goto_challenge_instance', 'go_to_battleland', 'go_to_jjc', 'go_to_singlejjc',
                'enhance', 'combine', 'mosaic', 'generate_element', 'update_miracle', 'advance_update_miracle', 'update_farm', 'click', 'pray',
		'harvest', 'take_care','exchange', 'jump_to_quest_location',
            ]:
        return
    behavior = d.get('behavior')
    if not behavior:
        behavior = action
    sql = """INSERT INTO behavior_log (userid, action, timestamp, time_tail, serverid) \
            VALUES (%s, '%s', '%s', '%s', %s)""" % (
            d.get('userid', 0), behavior, d.get('time', '').split('.')[0], d.get('time', '').split('.')[-1], serverid)
    try:
        print sql
        common.conn.execute(sql)
    except Exception, e:
        #pass
        print 'error', e, d.get('time')


def run(filename=None):
    #  example: xx=xx xx=xx

    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, filename), config.PROCESSING_GAMELOG_PATH))

    lines = open(os.path.join(config.PROCESSING_GAMELOG_PATH, filename), 'r').readlines()
    for l in lines:
        continue
        d = common.txt2dict(l)
        conn = common.conn

    os.system('mv %s %s' % (os.path.join(config.PROCESSING_GAMELOG_PATH, filename), config.COMPLETED_GAMELOG_PATH))
