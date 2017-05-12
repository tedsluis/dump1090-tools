# dump1090-tools for raspberry pi.
   
## Table of contents
   * [dump1090-tools for raspberry pi.](#dump1090-tools-for-raspberry-pi)
      * [Table of contents](#table-of-contents)
      * [Credits](#credits)
      * [Features](#features)
      * [Manual installation.](#manual-installation)
      * [Installation using installer.](#installation-using-installer)
      * [Modification when you use wireless instead of ethernet.](#modification-when-you-use-wireless-instead-of-ethernet)
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
  
* Dump1090 hosts bar, automatitly dynamicly created. Reads /etc/hosts and /home/pi/dump-tools/collectd/hosts and then adds or removes other dump1090 hosts to /var/www/collectd/index.html.
  
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/dump1090_hosts_bar.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/dump1090_hosts_bar.png"
alt="dump1090 hosts bar" /></a>  
Just run the [dump1090-tools-install.sh](https://github.com/tedsluis/dump1090-tools/blob/master/dump1090-tools-install.sh) or [insert_hosts.sh](https://github.com/tedsluis/dump1090-tools/blob/master/insert_hosts.sh).
````
192.168.11.80  msi msi -----> 192.168.11.80, msi, dump=000, collectd=000, No dump1090 or collectd hosts...
192.168.11.38  nasted -----> 192.168.11.38, nasted, dump=404, collectd=404, No dump1090 or collectd hosts...
192.168.11.100 nuc -----> 192.168.11.100, nuc, dump=000, collectd=000, No dump1090 or collectd hosts...
192.168.11.27  pavilion -----> 192.168.11.27, pavilion, dump=000, collectd=000, No dump1090 or collectd hosts...
192.168.11.172 ted1090-1 -----> 192.168.11.172, ted1090-1, dump=200, collectd=200, ted1090-1 (192.168.11.172) were reconfigured /home/pi/dump-tools/collectd/hosts.
192.168.11.176 ted1090-2 -----> 192.168.11.176, ted1090-2, dump=200, collectd=200, ted1090-2 (192.168.11.176) were reconfigured /home/pi/dump-tools/collectd/hosts.
192.168.11.171 ted1090-3 -----> 192.168.11.171, ted1090-3, dump=200, collectd=200, ted1090-3 (192.168.11.171) were reconfigured /home/pi/dump-tools/collectd/hosts.
192.168.11.178 ted1090-4 -----> 192.168.11.178, ted1090-4, dump=200, collectd=200, ted1090-4 (192.168.11.178) were reconfigured /home/pi/dump-tools/collectd/hosts.
192.168.11.174 ted1090-5 -----> 192.168.11.174, ted1090-5, dump=200, collectd=200, ted1090-5 (192.168.11.174) were reconfigured /home/pi/dump-tools/collectd/hosts.
192.168.11.175 ted1090-6 -----> 192.168.11.175, ted1090-6, dump=200, collectd=200, ted1090-6 (192.168.11.175) were reconfigured /home/pi/dump-tools/collectd/hosts.
192.168.11.177 ted1090-7 -----> 192.168.11.177, ted1090-7, dump=200, collectd=200, ted1090-7 (192.168.11.177) were reconfigured /home/pi/dump-tools/collectd/hosts.
192.168.11.1   WRT-bachstraat20 -----> 192.168.11.1, WRT-bachstraat20, dump=404, collectd=404, No dump1090 or collectd hosts...
````
  
* Display a 'no data' image when there is no RRD file.  
  
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/nodata.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/nodata.png"
alt="No data" /></a>
  
* Automatic scaling graphs in the web web browser.   
   
* Lightbox intergration: Zoom into graph (by osmanovv)  
  
<a href="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/lightboxview.png"
 target="_blank"><img src="https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/img/lightboxview.png"
alt="Lightbox view" /></a>
 
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
* lightbox.min.js 
* lightbox.min.css

/home/pi/dump-tools/collectd/
* dump1090.db
* dump1090.py
* graphs-crontabjob.sh
* make-graphs.sh
* insert_hosts.sh
````
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/collectd.conf    -O /etc/collectd/collectd.conf
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/index.html       -O /var/www/collectd/index.html
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/default.css      -O /var/www/collectd/default.css
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/jquery.js        -O /var/www/collectd/jquery.js
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/lightbox.min.js  -O /var/www/collectd/lightbox.min.js 
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/lightbox.min.css -O /var/www/collectd/lightbox.min.css
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090.db           -O /home/pi/dump-tools/collectd/dump1090.db
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090.py           -O /home/pi/dump-tools/collectd/dump1090.py
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/graphs-crontabjob.sh  -O /home/pi/dump-tools/collectd/graphs-crontabjob.sh
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/make-graphs.sh        -O /home/pi/dump-tools/collectd/make-graphs.sh
$ wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/insert_hosts.sh       -O /home/pi/dump-tools/collectd/insert_hosts.sh
````

Set execute permission on scripts:
````
$ sudo chmod 775 /home/pi/dump-tools/collectd/*.sh
````
Start the collection deamon:
````
$ sudo /etc/init.d/collectd restart
````
Look for other dump1090 hosts in /etc/hosts and /home/pi/dump-tool/collectd/hosts and add them to /var/www/collectd/index.html:
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
  
## Modification when you use wireless instead of ethernet.  
  
When you use wlan (wireless internet) everythings works exept the network interface. Therefor you have to make some changes, which means basicly that you have to replace the name of the ethernet interface "eth0" to the name of the wireless interface "wlan0" in a couple of files and then restart the collectd daemon. It is very easy to acomplish using the following commands:

````
pi@ted1090-4 ~ $ sudo sed -i "s/eth0/wlan0/g" /home/pi/dump-tools/collectd/make-graphs.sh
pi@ted1090-4 ~ $ sudo sed -i "s/eth0/wlan0/g" /var/www/collectd/index.html 
pi@ted1090-4 ~ $ sudo sed -i "s/eth0/wlan0/g" /etc/collectd/collectd.conf
pi@ted1090-4 ~ $ sudo /etc/init.d/collectd restart
````
After a while the wlan0 statistics will show up...

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
not expired   dump1090*1h.png   step=    8   expired=  160   expired_after=  300
not expired   dump1090*6h.png   step=   45   expired=  169   expired_after=  300
not expired  dump1090*24h.png   step=  180   expired=  478   expired_after=  600
not expired   dump1090*2d.png   step=  360   expired=  170   expired_after= 1200
not expired   dump1090*3d.png   step=  540   expired=  161   expired_after= 1800
refresh       dump1090*7d.png   step= 1260   expired=  -95   expired_after= 3600
4430 (process ID) old priority 0, new priority 5
      Aircrafts - period=  7d - step= 1260 - size=1349x894
      CPU usage - period=  7d - step= 1260 - size=1349x866
         tracks - period=  7d - step= 1260 - size=1297x852
  Antenna range - period=  7d - step= 1260 - size=1297x852
   Signal power - period=  7d - step= 1260 - size=1297x852
       messages - period=  7d - step= 1260 - size=1349x880
     Network IO - period=  7d - step= 1260 - size=1297x880
   Memory usage - period=  7d - step= 1260 - size=1349x866
        Disk IO - period=  7d - step= 1260 - size=1349x908
      Aircrafts - period=  7d - step= 1260 - size=779x426
      CPU usage - period=  7d - step= 1260 - size=779x398
         tracks - period=  7d - step= 1260 - size=727x384
  Antenna range - period=  7d - step= 1260 - size=727x384
   Signal power - period=  7d - step= 1260 - size=727x384
       messages - period=  7d - step= 1260 - size=779x412
     Network IO - period=  7d - step= 1260 - size=727x412
   Memory usage - period=  7d - step= 1260 - size=779x398
        Disk IO - period=  7d - step= 1260 - size=779x440
not expired  dump1090*14d.png   step= 2520   expired= 3504   expired_after= 7200
not expired  dump1090*30d.png   step= 5400   expired=10712   expired_after=14400
not expired  dump1090*90d.png   step=10800   expired=10722   expired_after=14400
not expired dump1090*365d.png   step=86400   expired=25130   expired_after=28800
````

View the graphs in the '/var/www/collectd' directory:
````
pi@ted1090-4 ~/dump-tools/collectd $ ls -l /var/www/collectd/
total 9304
-rw-r--r-- 1 root root   3123 Dec 26 11:18 default.css
-rw-r--r-- 1 root root  96960 Mar 24 10:35 dump1090-rpi-acs-14d.png
-rw-r--r-- 1 root root  56624 Mar 24 11:35 dump1090-rpi-acs-1h.png
-rw-r--r-- 1 root root  91238 Mar 24 11:35 dump1090-rpi-acs-24h.png
-rw-r--r-- 1 root root  90656 Mar 24 11:20 dump1090-rpi-acs-2d.png
-rw-r--r-- 1 root root  89046 Mar 24 10:36 dump1090-rpi-acs-30d.png
-rw-r--r-- 1 root root  65386 Mar 24 10:36 dump1090-rpi-acs-365d.png
-rw-r--r-- 1 root root  85658 Mar 24 11:10 dump1090-rpi-acs-3d.png
-rw-r--r-- 1 root root  85331 Mar 24 11:35 dump1090-rpi-acs-6h.png
-rw-r--r-- 1 root root 105883 Mar 24 10:35 dump1090-rpi-acs-7d.png
-rw-r--r-- 1 root root  99576 Mar 24 10:36 dump1090-rpi-acs-90d.png
-rw-r--r-- 1 root root  50340 Mar 24 10:36 dump1090-rpi-acs-preview-14d.png
-rw-r--r-- 1 root root  35373 Mar 24 11:35 dump1090-rpi-acs-preview-1h.png
-rw-r--r-- 1 root root  54867 Mar 24 11:20 dump1090-rpi-acs-preview-24h.png
-rw-r--r-- 1 root root  52236 Mar 24 11:20 dump1090-rpi-acs-preview-2d.png
-rw-r--r-- 1 root root  51570 Mar 24 10:36 dump1090-rpi-acs-preview-30d.png
-rw-r--r-- 1 root root  41365 Mar 24 10:36 dump1090-rpi-acs-preview-365d.png
-rw-r--r-- 1 root root  49699 Mar 24 11:10 dump1090-rpi-acs-preview-3d.png
-rw-r--r-- 1 root root  47554 Mar 24 11:35 dump1090-rpi-acs-preview-6h.png
-rw-r--r-- 1 root root  51100 Mar 24 10:35 dump1090-rpi-acs-preview-7d.png
-rw-r--r-- 1 root root  49809 Mar 24 10:36 dump1090-rpi-acs-preview-90d.png
-rw-r--r-- 1 root root  64999 Mar 24 10:35 dump1090-rpi-cpu-14d.png
-rw-r--r-- 1 root root  53121 Mar 24 11:35 dump1090-rpi-cpu-1h.png
-rw-r--r-- 1 root root  57225 Mar 24 11:35 dump1090-rpi-cpu-24h.png
-rw-r--r-- 1 root root  58608 Mar 24 11:20 dump1090-rpi-cpu-2d.png
-rw-r--r-- 1 root root  53090 Mar 24 10:36 dump1090-rpi-cpu-30d.png
-rw-r--r-- 1 root root  59750 Mar 24 10:36 dump1090-rpi-cpu-365d.png
-rw-r--r-- 1 root root  56010 Mar 24 11:10 dump1090-rpi-cpu-3d.png
-rw-r--r-- 1 root root  68297 Mar 24 11:35 dump1090-rpi-cpu-6h.png
-rw-r--r-- 1 root root  65539 Mar 24 10:35 dump1090-rpi-cpu-7d.png
-rw-r--r-- 1 root root  65368 Mar 24 10:36 dump1090-rpi-cpu-90d.png
-rw-r--r-- 1 root root  23983 Mar 24 10:36 dump1090-rpi-cpu-preview-14d.png
-rw-r--r-- 1 root root  22517 Mar 24 11:35 dump1090-rpi-cpu-preview-1h.png
-rw-r--r-- 1 root root  25290 Mar 24 11:20 dump1090-rpi-cpu-preview-24h.png
-rw-r--r-- 1 root root  25108 Mar 24 11:20 dump1090-rpi-cpu-preview-2d.png
-rw-r--r-- 1 root root  24781 Mar 24 10:36 dump1090-rpi-cpu-preview-30d.png
-rw-r--r-- 1 root root  26847 Mar 24 10:36 dump1090-rpi-cpu-preview-365d.png
-rw-r--r-- 1 root root  24006 Mar 24 11:10 dump1090-rpi-cpu-preview-3d.png
-rw-r--r-- 1 root root  25847 Mar 24 11:35 dump1090-rpi-cpu-preview-6h.png
-rw-r--r-- 1 root root  24150 Mar 24 10:35 dump1090-rpi-cpu-preview-7d.png
-rw-r--r-- 1 root root  25953 Mar 24 10:36 dump1090-rpi-cpu-preview-90d.png
-rw-r--r-- 1 root root  76677 Mar 24 10:36 dump1090-rpi-disk-14d.png
-rw-r--r-- 1 root root  61411 Mar 24 11:35 dump1090-rpi-disk-1h.png
-rw-r--r-- 1 root root  59455 Mar 24 11:35 dump1090-rpi-disk-24h.png
-rw-r--r-- 1 root root  73206 Mar 24 11:20 dump1090-rpi-disk-2d.png
-rw-r--r-- 1 root root  61435 Mar 24 10:36 dump1090-rpi-disk-30d.png
-rw-r--r-- 1 root root  68048 Mar 24 10:36 dump1090-rpi-disk-365d.png
-rw-r--r-- 1 root root  63981 Mar 24 11:10 dump1090-rpi-disk-3d.png
-rw-r--r-- 1 root root  71367 Mar 24 11:35 dump1090-rpi-disk-6h.png
-rw-r--r-- 1 root root  67285 Mar 24 10:35 dump1090-rpi-disk-7d.png
-rw-r--r-- 1 root root  75625 Mar 24 10:36 dump1090-rpi-disk-90d.png
-rw-r--r-- 1 root root  30365 Mar 24 10:36 dump1090-rpi-disk-preview-14d.png
-rw-r--r-- 1 root root  27509 Mar 24 11:35 dump1090-rpi-disk-preview-1h.png
-rw-r--r-- 1 root root  36168 Mar 24 11:20 dump1090-rpi-disk-preview-24h.png
-rw-r--r-- 1 root root  33306 Mar 24 11:20 dump1090-rpi-disk-preview-2d.png
-rw-r--r-- 1 root root  29602 Mar 24 10:36 dump1090-rpi-disk-preview-30d.png
-rw-r--r-- 1 root root  37207 Mar 24 10:36 dump1090-rpi-disk-preview-365d.png
-rw-r--r-- 1 root root  30434 Mar 24 11:10 dump1090-rpi-disk-preview-3d.png
-rw-r--r-- 1 root root  35044 Mar 24 11:35 dump1090-rpi-disk-preview-6h.png
-rw-r--r-- 1 root root  31895 Mar 24 10:35 dump1090-rpi-disk-preview-7d.png
-rw-r--r-- 1 root root  32330 Mar 24 10:36 dump1090-rpi-disk-preview-90d.png
-rw-r--r-- 1 root root  83790 Mar 24 10:35 dump1090-rpi-eth0-14d.png
-rw-r--r-- 1 root root  48592 Mar 24 11:35 dump1090-rpi-eth0-1h.png
-rw-r--r-- 1 root root  67149 Mar 24 11:35 dump1090-rpi-eth0-24h.png
-rw-r--r-- 1 root root  66620 Mar 24 11:20 dump1090-rpi-eth0-2d.png
-rw-r--r-- 1 root root  70532 Mar 24 10:36 dump1090-rpi-eth0-30d.png
-rw-r--r-- 1 root root  56880 Mar 24 10:36 dump1090-rpi-eth0-365d.png
-rw-r--r-- 1 root root  64867 Mar 24 11:10 dump1090-rpi-eth0-3d.png
-rw-r--r-- 1 root root  65192 Mar 24 11:35 dump1090-rpi-eth0-6h.png
-rw-r--r-- 1 root root  82617 Mar 24 10:35 dump1090-rpi-eth0-7d.png
-rw-r--r-- 1 root root  78643 Mar 24 10:36 dump1090-rpi-eth0-90d.png
-rw-r--r-- 1 root root  32954 Mar 24 10:36 dump1090-rpi-eth0-preview-14d.png
-rw-r--r-- 1 root root  23686 Mar 24 11:35 dump1090-rpi-eth0-preview-1h.png
-rw-r--r-- 1 root root  31841 Mar 24 11:20 dump1090-rpi-eth0-preview-24h.png
-rw-r--r-- 1 root root  32870 Mar 24 11:20 dump1090-rpi-eth0-preview-2d.png
-rw-r--r-- 1 root root  34752 Mar 24 10:36 dump1090-rpi-eth0-preview-30d.png
-rw-r--r-- 1 root root  28779 Mar 24 10:36 dump1090-rpi-eth0-preview-365d.png
-rw-r--r-- 1 root root  31581 Mar 24 11:10 dump1090-rpi-eth0-preview-3d.png
-rw-r--r-- 1 root root  27973 Mar 24 11:35 dump1090-rpi-eth0-preview-6h.png
-rw-r--r-- 1 root root  31997 Mar 24 10:35 dump1090-rpi-eth0-preview-7d.png
-rw-r--r-- 1 root root  31716 Mar 24 10:36 dump1090-rpi-eth0-preview-90d.png
-rw-r--r-- 1 root root  65606 Mar 24 10:36 dump1090-rpi-memory-14d.png
-rw-r--r-- 1 root root  54555 Mar 24 11:35 dump1090-rpi-memory-1h.png
-rw-r--r-- 1 root root  54485 Mar 24 11:35 dump1090-rpi-memory-24h.png
-rw-r--r-- 1 root root  58020 Mar 24 11:20 dump1090-rpi-memory-2d.png
-rw-r--r-- 1 root root  54564 Mar 24 10:36 dump1090-rpi-memory-30d.png
-rw-r--r-- 1 root root  61781 Mar 24 10:36 dump1090-rpi-memory-365d.png
-rw-r--r-- 1 root root  55741 Mar 24 11:10 dump1090-rpi-memory-3d.png
-rw-r--r-- 1 root root  65254 Mar 24 11:35 dump1090-rpi-memory-6h.png
-rw-r--r-- 1 root root  64916 Mar 24 10:35 dump1090-rpi-memory-7d.png
-rw-r--r-- 1 root root  67930 Mar 24 10:36 dump1090-rpi-memory-90d.png
-rw-r--r-- 1 root root  23746 Mar 24 10:36 dump1090-rpi-memory-preview-14d.png
-rw-r--r-- 1 root root  22960 Mar 24 11:35 dump1090-rpi-memory-preview-1h.png
-rw-r--r-- 1 root root  24884 Mar 24 11:20 dump1090-rpi-memory-preview-24h.png
-rw-r--r-- 1 root root  25377 Mar 24 11:20 dump1090-rpi-memory-preview-2d.png
-rw-r--r-- 1 root root  24832 Mar 24 10:36 dump1090-rpi-memory-preview-30d.png
-rw-r--r-- 1 root root  28702 Mar 24 10:36 dump1090-rpi-memory-preview-365d.png
-rw-r--r-- 1 root root  24646 Mar 24 11:10 dump1090-rpi-memory-preview-3d.png
-rw-r--r-- 1 root root  24238 Mar 24 11:35 dump1090-rpi-memory-preview-6h.png
-rw-r--r-- 1 root root  24098 Mar 24 10:35 dump1090-rpi-memory-preview-7d.png
-rw-r--r-- 1 root root  26450 Mar 24 10:36 dump1090-rpi-memory-preview-90d.png
-rw-r--r-- 1 root root  63535 Mar 24 10:35 dump1090-rpi-range-14d.png
-rw-r--r-- 1 root root  44957 Mar 24 11:35 dump1090-rpi-range-1h.png
-rw-r--r-- 1 root root  57116 Mar 24 11:35 dump1090-rpi-range-24h.png
-rw-r--r-- 1 root root  56961 Mar 24 11:20 dump1090-rpi-range-2d.png
-rw-r--r-- 1 root root  52478 Mar 24 10:36 dump1090-rpi-range-30d.png
-rw-r--r-- 1 root root  52039 Mar 24 10:36 dump1090-rpi-range-365d.png
-rw-r--r-- 1 root root  51830 Mar 24 11:10 dump1090-rpi-range-3d.png
-rw-r--r-- 1 root root  60483 Mar 24 11:35 dump1090-rpi-range-6h.png
-rw-r--r-- 1 root root  65759 Mar 24 10:35 dump1090-rpi-range-7d.png
-rw-r--r-- 1 root root  60594 Mar 24 10:36 dump1090-rpi-range-90d.png
-rw-r--r-- 1 root root  20640 Mar 24 10:36 dump1090-rpi-range-preview-14d.png
-rw-r--r-- 1 root root  22753 Mar 24 11:35 dump1090-rpi-range-preview-1h.png
-rw-r--r-- 1 root root  30085 Mar 24 11:20 dump1090-rpi-range-preview-24h.png
-rw-r--r-- 1 root root  28732 Mar 24 11:20 dump1090-rpi-range-preview-2d.png
-rw-r--r-- 1 root root  21714 Mar 24 10:36 dump1090-rpi-range-preview-30d.png
-rw-r--r-- 1 root root  21095 Mar 24 10:36 dump1090-rpi-range-preview-365d.png
-rw-r--r-- 1 root root  26899 Mar 24 11:10 dump1090-rpi-range-preview-3d.png
-rw-r--r-- 1 root root  27738 Mar 24 11:35 dump1090-rpi-range-preview-6h.png
-rw-r--r-- 1 root root  21770 Mar 24 10:35 dump1090-rpi-range-preview-7d.png
-rw-r--r-- 1 root root  20578 Mar 24 10:36 dump1090-rpi-range-preview-90d.png
-rw-r--r-- 1 root root  73895 Mar 24 10:35 dump1090-rpi-rate-14d.png
-rw-r--r-- 1 root root  47906 Mar 24 11:35 dump1090-rpi-rate-1h.png
-rw-r--r-- 1 root root  64609 Mar 24 11:35 dump1090-rpi-rate-24h.png
-rw-r--r-- 1 root root  66845 Mar 24 11:20 dump1090-rpi-rate-2d.png
-rw-r--r-- 1 root root  65399 Mar 24 10:36 dump1090-rpi-rate-30d.png
-rw-r--r-- 1 root root  55751 Mar 24 10:36 dump1090-rpi-rate-365d.png
-rw-r--r-- 1 root root  62085 Mar 24 11:10 dump1090-rpi-rate-3d.png
-rw-r--r-- 1 root root  63894 Mar 24 11:35 dump1090-rpi-rate-6h.png
-rw-r--r-- 1 root root  74238 Mar 24 10:35 dump1090-rpi-rate-7d.png
-rw-r--r-- 1 root root  76990 Mar 24 10:36 dump1090-rpi-rate-90d.png
-rw-r--r-- 1 root root  40624 Mar 24 10:36 dump1090-rpi-rate-preview-14d.png
-rw-r--r-- 1 root root  31695 Mar 24 11:35 dump1090-rpi-rate-preview-1h.png
-rw-r--r-- 1 root root  41263 Mar 24 11:20 dump1090-rpi-rate-preview-24h.png
-rw-r--r-- 1 root root  41195 Mar 24 11:20 dump1090-rpi-rate-preview-2d.png
-rw-r--r-- 1 root root  42405 Mar 24 10:36 dump1090-rpi-rate-preview-30d.png
-rw-r--r-- 1 root root  36460 Mar 24 10:36 dump1090-rpi-rate-preview-365d.png
-rw-r--r-- 1 root root  39658 Mar 24 11:10 dump1090-rpi-rate-preview-3d.png
-rw-r--r-- 1 root root  37993 Mar 24 11:35 dump1090-rpi-rate-preview-6h.png
-rw-r--r-- 1 root root  41788 Mar 24 10:35 dump1090-rpi-rate-preview-7d.png
-rw-r--r-- 1 root root  40963 Mar 24 10:36 dump1090-rpi-rate-preview-90d.png
-rw-r--r-- 1 root root  65510 Mar 24 10:35 dump1090-rpi-signal-14d.png
-rw-r--r-- 1 root root  59055 Mar 24 11:35 dump1090-rpi-signal-1h.png
-rw-r--r-- 1 root root  96363 Mar 24 11:35 dump1090-rpi-signal-24h.png
-rw-r--r-- 1 root root  73198 Mar 24 11:20 dump1090-rpi-signal-2d.png
-rw-r--r-- 1 root root  57860 Mar 24 10:36 dump1090-rpi-signal-30d.png
-rw-r--r-- 1 root root  58400 Mar 24 10:36 dump1090-rpi-signal-365d.png
-rw-r--r-- 1 root root  76480 Mar 24 11:10 dump1090-rpi-signal-3d.png
-rw-r--r-- 1 root root  86871 Mar 24 11:35 dump1090-rpi-signal-6h.png
-rw-r--r-- 1 root root  93493 Mar 24 10:35 dump1090-rpi-signal-7d.png
-rw-r--r-- 1 root root  61851 Mar 24 10:36 dump1090-rpi-signal-90d.png
-rw-r--r-- 1 root root  20796 Mar 24 10:36 dump1090-rpi-signal-preview-14d.png
-rw-r--r-- 1 root root  20843 Mar 24 11:35 dump1090-rpi-signal-preview-1h.png
-rw-r--r-- 1 root root  32717 Mar 24 11:20 dump1090-rpi-signal-preview-24h.png
-rw-r--r-- 1 root root  25033 Mar 24 11:20 dump1090-rpi-signal-preview-2d.png
-rw-r--r-- 1 root root  22047 Mar 24 10:36 dump1090-rpi-signal-preview-30d.png
-rw-r--r-- 1 root root  22599 Mar 24 10:36 dump1090-rpi-signal-preview-365d.png
-rw-r--r-- 1 root root  25859 Mar 24 11:10 dump1090-rpi-signal-preview-3d.png
-rw-r--r-- 1 root root  27788 Mar 24 11:35 dump1090-rpi-signal-preview-6h.png
-rw-r--r-- 1 root root  29725 Mar 24 10:35 dump1090-rpi-signal-preview-7d.png
-rw-r--r-- 1 root root  20927 Mar 24 10:36 dump1090-rpi-signal-preview-90d.png
-rw-r--r-- 1 root root  73462 Mar 24 10:35 dump1090-rpi-tracks-14d.png
-rw-r--r-- 1 root root  39112 Mar 24 11:35 dump1090-rpi-tracks-1h.png
-rw-r--r-- 1 root root  48992 Mar 24 11:35 dump1090-rpi-tracks-24h.png
-rw-r--r-- 1 root root  47114 Mar 24 11:20 dump1090-rpi-tracks-2d.png
-rw-r--r-- 1 root root  62201 Mar 24 10:36 dump1090-rpi-tracks-30d.png
-rw-r--r-- 1 root root  56708 Mar 24 10:36 dump1090-rpi-tracks-365d.png
-rw-r--r-- 1 root root  69972 Mar 24 11:10 dump1090-rpi-tracks-3d.png
-rw-r--r-- 1 root root  52516 Mar 24 11:35 dump1090-rpi-tracks-6h.png
-rw-r--r-- 1 root root  48192 Mar 24 10:35 dump1090-rpi-tracks-7d.png
-rw-r--r-- 1 root root  72566 Mar 24 10:36 dump1090-rpi-tracks-90d.png
-rw-r--r-- 1 root root  24956 Mar 24 10:36 dump1090-rpi-tracks-preview-14d.png
-rw-r--r-- 1 root root  20231 Mar 24 11:35 dump1090-rpi-tracks-preview-1h.png
-rw-r--r-- 1 root root  26893 Mar 24 11:20 dump1090-rpi-tracks-preview-24h.png
-rw-r--r-- 1 root root  25050 Mar 24 11:20 dump1090-rpi-tracks-preview-2d.png
-rw-r--r-- 1 root root  25410 Mar 24 10:36 dump1090-rpi-tracks-preview-30d.png
-rw-r--r-- 1 root root  21848 Mar 24 10:36 dump1090-rpi-tracks-preview-365d.png
-rw-r--r-- 1 root root  24349 Mar 24 11:10 dump1090-rpi-tracks-preview-3d.png
-rw-r--r-- 1 root root  25331 Mar 24 11:35 dump1090-rpi-tracks-preview-6h.png
-rw-r--r-- 1 root root  23558 Mar 24 10:35 dump1090-rpi-tracks-preview-7d.png
-rw-r--r-- 1 root root  24230 Mar 24 10:36 dump1090-rpi-tracks-preview-90d.png
drwxr-xr-x 2 root root   4096 Dec 18 14:44 image
-rw-r--r-- 1 root root   8932 Mar 24 07:13 index.html
-rw-r--r-- 1 root root  95931 Dec 26 11:18 jquery.js
-rw-r--r-- 1 root root   2847 Mar 24 10:57 lightbox.min.css
-rw-r--r-- 1 root root   9372 Mar 24 06:58 lightbox.min.js
-rw-r--r-- 1 root root  19944 Mar 24 07:01 nodata.png
````
View the graphs in a web browser: http://ip address your dump1090/collectd

## More info.

http://discussions.flightaware.com/post166863.html#p166863

http://forum.planefinder.net/threads/web-portal-and-collectd-rrd-graphs-automated-installation.256

https://collectd.org

http://oss.oetiker.ch/rrdtool

ted.sluis@gmail.com

https://www.youtube.com/watch?v=f9nL8gxL388
