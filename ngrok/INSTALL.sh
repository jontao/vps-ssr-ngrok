#!/bin/bash

if [  "$1" != "-c"  -a  "$1" != "-s" -a ! -n "$2" ]; then
    echo -e "usage: -c client model
       -s server model
       xxx.com/.cn domainname" 
	exit
fi

make clean
rm `pwd`/ngrok_bg /etc/rc.d/init.d/ngrok_bg -f
rm assets/client/tls/ngrokroot.crt -f
rm assets/server/tls/snakeoil.crt -f
rm assets/server/tls/snakeoil.key -f

openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=$2" -days 5000 -out rootCA.pem
openssl genrsa -out device.key 2048
openssl req -new -key device.key -subj "/CN=$2" -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000

cp rootCA.pem assets/client/tls/ngrokroot.crt
cp device.crt assets/server/tls/snakeoil.crt
cp device.key assets/server/tls/snakeoil.key

make all
touch `pwd`/ngrok_bg
echo -e '
#!/bin/bash
if [ "$1" = "-c" ]; then
   /opt/vps-ssr-ngrok/ngrok/bin/ngrok -config=/opt/vps-ssr-ngrok/ngrok/ngrok.cfg start sub subs ssh video &
else if [ "$1" = "-s" ]; then
   /opt/vps-ssr-ngrok/ngrok/bin/ngrokd -domain="'$2'" -httpAddr=":8001"  -httpsAddr=":8002" -log=/var/log/ngrokd.log 1>/dev/null 2>&1 &
else 
    echo "arg error!"
    exit
fi
fi' > `pwd`/start.sh

echo -e "
#!/bin/bash
#chkconfig: 2345 10 90
#description: ngrok_bg
case \"\$1\" in
	start)
		echo \"started ngrok background\" > /var/log/ngrok-start.log
		sh /opt/vps-ssr-ngrok/ngrok/start.sh $1 
		;;
	*)
		exit 1
		;;
esac" > `pwd`/ngrok_bg

echo -e '
server_addr: "'$2':4443"
trust_host_root_certs: false
tunnels:
 sub:
   proto:
    http: 80
 ssh:
  remote_port: 1122
  proto:
    tcp: 22
 subs:
  proto:
    https: 443
 video:
  remote_port: 9001
  proto:
    tcp: 9001' > ngrok.cfg


chmod +x `pwd`/ngrok_bg
chmod +x `pwd`/start.sh

\cp -f ngrok_bg /etc/rc.d/init.d/
chkconfig --add ngrok_bg
chkconfig ngrok_bg on
echo "chkconfig on"
