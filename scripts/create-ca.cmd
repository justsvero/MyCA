@echo off

rem Create key pair and certificate request
openssl req -new -newkey rsa:4096 -keyout .\private\cakey.pem -out .\csr\careq.pem -config .\openssl.cnf

rem Create CA certificate (self-signed)
openssl ca -create_serial -out .\cacert.pem -days 1825 -keyfile .\private\cakey.pem -selfsign -extensions v3_ca -config .\openssl.cnf -infiles .\csr\careq.pem

rem Create (or update) trust store
rem keytool -import -file .\cacert.pem -alias cacert -keystore .\truststore.p12