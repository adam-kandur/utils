#/usr/bin/env bash

function setLaptopScreen {
	xrandr \
		--output eDP-1 \
		--mode 1920x1200 \
		--pos 0x0 \
		--rotate normal \
		--output HDMI-1 --off
}

function setMonitorScreen {
	xrandr \
		--output eDP-1 --off \
		--output HDMI-1 --primary \
		--mode 1920x1080 --pos 0x0 \
		--rotate normal
}

function monitorDisconnected {
	[[ $(xrandr | grep "HDMI-1" | awk '{print $2}') == "disconnected" ]]
}

function checkMonitorConnectedButNotUsed {
	[[ $(xrandr | grep "HDMI-1" | awk '{print $2}') == "connected" ]] && \
		[[ ! $(xrandr | grep "HDMI-1" | awk '{print $4}') == "1920x1080+0+0" ]]
}

(checkMonitorConnectedButNotUsed && setMonitorScreen) \
	|| (monitorDisconnected && setLaptopScreen)
