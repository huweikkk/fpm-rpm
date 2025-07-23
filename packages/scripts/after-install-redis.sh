#!/bin/bash
echo 'vm.overcommit_memory = 1'>> /etc/sysctl.conf && sysctl -p
systemctl enable redis &&  systemctl start redis
echo "exclude=redis*" >> /etc/yum.conf
