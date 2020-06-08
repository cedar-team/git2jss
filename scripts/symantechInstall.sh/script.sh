#!/bin/bash
downloadDirectory="$4"
pkgName="$5"
installer -allowUntrusted -verboseR -pkg "$downloadDirectory"/"$pkgName" -target / 
installerExitCode=$?
if [ "$installerExitCode" -ne 0 ]; then
	printf "Failed to install: %s\n" "$pkgName"
	printf "Installer exit code: %s\n" "$installerExitCode"
	exit 2
fi
