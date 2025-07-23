#!/bin/bash
/usr/local/nginx/sbin/nginx -s stop
sed -i '/exclude=nginx*/d' /etc/yum.conf
