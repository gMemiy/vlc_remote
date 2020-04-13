#!/usr/bin/env bash
#
# react to cec keypresses in the jankiest way possible
#
# Author: Dave Eddy <dave@daveeddy.com>
# Date: 10/15/2013
# Licens: MIT
# Tested on: Raspberry pi with libcec compiled from soure
#
# vlc specific hotkey inputs and shutdown feature added, linus fargo
# plus decreased jankieness by switching search string from pressed to released
#

onF1()
{
 	echo 'blue button pressed'
	DISPLAY=:0 xdotool key f
}
onF2()
{
 	echo 'red button pressed'
	echo 'You are doing right'
	pcmanfm /mnt/windows_share
}
onF3()
{
 	echo 'green button pressed'
	pcmanfm /mnt/windows_share
}
onF4()
{
 	echo 'yellow button pressed'
}
onright() {
 	echo 'right button pressed'
	DISPLAY=:0 xdotool key Right
}
onleft() {
	echo 'left button pressed'
	DISPLAY=:0 xdotool key Left
}
onnine() {
	echo 'nine button pressed'
	/home/pi/rpvlcdmp/./powerdown.sh
}
ondown() {
	echo 'down button pressed'
	DISPLAY=:0 xdotool key Down
}
onup() {
	echo 'up button pressed'
	DISPLAY=:0 xdotool key Up
}
onselect() {
	echo 'select button pressed'
	DISPLAY=:0 xdotool key space
}
onplay() {
	echo 'play button pressed'
	DISPLAY=:0 xdotool key space
}
onpause() {
	echo 'pause button pressed'
	DISPLAY=:0 xdotool key space
}
onforward() {
	echo 'forward button pressed'
	DISPLAY=:0 xdotool key ctrl+Right
}
onbackward() {
	echo 'back button pressed'
	DISPLAY=:0 xdotool key ctrl+Left
}
ondisplay() {
	echo 'display button pressed'
	DISPLAY=:0 xdotool key i
}
onexit()
{
	echo 'exit button pressed'
	DISPLAY=:0 xdotool key BackSpace

}
onclear()
{
	echo 'clear button pressed'
	DISPLAY=:0 xdotool key alt+F4
}

filter() {
	perl -nle 'BEGIN{$|=1} /key released: (.*) \(.*\)/ && print $1'
}

echo as | cec-client | filter | \
while read cmd; do
	case "$cmd" in
		'F1 (blue)') onF1;;
		'F2 (red)') onF2;;
		'F3 (green)') onF3;;
		'F4 (yellow)') onF4;;
		clear) onclear;;
		exit) onexit;;
		right) onright;;
		left) onleft;;
		9) onnine;;
		up) onup;;
		down) ondown;;
		select) onselect;;
		play) onplay;;
		pause) onpause;;
		'Fast forward') onforward;;
		rewind) onbackward;;
		'display information') ondisplay;;
		*) echo "unrecognized button ($cmd)";;
	esac
done
