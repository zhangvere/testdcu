#!/bin/sh

USBNAME="$1"

read_write_test()
{
	FILE_NAME=$(date +%s%N)

	for i in $(seq 1 1000)
	do
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
		echo "1234567890abcdefghijklmnopqrstuvwxyz" >> /tmp/$1/$FILE_NAME
	done
	sleep 1
	SUM=$(md5sum /tmp/$1/$FILE_NAME | awk '{print $1}')
	
	if [ "$SUM" == "31907601e5c666658633258f6be41d22" ]; then
		echo OK
	else
		echo NG
	fi

	rm -f /tmp/$1/$FILE_NAME
}

MOUNT_INFO=$(block info)
USB_INFO=$(echo $MOUNT_INFO | grep "\"/tmp/$USBNAME\"")

if [ $USBNAME ==  "usb1" ]; then
	if [ -d "/sys/devices/platform/1e1c0000.xhci/usb2/2-1/2-1:1.0" ]; then
		USBVER="3.0"
	else
		USBVER="2.0"
	fi
else
	USBVER="2.0"
fi


if [ "$USB_INFO" != "" ]; then
	STATUS=$(read_write_test $USBNAME)
	echo -n [$USBNAME $USBVER $STATUS]
else
	echo -n [$USBNAME NG]
fi





