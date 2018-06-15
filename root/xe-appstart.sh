#!/bin/sh
APP_UUID=`xe appliance-list params=uuid name-label=autostart|awk '{print $5}'`
/opt/xensource/bin/xe appliance-start uuid=$APP_UUID

