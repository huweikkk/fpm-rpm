#!/bin/bash
groupadd www
useradd -g www www -s /bin/false
systemctl daemon-reload
systemctl enable nginx
echo "exclude=nginx*" >> /etc/yum.conf
