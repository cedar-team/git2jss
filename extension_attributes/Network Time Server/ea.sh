#!/bin/sh
echo "<result>`/usr/sbin/systemsetup -getnetworktimeserver | awk '{print $4}'`</result>"
	