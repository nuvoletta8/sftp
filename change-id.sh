#!/bin/bash

myid=`id -u`

sed "s/1000:/${myid}:/g" /etc/passwd > /tmp/idocp
cat /tmp/idocp > /etc/passwd

/usr/sbin/sshd -e -D -f /etc/ssh/sshd_config
