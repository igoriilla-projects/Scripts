#!/bin/bash

SOURCE="/home/igor/files/"
TARGET="/home/igor/backups"
LOGS="/var/log/sync"

SENDMAIL=$(ssmtp -s recepient_mail@mail.com < mail.txt)

FREESPACE=$(df -h | grep /dev/sda2 | awk '{ print $5 }' | cut -c 1)
PANIC="90"

TIMESTAMP=`date "+%Y-%m-%d"`

if [[ "$FEESPACE" -le "$PANIC" ]]; then 
  $SENDMAIL
fi

rsync -va $SOURCE $TARGET --log-file=/$LOGS/$TIMESTAMP.log
