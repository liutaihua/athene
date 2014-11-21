import commands
import time
import os


while True:
    res = commands.getoutput('ps -ef|grep go_server|grep -v grep|wc -l')
    print res, int(res)
    if int(res) < 1:
        print 'start again go_server'
        os.system('nohup ./go_server 2>&1 &')
    print 'sleep 60'
    time.sleep(60)
