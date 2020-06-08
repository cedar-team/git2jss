#!/bin/sh
# This script checks if the existing pwpolicy (or non-existent pwpolicy) matches the pwpolicy by looking to see if
# the string <string>Does not match any of last 5 passwords</string> exists in the current computer's pwpolicy

# get logged-in user and assign it to a variable
LOGGEDINUSER=`who -q | head -1 | cut -d ' ' -f1`
if [ "$LOGGEDINUSER" == "_mbsetupuser" ]; then
    LOGGEDINUSER=`who -q | head -1 | cut -d ' ' -f2`
fi

CURRENTPWPOLICY=`pwpolicy -getaccountpolicies | grep 'Not be the same as the previous 6 passwords.' | head -1 | sed -e 's/  //g' `
PWPOLICY="<string>Not be the same as the previous 6 passwords.</string>"
if [ "$CURRENTPWPOLICY" == "$PWPOLICY" ]; then
    echo "<result>$LOGGEDINUSER has the password policy</result>"
else
    echo "<result>$LOGGEDINUSER DOES NOT have the password policy</result>"
fi
exit 0
