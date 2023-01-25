#!/bin/bash

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libssl-dev
sudo apt-get install -y jq
sudo apt-get install -y ruby-full
sudo apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev
sudo apt-get install -y build-essential libssl-dev libffi-dev python-dev
sudo apt-get install -y python-setuptools
sudo apt-get install -y libldns-dev
sudo apt-get install -y python3-pip
sudo apt-get install -y python-pip
sudo apt-get install -y python-dnspython
sudo apt-get install -y git
sudo apt-get install -y rename
sudo apt-get install -y xargs
sudo apt-get install -y tor

sudo echo "ControlPort 9051" >> /etc/tor/torrc
sudo echo "ORPort 9001" >> /etc/tor/torrc
sudo echo "Nickname kaido" >> /etc/tor/torrc
sudo echo "ContactInfo kaido@mailinator.com" >> /etc/tor/torrc
sudo echo "Log notice file /var/log/tor/notices.log" >> /etc/tor/torrc

## Start tor service ##
sudo tor -f /etc/tor/torrc &



## capture traffic for analysis ##

timeout 45 tshark -i enp0s9 -n -f "host 192.168.5.180 and tcp" -T fields -e ip.src -e ip.dst -e tcp.srcport -e tcp.dstport -E separator=, >capture
cat capture | sort | uniq -u > /home/kira/traffic/`date +%H%M%d%m%Y`
