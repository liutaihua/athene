#coding=utf8

__author__ = 'dongyi'
import common
import os

sql1 = 'delete from attr_log'
sql2 = 'delete from quest_log'

common.conn.execute(sql1)
common.conn.execute(sql2)

os.system('rm completed/*.txt')