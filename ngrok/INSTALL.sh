#!/bin/bash
make clean
rm assets/client/tls/ngrokroot.crt -f
rm assets/server/tls/snakeoil.crt -f
rm assets/server/tls/snakeoil.key -f

openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -subj "/CN=jonta.cn" -days 5000 -out rootCA.pem
openssl genrsa -out device.key 2048
openssl req -new -key device.key -subj "/CN=jonta.cn" -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 5000

cp rootCA.pem assets/client/tls/ngrokroot.crt
cp device.crt assets/server/tls/snakeoil.crt
cp device.key assets/server/tls/snakeoil.key

make all
\cp -f ngrok_bg /etc/rc.d/init.d/
chkconfig --add ngrok_bg
chkconfig ngrok_bg on
