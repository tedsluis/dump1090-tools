#!/bin/bash

# ted.sluis@gmail.com
# Inserts other dump1090 hosts into /var/www/collectd/index.html
# Reads /etc/hosts and looks for dump1090 hosts.
# You can also add dump1090 hosts to /home/pi/dump-tools/collectd/hosts.

# Create /home/pi/dump-tools/collectd/hosts if not exists.
if [ -f $FILE ]; then
	touch /home/pi/dump-tools/collectd/hosts
fi

# Look in /etc/hosts for hosts running dump1090 and collectd
while read LINE; do
	IPADDRESS=$(echo $LINE | awk '{ print $1 }')
	HOSTNAME=$(echo   $LINE | awk '{ print $2 }')
	echo -n "$LINE -----> $IPADDRESS, $HOSTNAME"
	# Prevent localhost to be added
	if [[ $IPADDRESS =~ 127.0.0.1 || $HOSTNAME =~ localhost ]]; then
		echo "Skip localhost..."
	# check for valid IP addresses
	elif [[ $IPADDRESS =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
		# Get HTTP Status code for URL's /dump1090 and /collectd
		HTTPSTATUSDUMP=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://${HOSTNAME}/dump1090/gmap.html)
		HTTPSTATUSCOLLECTD=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://${HOSTNAME}/collectd/)
		echo -n ", dump=$HTTPSTATUSDUMP, collectd=$HTTPSTATUSCOLLECTD"
		# Check for HTTP status code 200
		if [[ $HTTPSTATUSDUMP == 200 || $HTTPSTATUSCOLLECTD == 200 ]]; then
			# Check if this hostname and ip address are already in the /home/pi/dump-tools/collectd/hosts file
			if grep -Fq "$IPADDRESS" /home/pi/dump-tools/collectd/hosts &&  grep -Fq "$HOSTNAME" /home/pi/dump-tools/collectd/hosts ; then
				echo ", $HOSTNAME ($IPADDRESS) is already in /home/pi/dump-tools/collectd/hosts."
			# Check if this hostname or ip address are already in the /home/pi/dump-tools/collectd/hosts file
			elif grep -Fq "$IPADDRESS" /home/pi/dump-tools/collectd/hosts || grep -Fq "$HOSTNAME" /home/pi/dump-tools/collectd/hosts ; then
				echo ", $HOSTNAME ($IPADDRESS) were reconfigured /home/pi/dump-tools/collectd/hosts."
				sed -i "/$IPADDRESS/d"  /home/pi/dump-tools/collectd/hosts
				sed -i "/$HOSTNAME/d" /home/pi/dump-tools/collectd/hosts
				echo "$HOSTNAME $IPADDRESS" >> /home/pi/dump-tools/collectd/hosts
			else
				echo ", $HOSTNAME ($IPADDRESS) is added to /home/pi/dump-tools/collectd/hosts."
				echo "$HOSTNAME $IPADDRESS" >> /home/pi/dump-tools/collectd/hosts
			fi
		else 
			echo ", No dump1090 or collectd hosts..."
		fi
	else
		echo ", NO VALID IP"
	fi
done < <(grep -v 127.0.0.1 /etc/hosts | grep -P "(\d{1,3}\.){3}\d{1,3}" | sort -k 2)
TAG="<!-- END SECTION"
while read LINE; do
	HOSTNAME=$(echo  $LINE | awk '{ print $1 }')
        IPADDRESS=$(echo $LINE | awk '{ print $2 }')
	sudo sed -i "/$IPADDRESS/d" /var/www/collectd/index.html
        sudo sed -i "/$HOSTNAME/d"  /var/www/collectd/index.html
	sudo sed -i "s/${TAG}/<th><div class=\"red-button-container\"> <a href=\"http:\/\/${HOSTNAME}\/collectd\" title=\"http:\/\/${HOSTNAME}\/collectd \(${IPADDRESS}\)\" id=\"red-button\" >${HOSTNAME} collectd<\/a><\/div><\/th>\n${TAG}/" /var/www/collectd/index.html
	sudo sed -i "s/${TAG}/<th><div class=\"blue-button-container\"><a href=\"http:\/\/${HOSTNAME}\/dump1090\" title=\"http:\/\/${HOSTNAME}\/dump1090 \(${IPADDRESS}\)\" id=\"blue-button\">${HOSTNAME} dump<\/a><\/div><\/th>\\n${TAG}/" /var/www/collectd/index.html
done < <(sort -n -k 1 < /home/pi/dump-tools/collectd/hosts)

