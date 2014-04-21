#coding=utf8

import sys
sys.path.append('../')

import config
import dbutils
import MySQLdb

def txt2dict(txt):
    txt = txt.replace('[profile_attr] ', '').replace('[quest] ', '').replace('[hades_req] ', '')
    try:
        return dict([i.split('=') for i in txt.split(' ') if '=' in i])
    except:
        print '33333', txt

#conn = dbutils.Connection(host='localhost', database=config.DBNAME, user=config.DBUSER, password=config.PASSWORD)
connection = MySQLdb.Connection(host='localhost', db=config.DBNAME, user=config.DBUSER, passwd=config.PASSWORD)

connection.autocommit(True)
conn = connection.cursor()

if __name__ == '__main__':
    print txt2dict('old_data=100592776 delta_type=0 attr=gold delta_data=6000 userid=1088 source=shortcut_start time=2013-03-14_17:38:03.005773')
