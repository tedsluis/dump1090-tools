#!/bin/bash

# This script schedules the creation of graphs. Not every graph type must be updated every 5 minutes.
# Graphs that views a hourly or 6 hourly period will be updated every 5 minutes, but other graphs will
# be refreshed less frequently.
#
# Everytime this script runs it checks how long ago a graph was updated. Depending on the period type
# it will be refreshed less often.

# By ted.sluis@gmail.com

# Create graphs if not exists or refresh them after they are to old.
RefreshGraph(){
        seconds=$1 # refresh after x seconds
        period=$2  # graph period
        step=$3    # steps

        # Look for previous created file(s):
        filemask="dump1090*$period.png"
        file=$(find /var/www/collectd/ -name $filemask -printf "%T+\t%p\n" | sort -r | head -n 1 | awk '{print $2}')

        # Create file if not exists or refresh file when is to old.
        if [ -z "$file" ]; then
                printf "create      %17s   step=%5s\n" "$filemask"  "$step"
        else
                expire=$(expr $((`stat --format=%Y $file`)) - $(( `date +%s` - $seconds )))
                if [ -f $file ] && [ $expire -le 0 ]; then
                        printf "refresh     %17s   step=%5s   expired=%5s   expired_after=%5s\n" "$filemask" "$step" "$expire" "$seconds"
                else
                        if [ ! -f $file ]; then
                                printf "create      %17s   step=%5s   file does not exists?!\n" "$filemask" "$step"
                        else
                                printf "not expired %17s   step=%5s   expired=%5s   expired_after=%5s\n" "$filemask" "$step" "$expire" "$seconds"
                                return
                        fi
                fi
        fi
        sudo /home/pi/dump-tools/collectd/make-graphs.sh $period $step
}

# RefreshGraph "<refresh after x seconds>," "<periode>" "<steps>"
RefreshGraph "300"   "1h"   "8"
RefreshGraph "300"   "6h"   "45"
RefreshGraph "600"   "24h"  "180"
RefreshGraph "1200"  "2d"   "360"
RefreshGraph "1800"  "3d"   "540"
RefreshGraph "3600"  "7d"   "1260"
RefreshGraph "7200"  "14d"  "2520"
RefreshGraph "14400" "30d"  "5400"
RefreshGraph "14400" "90d"  "10800"
RefreshGraph "28800" "365d" "86400"

