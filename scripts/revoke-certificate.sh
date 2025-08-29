#!/usr/bin/bash

if [[ "$1" == "" ]]; then
	echo "You need to specify the serial number of the certificate"
	exit 1
fi

if [[ ! -f ./certs/$1.pem ]]; then
	echo "Could not find the certificate $(pwd)/certs/$1.pem"
	exit 2
fi

# Revoke the certificate
openssl ca -config ./openssl.cnf -revoke ./certs/$1.pem
