#!/bin/sh

#判断地址长度是否在正常范围
if [ $# -lt 7 -o $# -gt 17 ]; then
	echo "Usage: $0 len XX XX XX XX XX XX"
	echo "len=12~32"
	exit 0
fi

dd if=/dev/mtd2 of=/tmp/temp.bin

#address 0x7000  将集中器地址按固定格式写入文件固定位置
echo -ne "\x$1\x$2\x$3\x$4\x$5\x$6\x$7\x$8\x$9\x$10\x$11\x$12\x$13\x$14\x$15\x$16\x$17" | dd of=/tmp/temp.bin conv=notrunc bs=1 count=17 seek=28672

#从文件备份还原参数到工厂分区
mtd write /tmp/temp.bin factory

sleep 2
#read -p "press a key to finish"
#格式化输出地址区的地址信息
#hexdump -v -n 17 -s 0x7000 -e '17/1 "%02X""\n"' /dev/mtd2