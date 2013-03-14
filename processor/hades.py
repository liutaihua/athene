#coding=utf8

import os
import config
import common


def run(file=None):
    #  example: xx=xx xx=xx
    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, file), config.PROCESSING_GAMELOG_PATH))

    lines = open(file, 'r').readlines()
    for l in lines:
        d = common.txt2dict(l)
        conn = common.conn

    os.system('mv %s %s' % (os.path.join(config.PROCESSING_GAMELOG_PATH, file), config.COMPLETED_GAMELOG_PATH))