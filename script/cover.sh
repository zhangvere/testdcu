#/bin/sh


COVERNAME="$1"
COVER=$(cat /tmp/$COVERNAME/value)


if [ "$COVER" != "0" ]; then
	echo -n [$COVERNAME NG]
else
	START=$(date +%s)
	TIME=0
	TIME_OLD=0
	#echo -n Press $COVERNAME KEY
	while true
	do
		TOP1=$(cat /tmp/$COVERNAME/value)
		if [ "$TOP1" == "1" ]; then
			echo -n [$COVERNAME OK]
			break
		fi
		NOW=$(date +%s)
		TIME=$((NOW - START))
		if [ $TIME -gt 9 ]; then
			break
		fi
		if [ $TIME -gt $TIME_OLD ]; then
			#echo -ne "$((10-TIME))\b"
			TIME_OLD=$TIME
		fi
	done
	if [ "$TOP1" == "0" ]; then
		echo -n [$COVERNAME NG]
	fi
fi



