##########################################################################################################################################################
# CA
openssl req -new -newkey rsa:4096 -keyout private/cakey.pem -out careq.pem -config ./openssl.cnf
openssl ca -create_serial -out cacert.pem -days 365 -keyfile private/cakey.pem -selfsign -extensions v3_ca -config ./openssl.cnf -infiles careq.pem
keytool -import -file ./cacert.pem -alias svero-test-ca -keystore truststore.p12

##########################################################################################################################################################
# Server certificates (edit SAN list in server_cert.ext before creating the certificate!)
openssl genrsa -out ./private/keycloak.key 4096
openssl req -new -key ./private/keycloak.key -out ./csr/keycloak.csr -config ./openssl.cnf
openssl ca -config ./openssl.cnf -extfile ./server_cert.ext -extensions server_cert_with_san -notext -days 90 -in ./csr/keycloak.csr -out keycloak.crt
openssl pkcs12 -export -in keycloak.crt -inkey ./private/keycloak.key -out keycloak.p12

##########################################################################################################################################################
# Client certificates
openssl genrsa -out ./private/user.key 4096
openssl req -new -key ./private/user.key -out ./csr/user.csr -config ./openssl.cnf
openssl ca -config ./openssl.cnf -extensions usr_cert -notext -days 90 -in ./csr/user.csr -out user.crt
openssl pkcs12 -export -in user.crt -inkey ./private/user.key -out user.p12

##########################################################################################################################################################
# CRL erstellen
openssl ca -config ./openssl.cnf -gencrl -out crl/svero-demo-ca.crl
