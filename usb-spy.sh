#!/bin/bash

# -*- ENCODING: UTF-8 -*-

CONTROL=0
PLACE="/home/francisco33/COPY"
mkdir  $PLACE
chmod 777 -R $PLACE
while [ $CONTROL=0 ] ; do
	cat /etc/mtab | grep media >> /dev/null
	if [ $? -ne 0 ]; then
		CONTROL=0
	else
		CONTROL=1
		for USBDEV in `df | grep media | awk -F / {'print $5'}` ;
		do
			USBSIZE=`df | grep $USBDEV | awk {'print $2'}`
			if [ $USBSIZE -lt 15664800 ]; then
				USBNAME=`echo $USBDEV | awk -F / {'print $3'}`
				mkdir  $PLACE/$USBNAME
				rsync /media/$USBNAME/ $PLACE/$USBNAME/ -ahv --include-from=/opt/usb-spy.files --exclude=*.* --prune-empty-dirs
				fi
			done
		fi
		sleep 10
	done


exit 0
