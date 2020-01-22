#!/bin/sh

DCU_ADDR=`hexdump -v -n 17 -s 0x7000 -e '17/1 "%02x""\n"' /dev/mtd2`

if [ "$DCU_ADDR" = "" ]; then
	exit 0
fi

echo $DCU_ADDR

