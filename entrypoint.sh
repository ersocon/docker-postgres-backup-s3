#! /bin/bash

echo "Starting backup container..."

printenv | grep -v "no_proxy" >> /etc/environment

cron 
tail -f /var/log/cron.log

