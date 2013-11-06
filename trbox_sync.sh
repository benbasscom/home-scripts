#!/bin/bash
# rsync.net trdropbox sync
# Created by Ben Bass
# Copyright 2012 Technology Revealed. All rights reserved.
# Updates the work folder in the TR dropbox to rsync.net


/usr/local/bin/rsync -avzPh --stats /Users/benbass/TRBox/Dropbox/work/  2225@usw-s002.rsync.net:TR/Dropbox/work >> ~/Desktop/trbox.log

exit 0