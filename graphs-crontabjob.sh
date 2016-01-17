#!/bin/sh

# by ted.sluis@gmail.com

# Create graphs if not exists or refresh them after they are to old.

RefreshGraph(){
        seconds=$1 # refresh after x seconds
        period=$2  # graph period
        step=$3    # steps

        # Look for previous created file(s):
        filemask="dump1090*$period.png"
        file=$(find /var/www/collectd/ -name $filemask | head -n 1)

        # Create file if not exists or refresh file when is to old.
        if [ -z "$file" ]; then
                echo "create $filemask,  step=$step"
                sudo /home/pi/dump-tools/collectd/make-graphs.sh $period $step
        else
                if [ -f $file ] && [ `stat --format=%Y $file` -le $(( `date +%s` - $seconds )) ]; then
                        echo "refresh $filemask,  step=$step,  expired=$seconds."
                        sudo /home/pi/dump-tools/collectd/make-graphs.sh $period $step
                else
                        if [ ! -f $file ]; then
                                echo "create $filemask,  step=$step,  file does not exists?!"
                                sudo /home/pi/dump-tools/collectd/make-graphs.sh $period $step
                        else
                                echo "not expired=$filemask,  step=$step,  expired=$seconds."
                        fi
                fi
        fi
}

# RefreshGraph(<refresh after x seconds>,<periode>,<steps>)
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

