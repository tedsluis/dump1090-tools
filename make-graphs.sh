#!/bin/sh

# By ted.sluis@gmail.com
# Based on dump1090-tools (https://github.com/mutability/dump1090-tools) by mutability and addons by Xforce30164.

# Creates graphs using rrdtool.

# Usage: make-graphs.sh <period> [<steps>]
# For example:
# make-graphs.sh 1h    8
# make-graphs.sh 6h    45
# make-graphs.sh 24h   180
# make-graphs.sh 2d    360
# make-graphs.sh 3d    540
# make-graphs.sh 7d    1260
# make-graphs.sh 14d   2520
# make-graphs.sh 30d   5400
# make-graphs.sh 90d   10800
# make-graphs.sh 365d  68400

renice -n 5 -p $$

# Graph width x height
FULL_WIDTH="1200"
FULL_HEIGHT="768"
PREVIEW_WIDTH="630"
PREVIEW_HEIGHT="300"

# watermark (in the bottum of the graph)
nowlit=`date '+%m/%d/%y %H:%M %Z'`;

# Hostname
H=`uname -n`;

# Check if rrd files exits.
checkrrd() {
  NODATA=1
  PICFILE=$1
  shift
  for RRDFILE in "$@"
  do
    if [ ! -f "$RRDFILE" ]; then
      NODATA=0
    fi
  done
  if [ ! -f "$PICFILE" ]; then
    cp "/var/www/collectd/nodata.png" "$PICFILE"
    echo "copy nodata to $PICFILE"
  fi
  return $NODATA
}

# Antenna range in kilometers.
# Including a minimal and maximum range.
metric_range_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "Antenna range" "$4" "$5"
  if checkrrd "$1" "$2/dump1090_range-max_range.rrd"; then echo "none"; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - max range - $4" \
  --vertical-label "kilometers" \
  --lower-limit 0 \
  --units-exponent 0 \
  "DEF:rangemax=$2/dump1090_range-max_range.rrd:value:MAX" \
  "DEF:rangeavg=$2/dump1090_range-max_range.rrd:value:AVERAGE" \
  "DEF:rangemin=$2/dump1090_range-max_range.rrd:value:MIN" \
  "CDEF:range=rangemax,0.001,*" \
  "CDEF:range_max=rangemax,0.001,*" \
  "CDEF:range_avg=rangeavg,0.001,*" \
  "CDEF:range_min=rangemin,0.001,*" \
  "VDEF:max=range_max,MAXIMUM" \
  "VDEF:avg=range_avg,AVERAGE" \
  "VDEF:min=range_min,MINIMUM" \
  "LINE1:max#FF0000:max" \
  "GPRINT:max:%1.1lf km" \
  "LINE1:avg#CC9900:average range\\::dashes" \
  "GPRINT:avg:%1.1lf km" \
  "LINE1:min#33FF00:min" \
  "LINE1:range#0000FF:max range" \
  --watermark "Drawn: $nowlit";
}

# Signal power, peak signal power and >-3dBFS / hr (RHS).
signal_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "Signal power" "$4" "$5"
  if checkrrd "$1" "$2/dump1090_dbfs-signal.rrd" "$2/dump1090_dbfs-peak_signal.rrd" "$2/dump1090_messages-strong_signals.rrd"; then echo "none"; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - $3 signal - $4" \
  --vertical-label "dBFS" \
  --upper-limit 0    \
  --lower-limit -50  \
  --rigid            \
  --units-exponent 0 \
  "DEF:signal=$2/dump1090_dbfs-signal.rrd:value:AVERAGE" \
  "DEF:peak=$2/dump1090_dbfs-peak_signal.rrd:value:AVERAGE" \
  "DEF:strong=$2/dump1090_messages-strong_signals.rrd:value:AVERAGE" \
  "CDEF:str=strong,UN,0,strong,IF" \
  "CDEF:strng=str,1,*" \
  "CDEF:strg=-50,strng,+" \
  "CDEF:us=signal,UN,-100,signal,IF" \
  "AREA:-100#00FF00:mean signal power" \
  "AREA:us#FFFFFF" \
  "LINE1:peak#0000FF:peak signal power" \
  "LINE1:strg#FF0000:messages >-3dBFS / hr (RHS)" \
  --watermark "Drawn: $nowlit";
}

# local messages received/sec, remote messages received/sec, position / hr (RHS).
local_rate_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "messages" "$4" "$5"
 if checkrrd "$1" "$2/dump1090_messages-local_accepted.rrd" "$2/dump1090_messages-remote_accepted.rrd" "$2/dump1090_messages-positions.rrd"; then echo "none" ; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title " $H - $3 message rate - $4" \
  --vertical-label "messages/second" \
  --right-axis-label "position / hr (RHS)" \
  --lower-limit 0  \
  --units-exponent 0 \
  --right-axis 360:0 \
  "TEXTALIGN:left" \
  "DEF:lmessages=$2/dump1090_messages-local_accepted.rrd:value:AVERAGE" \
  "DEF:rmessages=$2/dump1090_messages-remote_accepted.rrd:value:AVERAGE" \
  "DEF:positions=$2/dump1090_messages-positions.rrd:value:AVERAGE" \
  "CDEF:y2positions=positions,10,*" \
  "LINE1:lmessages#0000FF:local messages received/sec" \
  "GPRINT:lmessages:MIN: min\:%4.0lf" \
  "GPRINT:lmessages:AVERAGE:average\:%4.0lf" \
  "GPRINT:lmessages:MAX:max\:%4.0lf\n" \
  "LINE1:rmessages#FF00CC:remote messages received/sec" \
  "GPRINT:rmessages:MIN:min\:%4.0lf" \
  "GPRINT:rmessages:AVERAGE:average\:%4.0lf" \
  "GPRINT:rmessages:MAX:max\:%4.0lf\n" \
  "LINE1:y2positions#00c0FF:position / hr (RHS)    " \
  "GPRINT:y2positions:MIN:     min\:%4.0lf" \
  "GPRINT:y2positions:AVERAGE:average\:%4.0lf" \
  "GPRINT:y2positions:MAX:max\:%4.0lf" \
  --watermark "Drawn: $nowlit";
}

# Aircraft tracked, aircraft with positions, aircraft with mlat, percentage with positions
aircraft_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "Aircrafts" "$4" "$5"
  if checkrrd "$1" "$2/dump1090_aircraft-recent.rrd" "$2/dump1090_mlat-recent.rrd"; then echo "none"; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - $3 aircraft seen - $4" \
  --vertical-label "aircraft" \
  --lower-limit 0 \
  --units-exponent 0 \
  --right-axis-label "percentage aircraft tracked with position" \
  --right-axis 0.5:0 \
  "TEXTALIGN:left" \
  "DEF:all=$2/dump1090_aircraft-recent.rrd:total:AVERAGE" \
  "DEF:pos=$2/dump1090_aircraft-recent.rrd:positions:AVERAGE" \
  "DEF:mlat=$2/dump1090_mlat-recent.rrd:value:AVERAGE" \
  "CDEF:perc_seen=pos,all,/" \
  "CDEF:seenperc=perc_seen,100,*" \
  "CDEF:percseen=perc_seen,200,*" \
  "AREA:all#00FF00:aircraft tracked         " \
  "GPRINT:all:MIN:min tracked\:       %3.0lf  " \
  "GPRINT:all:AVERAGE:avg tracked\:       %3.0lf  " \
  "GPRINT:all:MAX:max tracked\:       %3.0lf\n" \
  "LINE1:pos#0000FF:aircraft with positions  " \
  "GPRINT:pos:MIN:min with positions\:%3.0lf  " \
  "GPRINT:pos:AVERAGE:avg with positions\:%3.0lf  " \
  "GPRINT:pos:MAX:max with positions\:%3.0lf\n" \
  "LINE1:mlat#000000:aircraft with mlat       " \
  "GPRINT:mlat:MIN:min mlat positions\:%3.0lf" \
  "GPRINT:mlat:AVERAGE:  avg mlat positions\:%3.0lf" \
  "GPRINT:mlat:MAX:  max mlat positions\:%3.0lf" \
  "LINE1:percseen#FF9900:percentage with positions" \
  "GPRINT:seenperc:MIN:min with positions\:%3.0lf %%" \
  "GPRINT:seenperc:AVERAGE:avg with positions\:%3.0lf %%" \
  "GPRINT:seenperc:MAX:max with positions\:%3.0lf %%" \
  --watermark "Drawn: $nowlit";
}

# tracks with single message, unique tracks:STACK
tracks_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "tracks" "$4" "$5"
  if checkrrd "$1" "$2/dump1090_tracks-all.rrd" "$2/dump1090_tracks-single_message.rrd"; then echo "none"; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - $3 tracks seen - $4" \
  --vertical-label "tracks/hour" \
  --lower-limit 0 \
  --units-exponent 0 \
  "TEXTALIGN:left" \
  "DEF:all=$2/dump1090_tracks-all.rrd:value:AVERAGE" \
  "DEF:single=$2/dump1090_tracks-single_message.rrd:value:AVERAGE" \
  "CDEF:hall=all,3600,*" \
  "CDEF:hsingle=single,3600,*" \
  "AREA:hsingle#FF0000:tracks with single message" \
  "AREA:hall#00FF00:unique tracks:STACK" \
  --watermark "Drawn: $nowlit";
}

# cpu usage USB, other and demodulator. cpu temp
cpu_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "CPU usage" "$4" "$5"
  if checkrrd "$1" "$2/dump1090_cpu-demod.rrd" "$2/dump1090_cpu-reader.rrd" "$2/dump1090_cpu-background.rrd" "/var/lib/collectd/rrd/localhost/table-rpi/gauge-cpu_temp.rrd"; then echo "none"; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - $3 CPU % and temperature - $4" \
  --vertical-label "CPU %" \
  --right-axis 1:0 \
  --right-axis-label "Degrees Celcius" \
  --lower-limit 0 \
  --upper-limit 100 \
  --rigid \
  "DEF:demod=$2/dump1090_cpu-demod.rrd:value:AVERAGE" \
  "CDEF:demodp=demod,10,/" \
  "DEF:reader=$2/dump1090_cpu-reader.rrd:value:AVERAGE" \
  "CDEF:readerp=reader,10,/" \
  "DEF:background=$2/dump1090_cpu-background.rrd:value:AVERAGE" \
  "CDEF:backgroundp=background,10,/" \
  "CDEF:totcpu=demodp,readerp,+" \
  "CDEF:tot_cpu=totcpu,backgroundp,+" \
  "DEF:traw=/var/lib/collectd/rrd/localhost/table-rpi/gauge-cpu_temp.rrd:value:MAX" \
  "CDEF:tta=traw,1000,/" \
  "AREA:readerp#008000:USB" \
  "AREA:backgroundp#00C000:other:STACK" \
  "AREA:demodp#00FF00:demodulator:STACK"\
  "GPRINT:tot_cpu:AVERAGE:average cpu\:%2.1lf %%" \
  "GPRINT:tot_cpu:MAX:max cpu\:%2.1lf %%\n" \
  "TEXTALIGN:left" \
  "LINE1:tta#FF0000:cpu temperature" \
  "GPRINT:tta:MAX:max cpu temperature\:%2.1lf C" \
  "GPRINT:tta:AVERAGE:avg cpu temperature\:%2.1lf C" \
  "GPRINT:tta:MIN:min cpu temperature\:%2.1lf C" \
  --watermark "Drawn: $nowlit";
}

# Network traffic incomming, outgoining, errors
net_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "Network IO" "$4" "$5"
  if checkrrd "$1" "$2/if_octets.rrd" "$2/if_errors.rrd"; then echo "none"; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - $3 Bandwidth - eth0 - $4" \
  --vertical-label "bytes/sec" \
  "TEXTALIGN:left" \
  "DEF:rx=$2/if_octets.rrd:rx:AVERAGE" \
  "DEF:tx=$2/if_octets.rrd:tx:AVERAGE" \
  "DEF:er=$2/if_errors.rrd:tx:AVERAGE" \
  "CDEF:tx_neg=tx,-1,*" \
  "CDEF:er_neg=er,-1000,*" \
  "AREA:rx#32CD32:Incoming" \
  "LINE1:rx#336600" \
  "GPRINT:rx:MAX:Max\:%4.1lf %s" \
  "GPRINT:rx:AVERAGE:Avg\:%4.1lf %S" \
  "GPRINT:rx:LAST:Current\:%4.1lf %Sbytes/sec\n" \
  "AREA:tx_neg#4169E1:Outgoing" \
  "LINE1:tx_neg#0033CC" \
  "GPRINT:tx:MAX:Max\:%4.1lf %S" \
  "GPRINT:tx:AVERAGE:Avg\:%4.1lf %S" \
  "GPRINT:tx:LAST:Current\:%4.1lf %Sbytes/sec\n" \
  "LINE1:er_neg#FF0000" \
  "AREA:er_neg#FF0000:Errors  " \
  "GPRINT:er:MAX:Max\:%2.0lf e/s" \
  "GPRINT:er:AVERAGE:Avg\:%2.0lf errors/sec" \
  "HRULE:0#000000" \
  --watermark "Drawn: $nowlit";
}

# Memory used, buffered, free and cached.
# Disk space used and free.
memory_graph() {
  printf "%15s - period=%4s - step=%5s - size=" "Memory usage" "$4" "$5"
  if checkrrd "$1" "$2/memory-buffered.rrd" "$2/memory-cached.rrd" "$2/memory-free.rrd" "$2/memory-used.rrd" "/var/lib/collectd/rrd/localhost/df-root/df_complex-used.rrd" "/var/lib/collectd/rrd/localhost/df-root/df_complex-reserved.rrd" "/var/lib/collectd/rrd/localhost/df-root/df_complex-free.rrd"; then echo "none"; return; fi 
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - $3 Memory & Disk Space (/) - $4" \
  --vertical-label "Disk Space" \
  --right-axis-label "Memory" \
  --right-axis 0.032:0 \
  --lower-limit 0  \
  "TEXTALIGN:left" \
  "DEF:buffered=$2/memory-buffered.rrd:value:AVERAGE" \
  "DEF:cached=$2/memory-cached.rrd:value:AVERAGE" \
  "DEF:free=$2/memory-free.rrd:value:AVERAGE" \
  "DEF:used=$2/memory-used.rrd:value:AVERAGE" \
  "CDEF:totalmem1used=cached,buffered,+" \
  "CDEF:totalmemused=totalmem1used,used,+" \
  "CDEF:bufferedm=buffered,32,*" \
  "CDEF:cachedm=cached,32,*" \
  "CDEF:freem=free,32,*" \
  "CDEF:usedm=used,32,*" \
  "DEF:useddf=/var/lib/collectd/rrd/localhost/df-root/df_complex-used.rrd:value:AVERAGE" \
  "DEF:reserved=/var/lib/collectd/rrd/localhost/df-root/df_complex-reserved.rrd:value:AVERAGE" \
  "DEF:freedf=/var/lib/collectd/rrd/localhost/df-root/df_complex-free.rrd:value:AVERAGE" \
  "CDEF:totalused=useddf,reserved,+" \
  "GPRINT:totalmemused:LAST:current mem used\:%4.1lf %s" \
  "GPRINT:free:LAST:current mem free\:%4.1lf %s" \
  "AREA:usedm#33FFFF:Mem used :STACK" \
  "AREA:bufferedm#32C734:Mem buffered:STACK" \
  "AREA:cachedm#00FF00:Mem cached:STACK" \
  "AREA:freem#FFFFFF:Mem free\n:STACK" \
  "GPRINT:totalused:LAST:current disk used\:%4.1lf %s" \
  "GPRINT:freedf:LAST:current disk free\:%4.1lf %s" \
  "LINE1:totalused#FF0000:Disk used" \
  "LINE2:freedf#3300FF:Disk free"  \
  --watermark "Drawn: $nowlit";
}

# Disk IO read and write / throughput read and write
diskio_ops_graph() {
  if checkrrd "$1" "$2/disk_ops.rrd" "$2/disk_octets.rrd"; then echo "none"; return; fi 
  printf "%15s - period=%4s - step=%5s - size=" "Disk IO" "$4" "$5"
  rrdtool graph \
  "$1" \
  --start end-$4 \
  --width "$6" \
  --height "$7" \
  --step "$5" \
  --title "$H - $3 IOPS / Bandwidth - $4" \
  --vertical-label "IOPS" \
  --right-axis-label "KB/s" \
  --right-axis 100:0 \
  "TEXTALIGN:center" \
  "DEF:read=$2/disk_ops.rrd:read:AVERAGE" \
  "DEF:write=$2/disk_ops.rrd:write:AVERAGE" \
  "CDEF:write_neg=write,-1,*" \
  "DEF:read_bw=$2/disk_octets.rrd:read:AVERAGE" \
  "DEF:write_bw=$2/disk_octets.rrd:write:AVERAGE" \
  "CDEF:read_bw_kb=read_bw,1000,/" \
  "CDEF:write_bw_kb=write_bw,1000,/" \
  "CDEF:write_bw_neg=write_bw_kb,-1,*" \
  "CDEF:read_bw_kb_f=read_bw_kb,100,/" \
  "CDEF:write_bw_neg_f=write_bw_neg,100,/" \
  "AREA:read#336600:Reads " \
  "LINE1:read#336600" \
  "GPRINT:read:MAX:Max\:%4.1lf iops" \
  "GPRINT:read:AVERAGE:Avg\:%4.1lf iops" \
  "GPRINT:read:LAST:Current\:%4.1lf iops\c" \
  "TEXTALIGN:center" \
  "AREA:write_neg#FFA500:Writes" \
  "LINE1:write_neg#FFA500" \
  "GPRINT:write:MAX:Max\:%4.1lf iops" \
  "GPRINT:write:AVERAGE:Avg\:%4.1lf iops" \
  "GPRINT:write:LAST:Current\:%4.1lf iops\c" \
  "LINE1:read_bw_kb_f#FF0000:Reads" \
  "GPRINT:read_bw_kb:MAX:Max\:%4.1lf KB/s" \
  "GPRINT:read_bw_kb:AVERAGE:Avg\:%4.1lf KB/s" \
  "GPRINT:read_bw_kb:LAST:Current\:%4.1lf KB/s\c" \
  "LINE1:write_bw_neg_f#3300FF:Writes"  \
  "GPRINT:write_bw_kb:MAX:Max\:%4.1lf KB/s" \
  "GPRINT:write_bw_kb:AVERAGE:Avg\:%4.1lf KB/s" \
  "GPRINT:write_bw_kb:LAST:Current\:%4.1lf KB/s\c" \
  "HRULE:0#000000" \
  --watermark "Drawn: $nowlit";
}

common_graphs() {
  aircraft_graph     /var/www/collectd/dump1090-$2-acs-$4.png    /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  cpu_graph          /var/www/collectd/dump1090-$2-cpu-$4.png    /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  tracks_graph       /var/www/collectd/dump1090-$2-tracks-$4.png /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  metric_range_graph /var/www/collectd/dump1090-$2-range-$4.png  /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  signal_graph       /var/www/collectd/dump1090-$2-signal-$4.png /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  local_rate_graph   /var/www/collectd/dump1090-$2-rate-$4.png   /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  net_graph          /var/www/collectd/dump1090-$2-eth0-$4.png   /var/lib/collectd/rrd/localhost/interface-eth0  "$3" "$4" "$5" "$6" "$7"
 #net_graph          /var/www/collectd/dump1090-$2-wlan0-$4.png  /var/lib/collectd/rrd/localhost/interface-wlan0 "$3" "$4" "$5" "$6" "$7"
  memory_graph       /var/www/collectd/dump1090-$2-memory-$4.png /var/lib/collectd/rrd/$1/memory                 "$3" "$4" "$5" "$6" "$7"
  diskio_ops_graph   /var/www/collectd/dump1090-$2-disk-$4.png   /var/lib/collectd/rrd/$1/disk-mmcblk0           "$3" "$4" "$5" "$6" "$7"
}

common_graphs_preview() {
  aircraft_graph     /var/www/collectd/dump1090-$2-acs-preview-$4.png    /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  cpu_graph          /var/www/collectd/dump1090-$2-cpu-preview-$4.png    /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  tracks_graph       /var/www/collectd/dump1090-$2-tracks-preview-$4.png /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  metric_range_graph /var/www/collectd/dump1090-$2-range-preview-$4.png  /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  signal_graph       /var/www/collectd/dump1090-$2-signal-preview-$4.png /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  local_rate_graph   /var/www/collectd/dump1090-$2-rate-preview-$4.png   /var/lib/collectd/rrd/$1/dump1090-$2            "$3" "$4" "$5" "$6" "$7"
  net_graph          /var/www/collectd/dump1090-$2-eth0-preview-$4.png   /var/lib/collectd/rrd/localhost/interface-eth0  "$3" "$4" "$5" "$6" "$7"
 #net_graph          /var/www/collectd/dump1090-$2-wlan0-preview-$4.png  /var/lib/collectd/rrd/localhost/interface-wlan0 "$3" "$4" "$5" "$6" "$7"
  memory_graph       /var/www/collectd/dump1090-$2-memory-preview-$4.png /var/lib/collectd/rrd/$1/memory                 "$3" "$4" "$5" "$6" "$7"
  diskio_ops_graph   /var/www/collectd/dump1090-$2-disk-preview-$4.png   /var/lib/collectd/rrd/$1/disk-mmcblk0           "$3" "$4" "$5" "$6" "$7"
}

# receiver_graphs host shortname longname period step
receiver_graphs() {
  common_graphs "$1" "$2" "$3" "$4" "$5" "$FULL_WIDTH" "$FULL_HEIGHT"
  common_graphs_preview "$1" "$2" "$3" "$4" "$5" "$PREVIEW_WIDTH" "$PREVIEW_HEIGHT"
}

period="$1"
step="$2"

receiver_graphs localhost rpi "RPi ADS-B" "$period" "$step"

