#coding=utf8

__author__ = 'dongyi'

import gevent
import sys
import urllib2
import signal
import time

from gevent import Timeout
from gevent.server import DatagramServer 
from gevent.pool import Pool
from gevent import signal as gsignal

from worker.profile_attr import process_line as profile_line
from worker.quest import process_line as quest_line
from worker.package import process_line as package_line


def debug_log(something):
    print something


def resolv(line):
    """
    :param line: [example]  [category] something
    :return:
    """
    category, content = line.split(' ')
    if category == '[profile_attr]':
        profile_line(line)
    elif category == '[quest]':
        quest_line(line)
    elif category == '[package]':
        package_line(line)


def apps(socket, address):
    # this handler will be run for each incoming connection in a dedicated greenlet
    # using a makefile because we want to use readline()
    gsignal(signal.SIGTERM, exit, server)
    gsignal(signal.SIGQUIT, exit, server)
    gsignal(signal.SIGINT, exit, server)

    fileobj = socket.makefile()
    #timer = Timeout(1).start()

    line = fileobj.readline()
    while line:
        recv = False
        if line.strip() == 'quit':
            break

        result = resolv(line)
        fileobj.write(result)
        recv = True

        fileobj.flush()
        socket.close()
        if recv:
            break
        try:
            line = fileobj.readline()
        except Exception, e:
            debug_log('error...............')
            break


if __name__ == '__main__':
    # to make the server use SSL, pass certfile and keyfile arguments to the constructor
    pool = Pool(500)
    port = int(sys.argv[1])
    server = DatagramServer(('0.0.0.0', port), apps, spawn=pool)
    # to start the server asynchronously, use its start() method;
    # we use blocking serve_forever() here because we have no other jobs
    debug_log('Starting echo server on port %d' % port)
    server.serve_forever()