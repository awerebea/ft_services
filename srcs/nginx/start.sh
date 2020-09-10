#! /bin/sh

# start the SSH deamon and nginx
/usr/sbin/sshd
nginx -g "daemon off;"
