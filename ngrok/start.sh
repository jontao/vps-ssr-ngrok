#########################################################################
# File Name: start.sh
# Author: jonta
# mail: jonta@foxmail.com
# Created Time: Fri 01 Sep 2017 10:34:27 AM CST
#########################################################################
#!/bin/bash
/opt/vps-ssr-ngrok/ngrok/bin/ngrok -config=/opt/vps-ssr-ngrok/ngrok/ngrok.cfg start sub subs ssh video & 
