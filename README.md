# vps-ssr-ngrok <br>
NGROK:<br>
	server:<br>
	#./ngrokd -domain="your domain" -httpAddr=":80"  -httpsAddr=":443" -log=/var/log/ngrokd.log<br>
	client:<br>
	#./ngrok -config=ngrok.conf start subdomain<br>
SHADOWSOCKSR:<br>
	server:<br>
	# /usr/bin/python /opt/vps-ssr-ngrok/shadowsocksr/shadowsocks/server.py -c /opt/vps-ssr-ngrok/shadowsocksr/config.json -d start<br>
	client:<br>
	/usr/bin/python /opt/vps-ssr-ngrok/shadowsocksr/shadowsocks/local.py -c /opt/vps-ssr-ngrok/shadowsocksr/config.json -d start<br> 
