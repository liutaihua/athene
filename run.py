#coding=utf8

import os
import sys
import config
from processor.hades import run as hades_run
from processor.profile_attr import run as profile_attr_run
from processor.quest import run as quest_run


if __name__ == '__main__':
    to_process_type = sys.argv[1]

    if to_process_type not in ['hades', 'profile_attr', 'quest']:
        print """usage: python run.py [category]
            category: hades, profile_attr, quest
                """
    # 处理未完成的
    # 处理流程：
    # 从source里取一个文件，如果是completed里没有的，就放到processing里，进行处理
    # 处理完成后，移动到completed里
    elif to_process_type == 'hades':
        hades_run()

    elif to_process_type == 'profile_attr':
        profile_attr_run()

    elif to_process_type == 'quest':
        quest_run()
