@echo off

if "%1"=="" goto no_name_specified

rem Generate a new CRL
openssl ca -config .\openssl.cnf -gencrl -out ".\crl\%1.crl"

goto end

:no_name_specified
echo "ERROR: You need to specify a CRL name"
goto end

:end
