#!/usr/bin/bash

if [[ "$1" == "" ]]; then
	echo "Please specify a name for the new key material..."
	exit 1
fi

if [[ -f "./private/$1.key" ]]; then
	echo "The name \"$1\" was already used. Please choose a different one."
	exit 2
fi

# Generate key pair
openssl genrsa -out ./private/$1.key 4096

# Generate certificate request
openssl req -new -key ./private/$1.key -out ./csr/$1.csr -config ./openssl.cnf

# Process certificate request
openssl ca -config ./openssl.cnf -extensions usr_cert -notext -days 365 -in ./csr/$1.csr -out $1.crt

# Create an export in PKCS12 format
openssl pkcs12 -export -in $1.crt -inkey ./private/$1.key -out $1.p12
