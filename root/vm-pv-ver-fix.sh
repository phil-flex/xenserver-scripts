#!/bin/sh

major=5
minor=6
micro=199
var1=$1

#for d in `xl list|awk '{print $2}'|sed 's/ID//g'`; do
for d in `xe vm-list params=dom-id power-state=running is-control-domain=false --minimal|sed 's/,/ /g'`; do
	if [ $d -gt 0 ]; then
		xenstore-exists /local/domain/$d/attr/PVAddons
		if [ $? -eq 0 ]; then
			c=`xenstore-read /local/domain/$d/attr/PVAddons/MajorVersion`
			if [ ! $c -eq $major ]; then
				xenstore-write /local/domain/$d/attr/PVAddons/MajorVersion $major
				xenstore-write /local/domain/$d/attr/PVAddons/MinorVersion $minor
       	        		xenstore-write /local/domain/$d/attr/PVAddons/MicroVersion $micro
#                		xenstore-write /local/domain/$d/data/updated 1
			fi
		fi
	fi
done
