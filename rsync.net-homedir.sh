#!/bin/bash

# Created by Ben Bass
# Copyright 2013 Technology Revealed. All rights reserved.
# Rsync script to backup home profile to rsync.net repo. 
vers='rsync.net-homedir-0.3'
# 0.2 - This synchs the entire home dir - the excludes file is where we are excluding directories.
# 0.3 - addition of ssh quota to note the usage of the rsync.net filesystem.

log="/Library/Logs/com.trmacs/rsync.net.log"
err_log="/Library/Logs/com.trmacs/rsync.net-error.log"
exec 1>> "${log}" 
exec 2>> "${err_log}"

host_name="$(scutil --get ComputerName)"

# Setting variables for portability and ease of use
SOURCE="/Users/benbass/"						# Source of the files
DESTINATION="2225@usw-s002.rsync.net:home_backup/benbass/"		# location of backup files
RLOG="/Library/Logs/com.trmacs/rsync.net-rlog.log"			# rsync log file
EXCLUDES="/Library/Scripts/trmacs/rsync.net-excludes.txt"		# File containing excludes

# Path Variables
RSYNC="/usr/local/bin/rsync"						# Location of the rsync bin

# formatting for the log file readability
echo "----------------------------------"
echo "     Home Directory Backup"
echo "----------------------------------"
echo ""
date
echo ""

echo "Host Name: 	"$host_name""
echo "Source: 	"${SOURCE}""
echo "Destination: 	"${DESTINATION}""

# we are excluding the files from /Library/Scripts/trmacs/rsync-excludes.txt
# -n for testing (dry run) USE THIS WHEN TESTING!!!!

"$RSYNC"							\
		-axzh						\
		--stats --del --delete-excluded			\
		--log-file="${RLOG}" 				\
		--exclude-from="${EXCLUDES}"			\
		"${SOURCE}" "${DESTINATION}"

#/usr/local/bin/rsync -avzPh --stats /Users/benbass/  2225@usw-s002.rsync.net:home_backup


# formatting for the log file readability

echo ""
ssh 2225@usw-s002.rsync.net quota
echo ""
date
echo ""

exit 0
