#!/bin/bash

# Created by Ben Bass
# Copyright 2013 Technology Revealed. All rights reserved.
# Rsync script to backup home profile to rsync.net repo. 
vers='home_repo_sync-homedir-0.1'
# 0.1 - Initial script



log="/Library/Logs/com.trmacs/home_repo.log"
err_log="/Library/Logs/com.trmacs/home_repo-error.log"
exec 1>> "${log}" 
exec 2>> "${err_log}"

host_name="$(scutil --get ComputerName)"

# Setting variables for portability and ease of use
SOURCE="root@home.benbass.com:/Volumes/Storage/munki/repo/"		# Source of the files
DESTINATION="/Users/benbass/munki_repo/home/home_repo"			# location of backup files
RLOG="/Library/Logs/com.trmacs/home_repo-rlog.log"			# rsync log file
EXCLUDES="/Library/Scripts/trmacs/rsync-excludes.txt"			# File containing excludes
REMOTE_RSYNC="/usr/local/bin/rsync"					# location of remote rsync binary
# Path Variables
RSYNC="/usr/local/bin/rsync"						# Location of the rsync bin

# formatting for the log file readability
echo "----------------------------------"
echo "     Home munki repo sync"
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
		-rltxzhX					\
		--stats --del --delete-excluded			\
		--log-file="${RLOG}" 				\
		--rsync-path="${REMOTE_RSYNC}"			\
		--exclude-from="${EXCLUDES}"			\
		"${SOURCE}" "${DESTINATION}"



# formatting for the log file readability

echo ""
date
echo ""

exit 0
