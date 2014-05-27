# The MIT License (MIT)

# Copyright (c) 2014 glframebuffer

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
#subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# This script allows Beaglebone white or black to shutdoen after 5 Minutes

#!/bin/bash
NEW_NUM=false
PWR_NUM=0
PWR_COUNT=0
OFF_COUNT=0
PWR_OFF=false
MINUTES=5

PWR_NUM=$(cat /proc/interrupts | grep 23: | awk '{printf("%d", $2)}')
let PWR_COUNT=$PWR_NUM
echo $PWR_COUNT
while [ "$NEW_NUM" != "TRUE" ]
do
         PWR_NUM=$(cat /proc/interrupts | grep 23: | awk '{printf("%d", $2)}')
        echo "POWER:"$(($PWR_NUM - $PWR_COUNT)) 
	if [ $(($PWR_NUM-$PWR_COUNT)) -eq 1 ] # 
 
	then
		let PWR_COUNT=$PWR_NUM
		let PWR_OFF=!$PWR_OFF
	elif [ $(($PWR_NUM-$PWR_COUNT)) -ge $MINUTES ] 
	then
	    echo "DC SUPPLY OFF"
		let PWR_COUNT=$PWR_NUM
		let OFF_COUNT=$(($OFF_COUNT+1))
		echo "DC POWER off system will go in shutdown in '$OFF_COUNT' min"
				if [ $OFF_COUNT -ge 6 ]
				then
						 shutdown -h now
				else
				   echo "$OFF_CONUT"
				fi
	else
	let PWR_COUNT=$PWR_NUM
	fi
sleep 60

done
