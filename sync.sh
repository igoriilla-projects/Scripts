#!/bin/bash

SOURCE="/path/to/source/files/"
TARGET="/path/where/backup"
LOGS="/var/log/sync"

SENDMAIL=$(ssmtp -s recepient_mail@mail.com < mail.txt)

FREESPACE=$(df -h | grep MOUNT-POINT | awk '{ print $5 }' | cut -c 1)
PANIC="90"

TIMESTAMP=`date "+%Y-%m-%d"`

if [[ "$FEESPACE" -le "$PANIC" ]]; then 
  $SENDMAIL
fi

rsync -va $SOURCE $TARGET --log-file=/$LOGS/$TIMESTAMP.log
