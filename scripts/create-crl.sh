#!/usr/bin/sh

if [ "$1" = "" ] ; then
	echo "Please specify a name for the CRL file"
	exit 1
fi

openssl ca -config ./openssl.cnf -gencrl -out "crl/$1.crl"
