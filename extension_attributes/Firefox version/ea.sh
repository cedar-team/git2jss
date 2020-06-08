#!/bin/bash

FFV=`/Applications/Firefox.app/Contents/MacOS/firefox --version | awk '{ print $3 '}`

echo "<result>$FFV</result>"