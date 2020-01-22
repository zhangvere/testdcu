#!/bin/sh

SERVER="$1"
ETH_NAME="$2"
ETH_PORT="$3"

rm -f /tmp/${ETH_NAME}.file
rm -f /tmp/${ETH_NAME}${ETH_NAME}.file
TIME=$(date +%s)

for i in $(seq 1 1000)
do
	
	echo $TIME >> /tmp/${ETH_NAME}.file
	echo "0987654321qwertyuioplkjhgfdsazxcvbnm0987654321qwertyuioplkjhgfdsazxcvbnm" >> /tmp/${ETH_NAME}.file
	echo "0987654321qwertyuioplkjhgfdsazxcvbnm0987654321qwertyuioplkjhgfdsazxcvbnm" >> /tmp/${ETH_NAME}.file
	echo "0987654321qwertyuioplkjhgfdsazxcvbnm0987654321qwertyuioplkjhgfdsazxcvbnm" >> /tmp/${ETH_NAME}.file
	echo "0987654321qwertyuioplkjhgfdsazxcvbnm0987654321qwertyuioplkjhgfdsazxcvbnm" >> /tmp/${ETH_NAME}.file
	echo "0987654321qwertyuioplkjhgfdsazxcvbnm0987654321qwertyuioplkjhgfdsazxcvbnm" >> /tmp/${ETH_NAME}.file
done

sleep 1
SUM1=$(md5sum /tmp/${ETH_NAME}.file | awk '{print $1}')
tftp -l /tmp/${ETH_NAME}.file -r $TIME -p $SERVER 2> /dev/null
sleep 1
tftp -l /tmp/${ETH_NAME}${2}.file -r $TIME -g $SERVER 2> /dev/null
sleep 1
SUM2=$(md5sum /tmp/${ETH_NAME}${2}.file | awk '{print $1}')

SPEED=$(swconfig dev switch0 port $ETH_PORT show | grep "speed:")

SPEED1000=$(echo $SPEED | grep "speed:1000baseT")
SPEED100=$(echo $SPEED | grep "speed:100baseT")

if [ "$SPEED1000" == "" -a "$SPEED100" != "" ]; then
	SPEED="100Mbps"
elif [ "$SPEED1000" != "" -a "$SPEED100" == "" ]; then
	SPEED="1Gbps"
else
	SPEED="UNKOWN"
fi

if [ "$SUM1" == "$SUM2" ]; then
	echo -n [$ETH_NAME $SPEED OK]
else
	echo -n [$ETH_NAME NG]
fi

