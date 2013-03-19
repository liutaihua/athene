#coding=utf8

import os
import sys
import config
from processor.hades import run as hades_run
from processor.profile_attr import run as profile_attr_run
from processor.quest import run as quest_run


def fetch_file(category):
    assert category in config.CATEGORY, 'can not fetch'
    source_file_list = [i for i in os.listdir(config.SOURCE_GAMELOG_PATH) if i.endswith('.txt') and i.startswith(category)]
    completed_file_list = os.listdir(config.COMPLETED_GAMELOG_PATH)
    processing_file_list = os.listdir(config.PROCESSING_GAMELOG_PATH)
    alternate_files = set(source_file_list) | set(processing_file_list) - set(completed_file_list)
    if len(alternate_files) == 0:
        return None
    else:
        return alternate_files.pop()

if __name__ == '__main__':
    to_process_type = sys.argv[1]
    file_path = fetch_file(to_process_type)
    if not file_path:
        print 'all log files done'
        sys.exit(1)

    if to_process_type not in config.CATEGORY:
        print """usage: python run.py [category]
            category: hades, profile_attr, quest
                """
    # 处理未完成的
    # 处理流程：
    # 从source里取一个文件，如果是completed里没有的，就放到processing里，进行处理
    # 处理完成后，移动到completed里

    elif to_process_type == 'hades':
        hades_run(file_path)

    elif to_process_type == 'profile_attr':
        profile_attr_run(file_path)

    elif to_process_type == 'quest':
        quest_run(file_path)
