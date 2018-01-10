#########################################################################
# File Name: start.sh
# Author: jonta
# mail: jonta@foxmail.com
# Created Time: Wed Jan 10 01:53:59 2018
#########################################################################
#!/bin/bash
if [  "$1" != "-c"  -a  "$1" != "-s" -a ! -n "$2" ]; then
    echo -e "usage: -c client model
       -s server model 
       xxx.com/.cn domainname" 
	exit
fi
echo '{
    "server": "'$2'",
    "server_ipv6": "::",
    "server_port": 8388,
    "local_address": "127.0.0.1",
    "local_port": 1080,

    "password": "vpsvps",
    "method": "aes-256-cfb",
    "protocol": "auth_aes128_md5",
    "protocol_param": "",
    "obfs":"tls1.2_ticket_auth",
    "obfs_param": "",
    "speed_limit_per_con": 0,
    "speed_limit_per_user": 0,

    "additional_ports" : {}, // only works under multi-user mode
    "additional_ports_only" : false, // only works under multi-user mode
    "timeout": 120,
    "udp_timeout": 60,
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": false
}' > ./config.json 
if [ "$1" = "-s" ]; then
   /usr/bin/python /opt/vps-ssr-ngrok/shadowsocksr/shadowsocks/server.py -c /opt/vps-ssr-ngrok/shadowsocksr/config.json -d start
else if [ "$1" = "-c" ]; then
   /usr/bin/python /opt/vps-ssr-ngrok/shadowsocksr/shadowsocks/local.py -c /opt/vps-ssr-ngrok/shadowsocksr/config.json -d start
else
	echo "please input model"
	exit
  fi
fi
