# vps-ssr-ngrok
NGROK:
	server:
	#./ngrokd -domain="jonta.cn" -httpAddr=":80"  -httpsAddr=":443" -log=/var/log/ngrokd.log
	client:
	#./ngrok -config=ngrok.conf start subdomain
SHDOWSOCKSR:
	server:
	# /usr/bin/python /opt/vps-ssr-ngrok/shadowsocksr/shadowsocks/server.py -c /opt/vps-ssr-ngrok/shadowsocksr/config.json -d start
	client:
	/usr/bin/python /opt/vps-ssr-ngrok/shadowsocksr/shadowsocks/local.py -c /opt/vps-ssr-ngrok/shadowsocksr/config.json -d start 
