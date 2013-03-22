#coding=utf8

import os
import config
import datetime
from worker.hades import run as hades_run
from worker.profile_attr import run as profile_attr_run
from worker.quest import run as quest_run


def fetch_file():
    now = datetime.datetime.now()
    current_now = '_%d-%d-%d_%d' % (now.year, now.month, now.day, now.hour)
    source_file_list = [i for i in os.listdir(config.SOURCE_GAMELOG_PATH) if i.endswith('.txt') and current_now not in i and 'online' not in i]
    completed_file_list = os.listdir(config.COMPLETED_GAMELOG_PATH)
    processing_file_list = os.listdir(config.PROCESSING_GAMELOG_PATH)
    
    alternate_files = (set(source_file_list) | set(processing_file_list)) - set(completed_file_list)
    if len(alternate_files) == 0:
        return None
    else:
        return alternate_files.pop()

if __name__ == '__main__':

    while True:
        file_path = fetch_file()
        if file_path == None:
            break
        # 处理未完成的
        # 处理流程：
        # 从source里取一个文件，如果是completed里没有的，就放到processing里，进行处理
        # 处理完成后，移动到completed里
        now = datetime.datetime.now()
        current_now = '_%d-%d-%d_%d' % (now.year, now.month, now.day, now.hour)
        #print 'current_now', current_now
        if current_now in file_path:
            continue
        print 'process file:', file_path
        if 'hades' in file_path:
            hades_run(file_path)
        elif 'profile_attr' in file_path:
            profile_attr_run(file_path)
        elif 'quest' in file_path:
            quest_run(file_path)
