#!/bin/bash

# Created by Ben Bass
# Copyright 2011 Technology Revealed. All rights reserved.
# Rsync backup script.
# version 1.03h


# Setting variables for portability and ease of use
# if the path names have spaces DO NOT ESCAPE THEM
# how the variables are called removes the need for escaping spaces.

SOURCE="/"
DESTINATION="/Volumes/Server Backup/"
LOG="/Library/Logs/com.trmacs/server-bu.log"
EXCLUDES="/Users/admin/Documents/rsync-excludes.txt"


# formatting for the log file readability
# the >> "${LOG}" is used to append to the log file.

echo "----------------------------------"		>> "${LOG}"
echo "  Documents BU + Versions Backup"			>> "${LOG}"
echo "----------------------------------"		>> "${LOG}"
echo ""							>> "${LOG}"
date							>> "${LOG}"
echo ""							>> "${LOG}"


# using patched rsync to backup From  / to /Volumes/Server\ Backup/
# we are excluding the files from /Users/admin/Documents/rsync-exclude.txt
# optional flags:
# -n for testing (dry run) USE THIS WHEN TESTING!!!!
# --delete-excluded  BE CAREFUL this will delete everything in the excludes file from the destination.  Can cause problems when used in conjunction with other versioning scripts.

/usr/local/bin/rsync -aNHAXDxh --numeric-ids --partial --fileflags --force-change --stats --protect-decmpfs --del --delete-excluded --exclude-from="${EXCLUDES}" "${SOURCE}" "${DESTINATION}" >> "${LOG}"


# formatting for the log file readability
echo ""							>> "${LOG}"
date							>> "${LOG}"
echo ""							>> "${LOG}"
echo ""							>> "${LOG}"

