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

onright() {
 	echo 'right button pressed'
	DISPLAY=:0 xdotool key alt+Right
}
onleft() {
	echo 'left button pressed'
	DISPLAY=:0 xdotool key alt+Left
}
onnine() {
	echo 'nine button pressed'
	/home/pi/rpvlcdmp/./powerdown.sh
}
onup() {
	echo 'up button pressed'
	DISPLAY=:0 xdotool key f
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

filter() {
	perl -nle 'BEGIN{$|=1} /key released: (.*) \(.*\)/ && print $1'
}

echo as | cec-client | filter | \
while read cmd; do
	case "$cmd" in
		right) onright;;
		left) onleft;;
		9) onnine;;
		up) onup;;
		select) onselect;;
		play) onplay;;
		pause) onpause;;
		'Fast forward') onforward;;
		rewind) onbackward;;
		'display information') ondisplay;;
		*) echo "unrecognized button ($cmd)";;
	esac
done
