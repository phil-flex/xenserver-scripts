#!/bin/sh
for PID in `ls /var/xen/vncterm`; do
        DOMID=$(echo "$(cat /proc/$PID/cmdline 2>/dev/null)"  | sed 's/.*domain\/\([^/]*\).*/\1/g')
        if [ -n "$DOMID" ]; then
                UUID=$(/opt/xensource/bin/list_domains | awk "{ if ( \$1 == \"$DOMID\" ) print \$3 }")
                VMLABEL=$(xe vm-list uuid=$UUID | grep '^[[:space:]]*name-label' | cut -b24-)
                IP=$(netstat -tanpu | grep $PID | awk '{print $4}' | awk -F: '{print $1}')
                PORT=$(netstat -tanpu | grep $PID | awk '{print $4}' | awk -F: '{print $2}')
                echo "$UUID ($VMLABEL) is running on port $IP : $PORT"
        fi
done
 
for PID in `ls /var/xen/qemu`; do
        DOMID=$(echo $(cat /proc/$PID/cmdline)  | sed 's/^.*ifname=tap\([[:digit:]]*\).*/\1/')
        if [ -n "$DOMID" ]; then
                UUID=$(/opt/xensource/bin/list_domains | awk "{ if ( \$1 == \"$DOMID\" ) print \$3 }")
                VMLABEL=$(xe vm-list uuid=$UUID | grep '^[[:space:]]*name-label' | cut -b24-)
                IP=$(netstat -tanpu | grep $PID | awk '{print $4}' | awk -F: '{print $1}')
                PORT=$(netstat -tanp | awk "/$PID/ {print \$4}" | sed 's/.*://');
                echo "$UUID ($VMLABEL) is running on port $IP : $PORT"
        fi
done
