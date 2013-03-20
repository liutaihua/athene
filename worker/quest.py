#coding=utf8

import os
import config
import common


def run(filename=None):

    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, filename), config.PROCESSING_GAMELOG_PATH))

    lines = open(os.path.join(config.PROCESSING_GAMELOG_PATH, filename), "r").readlines()
    for l in lines:
        d = common.txt2dict(l)
        sql = """INSERT INTO quest_log (`userid`,`timestamp`,`key`,`quest_id`,`add_exp`,`add_gold`,`add_attr1`,`add_attr2`,`add_attr3`,`add_attr4`,`add_attr5`,`add_attr6`,`add_attr7`,`add_attr8`,`add_attr9`,`add_attr10`,`new_attr1`,`new_attr2`,`new_attr3`,`new_attr4`,`new_attr5`,`new_attr6`,`new_attr7`,`new_attr8`,`new_attr9`,`new_attr10`,`new_gold`,`new_exp`,`reward_item`, `time_tail`) VALUES (%s,'%s','%s','%s',%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,'%s', %s)""" % (
            d.get("userid", 0), (d.get("time", " ").split('.')[0]).replace('_', ' '), d.get("key", 0), d.get("quest_id", " "),
            d.get("add_exp", 0), d.get("add_gold", 0),
            d.get("add_attr1", 0), d.get("add_attr2", 0), d.get("add_attr3", 0), d.get("add_attr4", 0),
            d.get("add_attr5", 0), d.get("add_attr6", 0), d.get("add_attr7", 0), d.get("add_attr8", 0),
            d.get("add_attr9", 0), d.get("add_attr10", 0), d.get("new_attr1", 0), d.get("new_attr2", 0),
            d.get("new_attr3", 0), d.get("new_attr4", 0), d.get("new_attr5", 0), d.get("new_attr6", 0),
            d.get("new_attr7", 0), d.get("new_attr8", 0), d.get("new_attr9", 0), d.get("new_attr10", 0),
            d.get("new_gold", 0), d.get("new_exp", 0), d.get("reward_item", " "), d.get('time', '').split('.')[-1])
        try:
            common.conn.execute(sql)
        except Exception, e:
            print "!!error", e

        for field in ['attr1', 'attr2', 'attr3', 'attr4', 'attr5', 'attr6', 'attr7', 'attr8', 'attr9', 'attr10',
                      'exp', 'gold']:
            if int(d.get('add_%s' % field, 0)) != 0:
                delta_data = int(d.get('add_%s' % field, 0))
                old_data = int(d.get('new_%s' % field, 0)) - int(d.get('add_%s' % field, 0))
                time = (d.get('time', ' ').split('.')[0]).replace('_', ' ')
                delta_type = 1
                source = '%s %s' % (d.get('key', ''), d.get('quest_id', ''))
                sql = """INSERT INTO attr_log(userid, attr, timestamp, old_data, delta_type, delta_data, source, time_tail) VALUES (%s, '%s', '%s', %s, '%s', %s, '%s', %s)""" % (
                    d.get("userid", 0), field.replace('attr', 'attr_'), time, old_data, delta_type, delta_data, source, d.get('time', '').split('.')[-1]
                )
                try:
                    #print sql
                    common.conn.execute(sql)
                except Exception, e:
                    print "!!!error", e

    os.system("mv %s %s" % (os.path.join(config.PROCESSING_GAMELOG_PATH, filename), config.COMPLETED_GAMELOG_PATH))
