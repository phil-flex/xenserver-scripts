#!/bin/sh

threshold=52
host=`/bin/hostname`

for d in `ls /dev/sd[a-z]`
do

chk1=`/usr/sbin/smartctl --all ${d}|grep ^194|/bin/awk '{print $10}'`
if [ $chk1 -gt $threshold ]; then

sleep 30
chk2=`/usr/sbin/smartctl --all ${d}|grep ^194|/bin/awk '{print $10}'`

if [ $chk1 -gt $threshold ]; then

# email subject
SUBJECT="SmartCtl Checking Warning!"
# Email To ?
EMAIL="my@email.address"
# Email text/message
EMAILMESSAGE="/tmp/emailmessage.txt"
echo "Due to disk ${d} temperature too high (>${threshold}C), ${host} will be power off in 2 mins."> $EMAILMESSAGE
# send an email using /bin/mail
/bin/mail -s "$SUBJECT" "$EMAIL" < $EMAILMESSAGE
sleep 120
/sbin/poweroff;
break;
fi
fi
done

