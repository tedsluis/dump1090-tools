#!/bin/bash

# Installs dump-tools, collectd for dump1090 mutability on raspbian.
# The installer will:
# - create directories (with the permissions of the parent directory).
# - download the files and copy them with the correct permissions to the target directories.
# - create backup files whenever existing files are updated.
# - run as 'pi' user and use 'root' whenever if needed.
# - install 'collectd' and start it.
# - add the 'graphs-crontabjob.sh' script to crontab (scheduled every 5 minutes).
# - a copy of the original crontab is saved.
# - create graphs for the first time.
#
# Must be launched as user 'pi'.
#
# By ted.sluis@gmail.com

# Default user
user="pi"

# Test user.
if [ "x${user}" = "x${USER}" ]; then
	echo "This script is launched by user $USER."
else 
	echo "Error: This script should have been launch by user $user." 
	exit 1;
fi

# Collectd installed?
echo "==============INSTALL:[collectd]================================="
check=$(dpkg-query -W -f='${Status} ${Version}\n' collectd)
echo $check
if [[ $check =~ ok ]]; then
        echo "Collect $check"
else
        sudo apt-get install -y collectd
fi

# date time string
now=$(date +"%Y%m%d%H%M%S")

# change owner ship file or directory
CHANGEPERMISSIONS() {
	path=$1
	permission=$2
	owner=$3
	group=$4
	# get path permissions, owner and group. 
	pathpermission="$(stat --format '%a' "$path")"
	pathowner="$(stat --format '%U' "$path")"
	pathgroup="$(stat --format '%G' "$path")"
	# if someone else is owner, then use root privilege to change permissions
	if [ "x${pathowner}" = "x${USER}" ]; then
		if [ ! "x${pathpermission}" = "x${permission}" ]; then
			echo "execute ($USER): chmod $permission $path (owner=$owner)"
			chmod $permission $path
		fi
		if [ ! "x${pathgroup}" = "x${group}" ]; then
			echo "execute ($USER): chgrp $group $path (owner=$owner)"
			chgrp $group $path
		fi
	else
                echo "execute (root): chown $owner $path"
                sudo chown $owner $path
		if [ ! "x${pathpermission}" = "x${permission}" ]; then
			echo "execute (root): sudo chmod $permission $path (owner=$owner)"
                	sudo chmod $permission $path
		fi
		if [ ! "x${pathgroup}" = "x${group}" ]; then
			echo "execute (root): chgrp $group $path (owner=$owner)"
                	sudo chgrp $group $path 
		fi
	fi
}

# create directory
MKDIR(){
        directorypath=$1
        path="/"
	# split directory path into subdirectories
	# check if it exists, otherwise create it and set permissions
        for subdirectory in $(echo $directorypath | tr "/" " ")
        do
                dir="$path$subdirectory/"
		# create directory if it does not exists.
                if [ ! -d "$dir" ]; then
			permission=$( stat -c %a $path )
			owner=$( stat -c %U $path )
			group=$( stat -c %G $path )
			# use root privilege if the current directory is not writable.
                        if [ ! -w "$path" ]; then
				echo "execute (root): sudo mkdir $dir"
                                sudo mkdir $dir
                        else
				echo "execute ($USER): mkdir $dir"
                                mkdir $dir
                        fi
			CHANGEPERMISSIONS "$dir" "$permission" "$owner" "$group"
                fi
                path=$dir
        done
}

# download file to target directory
GETFILE(){
	websource=$1
	targetfile=$2
	permission=$3
	file="${targetfile##*/}"
	directory="${targetfile%/*}"
	echo ""
	echo "==============NEW FILE:[$file]========================================"
	echo "  websource=$websource"
	echo "  targetfile=$targetfile"
	echo "  permission=$permission"
	echo "  directory=$directory"
	echo "  file=$file."
	# make directory if it does not exists.
	MKDIR "$directory" "$permission"
	#
	owner=$( stat -c %U $directory )
	group=$( stat -c %G $directory )
	# move previous version if target file already exists.
	if [ -e $targetfile ]; then
		# use root privilege if the current directory or file is not writable.
		if [ ! -w $directory ] || [ ! -w $targetfile ]; then
			echo "execute (root): sudo mv $targetfile $targetfile.$now"
			sudo mv $targetfile "$targetfile.$now"
		else
			echo "execute ($USER): mv $targetfile $targetfile.$now"
			mv $targetfile "$targetfile.$now"
		fi
		CHANGEPERMISSIONS "$targetfile.$now" "$permission" "$owner" "$group" 
	fi
	# use root privilege to download file from web to the target location if the current directory is not writable.
	if [ ! -w "$directory" ]; then
		echo "execute (root): sudo wget $websource -O $targetfile"
		sudo wget $websource -O $targetfile
	else
		echo "execute ($USER): wget $websource -O $targetfile"
                wget $websource -O $targetfile
	fi
	CHANGEPERMISSIONS "$targetfile" "$permission" "$owner" "$group"
}

# Download files, save in target directories and set permissions.
# Directories will be created with the same permissions, owner and group like the parent directories.
# Files will get the specified permissions.
GETFILE "https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/collectd.conf"        "/etc/collectd/collectd.conf"                       "644"
GETFILE "https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/index.html"           "/var/www/collectd/index.html"                      "644"
GETFILE "https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/jquery.js"            "/var/www/collectd/jquery.js"                       "644"
GETFILE "https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090.db"          "/home/pi/dump-tools/collectd/dump1090.db"          "774"
GETFILE "https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/dump1090.py"          "/home/pi/dump-tools/collectd/dump1090.py"          "775"
GETFILE "https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/graphs-crontabjob.sh" "/home/pi/dump-tools/collectd/graphs-crontabjob.sh" "775"
GETFILE "https://raw.githubusercontent.com/tedsluis/dump1090-tools/master/make-graphs.sh"       "/home/pi/dump-tools/collectd/make-graphs.sh"       "775"

# Add graphs-crontabjob.sh to crontab
echo "==============ADD TO CRONTAB:[graphs-crontabjob.sh]=============="
echo "execute (root): sudo crontab -l > /home/pi/dump-tools/crontab.$now"
sudo touch "/home/pi/dump-tools/crontab.$now"
CHANGEPERMISSIONS "/home/pi/dump-tools/crontab.$now" "666" "pi" "pi"
sudo crontab -l > "/home/pi/dump-tools/crontab.$now"
echo "execute (root): sudo cp /home/pi/dump-tools/crontab.$now /home/pi/dump-tools/crontab"
sudo cp "/home/pi/dump-tools/crontab.$now" "/home/pi/dump-tools/crontab"
CHANGEPERMISSIONS "/home/pi/dump-tools/crontab" "666" "pi" "pi"
echo "execute (root): sed -i '/graphs-crontabjob.sh/d' /home/pi/dump-tools/crontab"
sudo sed -i '/graphs-crontabjob.sh/d' "/home/pi/dump-tools/crontab"
echo "execute (root): sudo echo '*/5 * * * * sudo /home/pi/dump-tools/collectd/graphs-crontabjob.sh >/dev/null' >> /home/pi/dump-tools/crontab"
sudo echo '*/5 * * * * sudo /home/pi/dump-tools/collectd/graphs-crontabjob.sh >/dev/null' >> "/home/pi/dump-tools/crontab"
echo "execute (root): sudo crontab /home/pi/dump-tools/crontab"
sudo crontab "/home/pi/dump-tools/crontab"
sudo rm "/home/pi/dump-tools/crontab"

# Restart collectd to initialize /etc/collectd/collectd.conf
echo "==============RESTART:[collectd]================================="
sudo /etc/init.d/collectd restart

# create graphs for the first time
echo "==============CREATE GRAPHS======================================"
/home/pi/dump-tools/collectd/graphs-crontabjob.sh

# Edit /etc/lighttpd/lighttpd.conf
echo "==============EDIT:[/etc/lighttpd/lighttpd.conf]================="
echo "execute (root): sed -i '/server.document-root.*/server.document-root        = \"\var/www\"/g' /etc/lighttpd/lighttpd.conf"
sudo sed -i '/server.document-root.*/server.document-root        = \"\/var\/www\"/g' "/etc/lighttpd/lighttpd.conf"

