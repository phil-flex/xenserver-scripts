#!/bin/sh
today=`date +"%Y%m%d_%H%M"`
for vm in `xe vm-list is-control-domain=false params=uuid --minimal|sed 's/,/\ /g'|sed 's/<not\ in\ database>//g'`
do
	vmname=`xe vm-list uuid=$vm params=name-label is-control-domain=false --minimal|sed 's/<not\ in\ database>//g'`
	vdisks=`xe vbd-list vm-uuid=$vm params=vdi-uuid --minimal|sed 's/,/\ /g'|sed 's/<not\ in\ database>//g'`
	for vdi in `xe vbd-list type=Disk vm-uuid=$vm params=vdi-uuid --minimal|sed 's/,/\ /g'|sed 's/<not\ in\ database>//g'`
	do
		udev=`xe vbd-list vm-uuid=$vm vdi-uuid=$vdi params=userdevice --minimal`
		xe vdi-param-set uuid=$vdi name-label="${vmname} [${udev}] (${today})"
	done
done
