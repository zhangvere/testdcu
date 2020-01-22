#/bin/sh

KEYNAME="$1"
/etc/init.d/log restart


for i in $(seq 0 15)
do
	KEY_LOG=$(logread -e "$KEYNAME pressed for [0-9] seconds")

	if [ "$KEY_LOG" != "" ]; then
		break
	fi
	sleep 1
done

if [ "$KEY_LOG" == "" ]; then
	echo -n [KEY-$KEYNAME NG]
else
	echo -n [KEY-$KEYNAME OK]
fi


