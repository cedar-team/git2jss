#!/bin/bash

# From https://www.jamf.com/jamf-nation/discussions/26656/how-to-install-citrix-receiver-12-8-via-login-trigger-or-self-service-and-avoid-failed-status-in-policy-log
#########InstallOptions.txt creation
curUser=`ls -l /dev/console | cut -d " " -f 4`
# For new users ensure the directories exist D'oh!
mkdir -p /Library/Application\ Support/Citrix\ Receiver
cat > /Library/Application\ Support/Citrix\ Receiver/InstallOptions.txt <<EOF

INSTALLING_USER=$curUser

EOF