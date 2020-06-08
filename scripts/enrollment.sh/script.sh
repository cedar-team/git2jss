#!/bin/bash

#########################################################
#														#
# Script to be used with ghostpackages for splashbuddy. #
# enrollment.sh 										#
#														#
# this script will call jamf polcies based on their.    #
# custom trigger										#
#														#
#########################################################

#Apple approve way of getting current user until 10.15
function loggedInUser() {
	/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");'
}

## Check that a user is currently logged in before contiuning
while [[ "$(loggedInUser)" == "_mbsetupuser" ]]; do
	printf "No Logged in user found\nSleeping 2 seconds\n"
	sleep 2
done

echo "User account created"
echo "Current username:" $(loggedInUser)

jamfbinary=$(which jamf)
doneFile="/Users/Shared/.SplashBuddyDone"

echo "Drinking some Red Bull so the Mac doesn't fall asleep"
caffeinate -d -i -m -s -u &
caffeinatepid=$!

# Start installing policies from jamf

echo "Installing Symantech"
${jamfbinary} policy -event "sb_install_symantech"


echo "Installing Chrome"
${jamfbinary} policy -event "sb_install_chrome"

echo "Installing Slack"
${jamfbinary} policy -event "sb_install_slack"

echo "Installing Google FileStream"
${jamfbinary} policy -event "sb_install_google_filestream"

echo "Installing PyCharm Pro"
${jamfbinary} policy -event "sb_install_pycharm"

echo "Installing HomeBrew"
${jamfbinary} policy -event "sb_install_homebrew"

echo "Installing Postman"
${jamfbinary} policy -event "sb_install_postman"

echo "Setting up HomeBrew Packages"
${jamfbinary} policy -event "sb_install_homebrew_packages"

echo "Setting up Office365"
${jamfbinary} policy -event "sb_install_office365"

echo "Install Sublime Text - No Visual"
${jamfbinary} policy -event "sb_install_sublime_text"

echo "Install iTerm2 - No Visual"
${jamfbinary} policy -event "sb_install_iterm2"

echo "Install DevTools"
${jamfbinary} policy -event "sb_install_devtools"

echo "Setting up Dock"
${jamfbinary} policy -event "sb_set_dock"

echo "Pulling down policies"
${jamfbinary} policy -event "sb_security_policies"

echo "Cleaning up enrollment"
${jamfbinary} policy -event "sb_enrollment_end"

echo "Creating done file"
touch "$doneFile"

echo "Updating Inventory"
${jamfbinary} policy -event "updateInventory"

echo "Quitting SplashBuddy"
osascript -e 'quit app "SplashBuddy"'

echo "Unloading and removing Splashbuddy LaunchDaemon"
launchctl unload /Library/LaunchDaemons/io.fti.splashbuddy.launch.plist
rm -f /Library/LaunchDaemons/io.fti.splashbuddy.launch.plist

echo "Deleting SplashBuddy"
rm -rf "/Library/Application Support/SplashBuddy"

echo "Drank waaaayyyyy too much Red Bull"
kill "$caffeinatepid"

echo "Killing all open applications"
${jamfbinary} policy -event "sc_killAll"

echo "Logging user out to force FileVault encryption"
kill -9 `pgrep loginwindow`

