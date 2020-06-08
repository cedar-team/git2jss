#!/bin/bash

username=$4
password=$5

/usr/bin/dscl . -passwd /Users/${username} "${password}"