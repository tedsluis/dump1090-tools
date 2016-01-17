# dump1090-tools for raspberry pi

Collects stats like:
* number of local & remote messages received per second.
* number of positions per hour.
* number of aircraft tracked with position, without position, with mlat.
* percantage aircraft traked with position.
* tracked with single position or unique tracked.
* main signal power and peak signal power.
* messages > -3 dBFS per hour.
* range i kilometers.
* cpu utalisation & temperature.
* disk & memory usage.
* disk IOPS & throughput.
* network interface IOPS & throughput.

<a href="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/week.png"
 target="_blank"><img src="https://dl.dropboxusercontent.com/u/17865731/dump1090-20150916/week.png"
alt="dump-tools week view" width="633" height="333" border="10" /></a>

Available graphs:
1 hour
6 hour
24 hour
7 days
14 days
30 days
90 days
365 days

# Installation collectd 
Install the collectd package:

sudo apt-get install -y collectd

# Installation files
Download the files to the following directories:

/etc/collectd/
            collectd.conf

/var/www/collectd/
            index.html
            jquery.js

/home/pi/dump-tools/collectd/
            dump1090.db
            dump1090.py
            graphs-crontabjob.sh
            make-graphs.sh

# set execute rights on scripts

sudo chmod 775 /home/pi/dump-tools/collectd/*.sh

# Start collection
Start the collection deamon:

sudo /etc/init.d/collectd restart

# Add entery to crontab
Create a crontab entery that will launch the script that creates the graphs.
The script takes care of the refresh frequency. Hourly graphs will be refreshed every 5 minutes.
Weekly en monthly graphs will only be refresh a few times a day.

*/5 * * * *              sudo /home/pi/dump-tools/collectd/graphs-crontabjob.sh > /dev/null

