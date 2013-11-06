#!/bin/bash

# Created by Ben Bass
# Copyright 2011 Technology Revealed. All rights reserved.
# Rsync backup script with Versioning. Still working on a self thinning version.
# version 1.03h

# Setting the variable as 2011-07-6-16-38 (year, month, day, hour, minute)
# To create a unique directory as the destination of the backed up files.

UNIQUE=$1
: ${UNIQUE:="$(date +%Y-%m-%d-%H-%M)"}

# Setting variables for portability and ease of use
# if the path names have spaces DO NOT ESCAPE THEM
# how the variables are called removes the need for escaping spaces.

SOURCE="/Volumes/Storage/Share Points/Software/"
DESTINATION="/Shared Items/Software-bu"
LOG="/Library/Logs/com.trmacs/software-bu.log"
EXCLUDES="/Users/admin/Documents/rsync-excludes.txt"
BACKUPDIR=$2
: ${BACKUPDIR:="/Shared Items/Versions/Software/$UNIQUE"}


# formatting for the log file readability
# the >> "${LOG}" is used to append to the log file.

echo "----------------------------------"		>> "${LOG}"
echo "      Software BU + Versions"			>> "${LOG}"
echo "----------------------------------"		>> "${LOG}"
echo ""							>> "${LOG}"
date							>> "${LOG}"
echo ""							>> "${LOG}"


# using patched rsync to backup From point /Volumes/Storage/Share Points/Admin/ to /Shared Items/Admin-bu
# we are excluding the files from /Users/admin/Documents/rsync-exclude.txt
# optional flags:
# -n for testing (dry run) USE THIS WHEN TESTING!!!!
# --delete-excluded  BE CAREFUL this will delete everything in the excludes file from the destination.  Can cause problems when used in conjunction with other versioning scripts.

/usr/local/bin/rsync -aNHAXDxh --numeric-ids --partial --fileflags --force-change --stats --protect-decmpfs --del --delete-excluded --exclude-from="${EXCLUDES}" -b --backup-dir="${BACKUPDIR}" "${SOURCE}" "${DESTINATION}" >> "${LOG}"


# formatting for the log file readability
echo ""							>> "${LOG}"
echo "The version folder is "${BACKUPDIR}""		>> "${LOG}"
echo ""							>> "${LOG}"
date							>> "${LOG}"
echo ""							>> "${LOG}"
echo ""							>> "${LOG}"

