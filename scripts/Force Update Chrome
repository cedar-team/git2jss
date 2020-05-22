#!/bin/bash

dmgfile="googlechrome.dmg"
volname="Google Chrome"
logfile="/Library/Logs/GoogleChromeInstallScript.log"

url='https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg'

# Are we running on Intel?
if [ '`/usr/bin/uname -p`'="i386" -o '`/usr/bin/uname -p`'="x86_64" ]; then
		/bin/echo "--" >> ${logfile}
		/bin/echo "`date`: Downloading latest version." >> ${logfile}
		/usr/bin/curl -s -o /tmp/${dmgfile} ${url}
		/bin/echo "`date`: Mounting installer disk image." >> ${logfile}
		/usr/bin/hdiutil attach /tmp/${dmgfile} -nobrowse -quiet
		/bin/echo "`date`: Installing..." >> ${logfile}
		ditto -rsrc "/Volumes/${volname}/Google Chrome.app" "/Applications/Google Chrome.app"
		/bin/sleep 10
		/bin/echo "`date`: Unmounting installer disk image." >> ${logfile}
		/usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "${volname}" | awk '{print $1}') -quiet
		/bin/sleep 10
		/bin/echo "`date`: Deleting disk image." >> ${logfile}
		/bin/rm /tmp/"${dmgfile}"
else
	/bin/echo "`date`: ERROR: This script is for Intel Macs only." >> ${logfile}
fi

# Grab icon image from specified URL and place into /tmp
loggedInUser=$(stat -f%Su /dev/console)
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
windowType="hud"
description="There is a critical security update for Chrome available for your Cedar-issued computer. To perform the update, select 'UPDATE' below and the security update will begin to run. If you aren't able to run it now, you can move this window to the bottom of your screen.

WARNING: If you do not update in 2 hours, your Chrome browser will automatically update'

*Please save your state in Chrome and click 'UPDATE.'

If you require assistance, please contact Thomas or Taylor."

button1="UPDATE"
button2="Cancel"
icon="/System/Library/CoreServices/loginwindow.app/Contents/Resources/Restart.tiff"
title="Critical: Chrome Security Update Available"
alignDescription="left"
alignHeading="center"
defaultButton="2"
timeout="7200" # 2 hours

# JAMF Helper window as it appears for targeted computers
userChoice=$("$jamfHelper" -countdown -windowType "$windowType" -lockHUD -title "$title" -timeout "$timeout" -defaultButton "$defaultButton" -icon "$icon" -description "$description" -alignDescription "$alignDescription" -alignHeading "$alignHeading" -button1 "$button1")
osascript -e 'tell application "Chrome" to quit'
sleep 5s
open /Applications/Google\ Chrome.app