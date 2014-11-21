import os
import hashlib
import datetime
import time
import urllib
import json


def get_all_platformid_ename_dict():
    now = int(time.time())
    sign = hashlib.md5('time=%s&getChannelsInfo' % str(now)).hexdigest()
    url = 'http://s0.sy.xd.com/xd/channels'
    args = {'time': now, 'sign': sign}
    args_str = urllib.urlencode(args, True)
    r = urllib.urlopen(url+'?'+args_str)
    res = json.loads(r.read())
    return {int(i[0]):i[1] for i in res}

all_platform = get_all_platformid_ename_dict()

#while True:
#    if datetime.datetime.now() < datetime.datetime(2014,10,12,2):
#        print 'sleep 60'
#        time.sleep(60)
#        continue
for k, v in all_platform.items():
    if str(v) in ['xunlei', 'yygame', '178']:
        continue
    print '''mysql -uroot -proot %s_athene -e "ALTER TABLE attr_log  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, DROP PRIMARY KEY, ADD PRIMARY KEY(id), add UNIQUE INDEX (userid,timestamp,attr,time_tail), DROP INDEX index_name_time;"''' % v

    os.system('''mysql -uroot -proot %s_athene -e "ALTER TABLE attr_log  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, DROP PRIMARY KEY, ADD PRIMARY KEY(id), add UNIQUE INDEX (userid,timestamp,attr,time_tail), DROP INDEX index_name_time;"''' % v)
    print 'done', v+'_athene', 'attr_log'
    print '''mysql -uroot -proot %s_athene -e "ALTER TABLE package  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, DROP PRIMARY KEY, ADD PRIMARY KEY(id), add UNIQUE INDEX (userid,timestamp,time_tail), ADD INDEX index_timestamp (timestamp), ADD INDEX index_userid (userid);"''' % v
    os.system('''mysql -uroot -proot %s_athene -e "ALTER TABLE package  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, DROP PRIMARY KEY, ADD PRIMARY KEY(id), add UNIQUE INDEX (userid,timestamp,time_tail), ADD INDEX index_timestamp (timestamp), ADD INDEX index_userid (userid);"''' % v)
    print 'done', v+'_athene', 'package'
    print '''mysql -uroot -proot %s_athene -e "ALTER TABLE behavior_log  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY(id);"''' % v
    os.system('''mysql -uroot -proot %s_athene -e "ALTER TABLE behavior_log  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY(id);"''' % v)
    print 'done', v+'_athene', 'behavior_log'
    print '''mysql -uroot -proot %s_athene -e "ALTER TABLE token_and_coupons_log  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, DROP PRIMARY KEY, ADD PRIMARY KEY(id), add UNIQUE INDEX (userid,timestamp,attr,time_tail), DROP INDEX index_name_time;"''' % v
    os.system('''mysql -uroot -proot %s_athene -e "ALTER TABLE token_and_coupons_log  ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT FIRST, DROP PRIMARY KEY, ADD PRIMARY KEY(id), add UNIQUE INDEX (userid,timestamp,attr,time_tail), DROP INDEX index_name_time;"''' % v)
    print 'done', v+'_athene', 'token_and_coupons_log'
