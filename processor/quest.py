#coding=utf8

import os
import config


def run(file=None):

    os.system('cp %s %s' % (os.path.join(config.SOURCE_GAMELOG_PATH, file), config.PROCESSING_GAMELOG_PATH))

    lines = open(file, 'r').readlines()
    for l in lines:
        print l

    os.system('mv %s %s' % (os.path.join(config.PROCESSING_GAMELOG_PATH, file), config.COMPLETED_GAMELOG_PATH))