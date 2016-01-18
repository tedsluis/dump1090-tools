# dump1090-tools for raspberry pi

Monitors Dump1090 Mutability running on raspberry pi (raspbian & piaware).

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/week.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/week.png"
alt="dump-tools week view" width="633" height="333" border="10" /></a>

Based on https://github.com/mutability/dump1090-tools by Oliver Jowett <oliver@mutability.co.uk> and Xforce30164.

Collects stats like:
* number of local & remote messages received per second.
* number of positions per hour.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/message_rate.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/message_rate.png"
alt="dump-tools message rate" width="633" height="333" border="10" /></a>

* number of aircraft tracked with position, without position, with mlat.
* percantage aircraft traked with position.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/aircraftseen.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/aircraftseen.png"
alt="dump-tools aircraft seen" width="633" height="333" border="10" /></a>

* tracked with single position or unique tracked.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/tracksseen.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/tracksseen.png"
alt="dump-tools tracks seen" width="633" height="333" border="10" /></a>

* main signal power and peak signal power.
* messages > -3 dBFS per hour.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/signal.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/signal.png"
alt="dump-tools signal power" width="633" height="333" border="10" /></a>

* range in kilometers.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/range.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/range.png"
alt="dump-tools range view" width="633" height="333" border="10" /></a>

* cpu utalisation & temperature.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/cpu.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/cpu.png"
alt="dump-tools cpu utilisation and temperature" width="633" height="333" border="10" /></a>

* disk & memory usage.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/space.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/space.png"
alt="dump-tools disk and memory usage" width="633" height="333" border="10" /></a>

* disk IOPS & throughput.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/disk.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/disk.png"
alt="dump-tools disk bandwidth" width="633" height="333" border="10" /></a>

* network interface IOPS & throughput.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/network.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/network.png"
alt="dump-tools network bandwidth" width="633" height="333" border="10" /></a>

Available graphs:
1 hour, 6 hour, 24 hour, 7 days, 14 days, 30 days, 90 days, 365 days

# Manual installation 

Install the collectd package:
````
$ sudo apt-get install -y collectd
````
Download the files and copy them to the following directories:

/etc/collectd/
* collectd.conf

/var/www/collectd/
* index.html
* jquery.js

/home/pi/dump-tools/collectd/
* dump1090.db
* dump1090.py
* graphs-crontabjob.sh
* make-graphs.sh

````
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/collectd.conf   -O /etc/collectd/collectd.conf
$ sudo wget https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/index.html      -O /var/www/collectd/index.html
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
Create a crontab entery that will launch the script that creates the graphs.
The script takes care of the refresh frequency. The hourly graphs will be refreshed every 5 minutes.
Weekly en monthly graphs will only be refresh a few times a day.

$ sudo crontab -e
````
*/5 * * * *              sudo /home/pi/dump-tools/collectd/graphs-crontabjob.sh > /dev/null
````
# More info

http://discussions.flightaware.com/post166863.html#p166863

http://forum.planefinder.net/threads/web-portal-and-collectd-rrd-graphs-automated-installation.256

https://collectd.org

http://oss.oetiker.ch/rrdtool

ted.sluis@gmail.com
