#!/bin/sh

dd if=/dev/mtd2 of=/tmp/temp.bin

if [ -z $6 ]; then
	echo "Usage: macaddr XX XX XX XX XX XX"
	exit 0
fi

#address 0x0004 Ethernet 将MAC地址按固定格式写入文件固定位置
echo -ne "\x$1\x$2\x$3\x$4\x$5\x$6" | dd of=/tmp/temp.bin conv=notrunc bs=1 count=6 seek=4
#address 0x8004 WiFi
echo -ne "\x$1\x$2\x$3\x$4\x$5\x$6" | dd of=/tmp/temp.bin conv=notrunc bs=1 count=6 seek=32772

#从文件中备份恢复参数到工厂分区
mtd write /tmp/temp.bin factory

#sleep 2
#读取到按键输入后重启
#read -p "press a key to reboot"
#reboot

