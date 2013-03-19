#coding=utf8

import os
import config
import common


def run(filename=None):
    """
                'key': 'finish_quest',
                'quest_id': '{{quest_name}}',
                'add_gold': '{{ rewardGold }}',
                'add_exp': '{{ rewardExp }}',
                'add_attr1': '{{ attr1 }}',
                'add_attr2': '{{ attr2 }}',
                'add_attr3': '{{ attr3 }}',
                'add_attr4': '{{ attr4 }}',
                'add_attr5': '{{ attr5 }}',
                'add_attr6': '{{ attr6 }}',
                'add_attr7': '{{ attr7 }}',
                'add_attr8': '{{ attr8 }}',
                'add_attr9': '{{ attr9 }}',
                'add_attr10': '{{ attr10 }}',
                'new_attr1': player.GetAttr(1),
                'new_attr2': player.GetAttr(2),
                'new_attr3': player.GetAttr(3),
                'new_attr4': player.GetAttr(4),
                'new_attr5': player.GetAttr(5),
                'new_attr6': player.GetAttr(6),
                'new_attr7': player.GetAttr(7),
                'new_attr8': player.GetAttr(8),
                'new_attr9': player.GetAttr(9),
                'new_attr10': player.GetAttr(10),
                'new_gold': player.GetGold(),
                'new_exp': player.GetExp(),
                'reward_item': '{{ rewardItem }}',
                'userid': player.GetUserId(),

    """
    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, filename), config.PROCESSING_GAMELOG_PATH))

    lines = open(os.path.join(config.PROCESSING_GAMELOG_PATH, filename), 'r').readlines()
    for l in lines:
        d = common.txt2dict(l)
        sql = """INSERT INTO quest(userid, time, key, quest_id, add_exp, add_gold, \
        add_attr1, add_attr2, add_attr3, add_attr4, add_attr5, add_attr6, add_attr7,\
        add_attr8, add_attr9, add_attr10, new_exp, new_gold, \
        new_attr1, new_attr2, new_attr3, new_attr4, new_attr5, new_attr6, new_attr7, \
        new_attr8, new_attr9, new_attr10, new_gold, new_exp, reward_item) \
        VALUES (%s, '%s', '%s', '%s', %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,\
         %s, %s, '%s')""" % (
            d.get('userid', 0), d.get('time', ''), d.get('key', 0), d.get('quest_id', ''), d.get('add_exp', 0),
            d.get('add_gold', 0),
            d.get('add_attr1', 0), d.get('add_attr2', ''), d.get('add_attr3', 0), d.get('add_attr4', ''),
            d.get('add_attr5', 0), d.get('add_attr6', ''), d.get('add_attr7', 0), d.get('add_attr8', ''),
            d.get('add_attr9', 0), d.get('add_attr10', ''), d.get('new_attr1', 0), d.get('new_attr2', ''),
            d.get('new_attr3', 0), d.get('new_attr4', ''), d.get('new_attr5', 0), d.get('new_attr6', ''),
            d.get('new_attr7', 0), d.get('new_attr8', ''), d.get('new_attr9', 0), d.get('new_attr10', ''),
            d.get('new_gold', 0), d.get('new_exp', 0), d.get('reward_item', ''))
        try:
            #print sql
            common.conn.execute(sql)
        except Exception, e:
            print 'error', e

    os.system('mv %s %s' % (os.path.join(config.PROCESSING_GAMELOG_PATH, filename), config.COMPLETED_GAMELOG_PATH))
