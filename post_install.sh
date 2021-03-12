#!/bin/sh

pw useradd rtorrent -g 0 -m

mv /root/.rtorrent.rc /home/rtorrent/.rtorrent.rc

npm install -g forever

# rTorrent startup script
chmod 555 /usr/local/etc/rc.d/rtorrent
sysrc -f /etc/rc.conf rtorrent_enable="YES"

# rTorrent Flood startup script
chmod 555 /usr/local/etc/rc.d/rtorrent_flood
sysrc -f /etc/rc.conf rtorrent_flood_enable="YES"

npm install --global flood

# Start the service
service rtorrent start
service rtorrent_flood start

echo "Flood ui credentials" > /root/PLUGIN_INFO
echo "User: admin" >> /root/PLUGIN_INFO
echo "Password: admin" >> /root/PLUGIN_INFO

# OpenVPN directory
mkdir /usr/local/etc/openvpn

# Define firewall rules
sysrc -f /etc/rc.conf firewall_script="/etc/ipfw.rules"
