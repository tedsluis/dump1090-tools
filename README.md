# dump1090-tools for raspberry pi.
   
## Table of contents
   * [dump1090-tools for raspberry pi.](#dump1090-tools-for-raspberry-pi)
      * [Table of contents](#table-of-contents)
      * [Credits](#credits)
      * [Features](#features)
      * [Manual installation.](#manual-installation)
      * [Installation using installer.](#installation-using-installer)
      * [Testing and troubleshooting.](#testing-and-troubleshooting)
      * [More info.](#more-info)
   
## Credits  
   
Based on https://github.com/mutability/dump1090-tools by Oliver Jowett <oliver@mutability.co.uk> and Xforce30164.
  
## Features  
  
* Monitors Dump1090 Mutability running on raspberry pi (raspbian & piaware) and orange pi (armbian).
* Fully automated installer included.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/week.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/week.png"
alt="dump-tools week view" width="1200" height="600" border="10" /></a>
  
Collects stats like:
* number of local & remote messages received per second.
* number of positions per hour.
    
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/message_rate.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/message_rate.png"
alt="dump-tools message rate" width="633" height="333" border="10" /></a>
    
* number of aircraft tracked with position, without position, with mlat.
* percantage aircraft traked with position.
    
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/aircraftseen.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/aircraftseen.png"
alt="dump-tools aircraft seen" width="633" height="333" border="10" /></a>
    
* tracked with single position or unique tracked.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/tracksseen.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/tracksseen.png"
alt="dump-tools tracks seen" width="633" height="333" border="10" /></a>
   
* main signal power and peak signal power.
* messages > -3 dBFS per hour.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/signal.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/signal.png"
alt="dump-tools signal power" width="633" height="333" border="10" /></a>
   
* range in kilometers.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/range.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/range.png"
alt="dump-tools range view" width="633" height="333" border="10" /></a>
   
* cpu utalisation & temperature.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/cpu.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/cpu.png"
alt="dump-tools cpu utilisation and temperature" width="633" height="333" border="10" /></a>
   
* disk & memory usage.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/space.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/space.png"
alt="dump-tools disk and memory usage" width="633" height="333" border="10" /></a>
   
* disk IOPS & throughput.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/disk.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/disk.png"
alt="dump-tools disk bandwidth" width="633" height="333" border="10" /></a>
  
* network interface IOPS & throughput.
   
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/network.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/network.png"
alt="dump-tools network bandwidth" width="633" height="333" border="10" /></a> 
  
* Period button bar. Available graphs: 1 hour, 6 hour, 24 hour, 2 days, 3days, 7 days, 14 days, 30 days, 90 days, 365 days. Automatic web browser refresh every minute without changing the graph interval to default.  
  
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/period_bar.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/period_bar.png"
alt="period bar"  /></a>
  
* Dump1090 hosts bar, automatitly dynamicly created. Reads /etc/hosts and /home/pi/dump-tools/collectd/hosts and then adds or remove other dump1090 hosts to /var/www/collectd/index.html.
  
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/dump1090_hosts_bar.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/dump1090_hosts_bar.png"
alt="dump1090 hosts bar" /></a>
  
* Display a 'no data' image when there is no RRD file.  
  
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/nodata.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/nodata.png"
alt="No data" /></a>
  
* Automatic scaling graphs in the web web browser.   
 
## Manual installation. 
  
Install the collectd package:
````
$ sudo apt-get install -y collectd
````
Download the files and copy them to the following directories:

/etc/collectd/
* collectd.conf

/var/www/collectd/
* index.html
* default.css
* jquery.js

/home/pi/dump-tools/collectd/
* dump1090.db
* dump1090.py
* graphs-crontabjob.sh
* make-graphs.sh
* insert_hosts.sh

````
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/collectd.conf   -O /etc/collectd/collectd.conf
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/index.html      -O /var/www/collectd/index.html
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/default.css     -O /var/www/collectd/default.css
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/jquery.js       -O /var/www/collectd/jquery.js
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090.db          -O /home/pi/dump-tools/collectd/dump1090.db
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090.py          -O /home/pi/dump-tools/collectd/dump1090.py
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/graphs-crontabjob.sh -O /home/pi/dump-tools/collectd/graphs-crontabjob.sh
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/make-graphs.sh       -O /home/pi/dump-tools/collectd/make-graphs.sh
````

Set execute permission on scripts:
````
$ sudo chmod 775 /home/pi/dump-tools/collectd/*.sh
````
Start the collection deamon:
````
$ sudo /etc/init.d/collectd restart
````
Look for other dump1090 hosts in /etc/hosts and /home/pi/dump-tool/collectd/hosts and add then to /var/www/collectd/index.html:
````
# sudo /home/pi/dump-tools/collectd/insert_hosts.sh
````
Create a crontab entery that will launch the script that creates the graphs.
The script takes care of the refresh frequency. The hourly graphs will be refreshed every 5 minutes.
Weekly en monthly graphs will only be refresh a few times a day.

$ sudo crontab -e
````
*/5 * * * *              sudo /home/pi/dump-tools/collectd/graphs-crontabjob.sh > /dev/null
````

Change web server root from /var/www/html into /var/www:

````
sudo sed -i 's/server.document-root.*/server.document-root        = \"\/var\/www\"/g' "/etc/lighttpd/lighttpd.conf"
````

Restart lighthttp web server:

````
sudo /etc/init.d/lighttpd force-reload
````

Finished!

## Installation using installer.
Download the [installer (dump1090-tools-install.sh)](https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090-tools-install.sh) and launch it. The installer will:
* Creates directories (with the permissions of the parent directory).
* Downloads the files and copies them with the correct permissions to the target directories.
* Creates backup files whenever existing files are updated.
* Runs as user (example:pi) and uses 'root' whenever if needed.
* Installs 'collectd' and starts it.
* Adds the 'graphs-crontabjob.sh' script to crontab (scheduled every 5 minutes).
* A copy of the original crontab is saved.
* Creates graphs for the first time.
* Looks for other dump1090 hosts in /etc/hosts and /home/pi/dump-tools/collectd/hosts and adds them to /var/www/collectd/index.html.
* Changes the web server root into /var/www and restart the web server.
* The installer can be rerunned without any consequences. Previous configfiles will be saved in backup files.

Perform the following steps to install the dump-tools:
````
pi@ted1090-4 ~ $ cd /tmp
pi@ted1090-4 /tmp $ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090-tools-install.sh
pi@ted1090-4 /tmp $ chmod +x dump1090-tools-install.sh
pi@ted1090-4 /tmp $ ./dump1090-tools-install.sh

This script is launched by user pi.
==============INSTALL:[collectd]=================================
install ok installed 5.1.0-3
Collect install ok installed 5.1.0-3
etc........
````
   
Run the crontab scheduler when every you want to update your graphs manually:
````
sudo /home/pi/dump-tools/collectd/graphs-crontabjob.sh
````
    
Finished!

Watch the installation video:

[![dump-tools installation](https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/youtube-dump-tools.png)](http://www.youtube.com/watch?v=f9nL8gxL388)

## Testing and troubleshooting.

Give collectd at least few minutes to collect some data. Check whether the rrd files (the round robin databases with collection data) are updated:
````
pi@ted1090-4 ~/dump-tools/collectd $ ls -lR /var/lib/collectd/rrd/* | grep rrd
/var/lib/collectd/rrd/localhost:
/var/lib/collectd/rrd/localhost/df-root:
-rw-r--r-- 1 root root 154692 Jan 18 11:03 df_complex-free.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 df_complex-reserved.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 df_complex-used.rrd
/var/lib/collectd/rrd/localhost/disk-mmcblk0:
-rw-r--r-- 1 root root 307516 Jan 18 11:03 disk_merged.rrd
-rw-r--r-- 1 root root 307516 Jan 18 11:03 disk_octets.rrd
-rw-r--r-- 1 root root 307516 Jan 18 11:03 disk_ops.rrd
-rw-r--r-- 1 root root 307516 Jan 18 11:03 disk_time.rrd
/var/lib/collectd/rrd/localhost/dump1090-rpi:
-rw-r--r-- 1 root root 307516 Jan 18 11:03 dump1090_aircraft-recent.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_cpu-background.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_cpu-demod.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_cpu-reader.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_dbfs-peak_signal.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_dbfs-signal.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-local_accepted_0.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-local_accepted_1.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-local_accepted.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-positions.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-remote_accepted_0.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-remote_accepted_1.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-remote_accepted.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_messages-strong_signals.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_mlat-recent.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_range-max_range.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_tracks-all.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 dump1090_tracks-single_message.rrd
/var/lib/collectd/rrd/localhost/interface-eth0:
-rw-r--r-- 1 root root 307516 Jan 18 11:03 if_errors.rrd
-rw-r--r-- 1 root root 307516 Jan 18 11:03 if_octets.rrd
-rw-r--r-- 1 root root 307516 Jan 18 11:03 if_packets.rrd
/var/lib/collectd/rrd/localhost/memory:
-rw-r--r-- 1 root root 154692 Jan 18 11:03 memory-buffered.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 memory-cached.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 memory-free.rrd
-rw-r--r-- 1 root root 154692 Jan 18 11:03 memory-used.rrd
/var/lib/collectd/rrd/localhost/table-rpi:
-rw-r--r-- 1 root root 154692 Jan 18 11:03 gauge-cpu_temp.rrd
````
They should have been updated a minute ago. If not, check if the collectd deamon is running:
````
pi@ted1090-4 ~/dump-tools/collectd $ ps -ef | grep collectd
root      2255     1  0 Jan17 ?        00:00:00 /usr/sbin/collectdmon -P /var/run/collectdmon.pid -- -C /etc/collectd/collectd.conf
root      2257  2255  0 Jan17 ?        00:01:45 collectd -C /etc/collectd/collectd.conf -f
pi       32085  2366  0 11:11 pts/0    00:00:00 grep --color=auto collectd
````
Or check the '/var/log/collectd.log' and fix the error messages.

Run the 'graphs-crontabjob.sh' script from the '/home/pi/dump-tools/collectd/' directory and view the progress. It checks whether the graphs need to be updated:
````
pi@ted1090-4 ~/dump-tools/collectd $ ./graphs-crontabjob.sh
refresh       dump1090*1h.png   step=    8   expired=  -67   expired_after=  300
11654 (process ID) old priority 0, new priority 5
      Aircrafts - period=  1h - step=    8 - size=779x426
      CPU usage - period=  1h - step=    8 - size=779x398
         tracks - period=  1h - step=    8 - size=727x384
  Antenna range - period=  1h - step=    8 - size=727x384
   Signal power - period=  1h - step=    8 - size=727x384
       messages - period=  1h - step=    8 - size=779x412
     Network IO - period=  1h - step=    8 - size=727x412
   Memory usage - period=  1h - step=    8 - size=779x398
        Disk IO - period=  1h - step=    8 - size=779x440
refresh       dump1090*6h.png   step=   45   expired=  -68   expired_after=  300
11676 (process ID) old priority 0, new priority 5
      Aircrafts - period=  6h - step=   45 - size=779x426
      CPU usage - period=  6h - step=   45 - size=779x398
         tracks - period=  6h - step=   45 - size=727x384
  Antenna range - period=  6h - step=   45 - size=727x384
   Signal power - period=  6h - step=   45 - size=727x384
       messages - period=  6h - step=   45 - size=779x412
     Network IO - period=  6h - step=   45 - size=727x412
   Memory usage - period=  6h - step=   45 - size=779x398
        Disk IO - period=  6h - step=   45 - size=779x440
refresh      dump1090*24h.png   step=  180   expired= -163   expired_after=  600
11698 (process ID) old priority 0, new priority 5
      Aircrafts - period= 24h - step=  180 - size=779x426
      CPU usage - period= 24h - step=  180 - size=779x398
         tracks - period= 24h - step=  180 - size=727x384
  Antenna range - period= 24h - step=  180 - size=727x384
   Signal power - period= 24h - step=  180 - size=727x384
       messages - period= 24h - step=  180 - size=779x412
     Network IO - period= 24h - step=  180 - size=727x412
   Memory usage - period= 24h - step=  180 - size=779x398
        Disk IO - period= 24h - step=  180 - size=779x440
not expired   dump1090*2d.png   step=  360   expired=  436   expired_after= 1200
not expired   dump1090*3d.png   step=  540   expired= 1040   expired_after= 1800
not expired   dump1090*7d.png   step= 1260   expired= 2841   expired_after= 3600
not expired  dump1090*14d.png   step= 2520   expired= 6443   expired_after= 7200
not expired  dump1090*30d.png   step= 5400   expired= 4295   expired_after=14400
not expired  dump1090*90d.png   step=10800   expired= 4297   expired_after=14400
not expired dump1090*365d.png   step=86400   expired=18701   expired_after=28800
````

View the graphs in the '/var/www/collectd' directory:
````
pi@ted1090-4 ~/dump-tools/collectd $ ls -l /var/www/collectd/
total 3164
-rw-r--r-- 1 root root 48404 Jan 18 11:00 dump1090-rpi-acs-14d.png
-rw-r--r-- 1 root root 35932 Jan 18 11:00 dump1090-rpi-acs-1h.png
-rw-r--r-- 1 root root 53135 Jan 18 11:00 dump1090-rpi-acs-24h.png
-rw-r--r-- 1 root root 51464 Jan 18 10:45 dump1090-rpi-acs-2d.png
-rw-r--r-- 1 root root 51329 Jan 18 07:15 dump1090-rpi-acs-30d.png
-rw-r--r-- 1 root root 38323 Jan 18 06:20 dump1090-rpi-acs-365d.png
-rw-r--r-- 1 root root 50027 Jan 18 10:33 dump1090-rpi-acs-3d.png
-rw-r--r-- 1 root root 48066 Jan 18 11:00 dump1090-rpi-acs-6h.png
-rw-r--r-- 1 root root 51259 Jan 18 10:35 dump1090-rpi-acs-7d.png
-rw-r--r-- 1 root root 43213 Jan 18 10:52 dump1090-rpi-acs-90d.png
-rw-r--r-- 1 root root 27362 Jan 18 11:00 dump1090-rpi-cpu-14d.png
-rw-r--r-- 1 root root 22693 Jan 18 11:00 dump1090-rpi-cpu-1h.png
-rw-r--r-- 1 root root 27238 Jan 18 11:00 dump1090-rpi-cpu-24h.png
-rw-r--r-- 1 root root 28041 Jan 18 10:45 dump1090-rpi-cpu-2d.png
-rw-r--r-- 1 root root 28182 Jan 18 07:15 dump1090-rpi-cpu-30d.png
-rw-r--r-- 1 root root 28256 Jan 18 06:20 dump1090-rpi-cpu-365d.png
-rw-r--r-- 1 root root 27458 Jan 18 10:33 dump1090-rpi-cpu-3d.png
-rw-r--r-- 1 root root 25936 Jan 18 11:00 dump1090-rpi-cpu-6h.png
-rw-r--r-- 1 root root 27673 Jan 18 10:35 dump1090-rpi-cpu-7d.png
-rw-r--r-- 1 root root 28183 Jan 18 10:52 dump1090-rpi-cpu-90d.png
-rw-r--r-- 1 root root 27775 Jan 18 11:00 dump1090-rpi-disk-14d.png
-rw-r--r-- 1 root root 28056 Jan 18 11:00 dump1090-rpi-disk-1h.png
-rw-r--r-- 1 root root 34777 Jan 18 11:00 dump1090-rpi-disk-24h.png
-rw-r--r-- 1 root root 30565 Jan 18 10:45 dump1090-rpi-disk-2d.png
-rw-r--r-- 1 root root 29519 Jan 18 07:15 dump1090-rpi-disk-30d.png
-rw-r--r-- 1 root root 31059 Jan 18 06:20 dump1090-rpi-disk-365d.png
-rw-r--r-- 1 root root 32321 Jan 18 10:33 dump1090-rpi-disk-3d.png
-rw-r--r-- 1 root root 33888 Jan 18 11:00 dump1090-rpi-disk-6h.png
-rw-r--r-- 1 root root 29862 Jan 18 10:35 dump1090-rpi-disk-7d.png
-rw-r--r-- 1 root root 30846 Jan 18 10:52 dump1090-rpi-disk-90d.png
-rw-r--r-- 1 root root 35577 Jan 18 11:00 dump1090-rpi-eth0-14d.png
-rw-r--r-- 1 root root 26136 Jan 18 11:00 dump1090-rpi-eth0-1h.png
-rw-r--r-- 1 root root 34332 Jan 18 11:00 dump1090-rpi-eth0-24h.png
-rw-r--r-- 1 root root 36544 Jan 18 10:45 dump1090-rpi-eth0-2d.png
-rw-r--r-- 1 root root 38429 Jan 18 07:15 dump1090-rpi-eth0-30d.png
-rw-r--r-- 1 root root 32909 Jan 18 06:20 dump1090-rpi-eth0-365d.png
-rw-r--r-- 1 root root 36730 Jan 18 10:33 dump1090-rpi-eth0-3d.png
-rw-r--r-- 1 root root 32763 Jan 18 11:00 dump1090-rpi-eth0-6h.png
-rw-r--r-- 1 root root 37907 Jan 18 10:35 dump1090-rpi-eth0-7d.png
-rw-r--r-- 1 root root 38751 Jan 18 10:52 dump1090-rpi-eth0-90d.png
-rw-r--r-- 1 root root 34425 Jan 18 11:00 dump1090-rpi-memory-14d.png
-rw-r--r-- 1 root root 33536 Jan 18 11:00 dump1090-rpi-memory-1h.png
-rw-r--r-- 1 root root 35709 Jan 18 11:00 dump1090-rpi-memory-24h.png
-rw-r--r-- 1 root root 36824 Jan 18 10:45 dump1090-rpi-memory-2d.png
-rw-r--r-- 1 root root 35760 Jan 18 07:15 dump1090-rpi-memory-30d.png
-rw-r--r-- 1 root root 39115 Jan 18 06:20 dump1090-rpi-memory-365d.png
-rw-r--r-- 1 root root 36109 Jan 18 10:33 dump1090-rpi-memory-3d.png
-rw-r--r-- 1 root root 34861 Jan 18 11:00 dump1090-rpi-memory-6h.png
-rw-r--r-- 1 root root 35378 Jan 18 10:35 dump1090-rpi-memory-7d.png
-rw-r--r-- 1 root root 37299 Jan 18 10:52 dump1090-rpi-memory-90d.png
-rw-r--r-- 1 root root 20835 Jan 18 11:00 dump1090-rpi-range-14d.png
-rw-r--r-- 1 root root 22513 Jan 18 11:00 dump1090-rpi-range-1h.png
-rw-r--r-- 1 root root 24340 Jan 18 11:00 dump1090-rpi-range-24h.png
-rw-r--r-- 1 root root 23734 Jan 18 10:45 dump1090-rpi-range-2d.png
-rw-r--r-- 1 root root 21382 Jan 18 07:15 dump1090-rpi-range-30d.png
-rw-r--r-- 1 root root 20602 Jan 18 06:20 dump1090-rpi-range-365d.png
-rw-r--r-- 1 root root 21974 Jan 18 10:33 dump1090-rpi-range-3d.png
-rw-r--r-- 1 root root 27978 Jan 18 11:00 dump1090-rpi-range-6h.png
-rw-r--r-- 1 root root 22218 Jan 18 10:35 dump1090-rpi-range-7d.png
-rw-r--r-- 1 root root 20017 Jan 18 10:52 dump1090-rpi-range-90d.png
-rw-r--r-- 1 root root 47555 Jan 18 11:00 dump1090-rpi-rate-14d.png
-rw-r--r-- 1 root root 36459 Jan 18 11:00 dump1090-rpi-rate-1h.png
-rw-r--r-- 1 root root 48112 Jan 18 11:00 dump1090-rpi-rate-24h.png
-rw-r--r-- 1 root root 49170 Jan 18 10:45 dump1090-rpi-rate-2d.png
-rw-r--r-- 1 root root 50539 Jan 18 07:15 dump1090-rpi-rate-30d.png
-rw-r--r-- 1 root root 35644 Jan 18 06:20 dump1090-rpi-rate-365d.png
-rw-r--r-- 1 root root 48461 Jan 18 10:33 dump1090-rpi-rate-3d.png
-rw-r--r-- 1 root root 45526 Jan 18 11:00 dump1090-rpi-rate-6h.png
-rw-r--r-- 1 root root 50536 Jan 18 10:35 dump1090-rpi-rate-7d.png
-rw-r--r-- 1 root root 43101 Jan 18 10:52 dump1090-rpi-rate-90d.png
-rw-r--r-- 1 root root 24341 Jan 18 11:00 dump1090-rpi-signal-14d.png
-rw-r--r-- 1 root root 19636 Jan 18 11:00 dump1090-rpi-signal-1h.png
-rw-r--r-- 1 root root 29280 Jan 18 11:00 dump1090-rpi-signal-24h.png
-rw-r--r-- 1 root root 24081 Jan 18 10:45 dump1090-rpi-signal-2d.png
-rw-r--r-- 1 root root 25843 Jan 18 07:15 dump1090-rpi-signal-30d.png
-rw-r--r-- 1 root root 21653 Jan 18 06:20 dump1090-rpi-signal-365d.png
-rw-r--r-- 1 root root 22178 Jan 18 10:33 dump1090-rpi-signal-3d.png
-rw-r--r-- 1 root root 27046 Jan 18 11:00 dump1090-rpi-signal-6h.png
-rw-r--r-- 1 root root 25713 Jan 18 10:35 dump1090-rpi-signal-7d.png
-rw-r--r-- 1 root root 22922 Jan 18 10:52 dump1090-rpi-signal-90d.png
-rw-r--r-- 1 root root 26687 Jan 18 11:00 dump1090-rpi-tracks-14d.png
-rw-r--r-- 1 root root 19445 Jan 18 11:00 dump1090-rpi-tracks-1h.png
-rw-r--r-- 1 root root 21755 Jan 18 11:00 dump1090-rpi-tracks-24h.png
-rw-r--r-- 1 root root 24332 Jan 18 10:45 dump1090-rpi-tracks-2d.png
-rw-r--r-- 1 root root 27243 Jan 18 07:15 dump1090-rpi-tracks-30d.png
-rw-r--r-- 1 root root 21165 Jan 18 06:20 dump1090-rpi-tracks-365d.png
-rw-r--r-- 1 root root 24040 Jan 18 10:33 dump1090-rpi-tracks-3d.png
-rw-r--r-- 1 root root 24773 Jan 18 11:00 dump1090-rpi-tracks-6h.png
-rw-r--r-- 1 root root 23345 Jan 18 10:35 dump1090-rpi-tracks-7d.png
-rw-r--r-- 1 root root 24012 Jan 18 10:52 dump1090-rpi-tracks-90d.png
-rw-r--r-- 1 root root  3308 Oct  3 09:19 index.html
-rw-r--r-- 1 root root 95931 Apr 15  2015 jquery.js
````
View the graphs in a web browser: http://ip address your dump1090/collectd

## More info.

http://discussions.flightaware.com/post166863.html#p166863

http://forum.planefinder.net/threads/web-portal-and-collectd-rrd-graphs-automated-installation.256

https://collectd.org

http://oss.oetiker.ch/rrdtool

ted.sluis@gmail.com

https://www.youtube.com/watch?v=f9nL8gxL388
