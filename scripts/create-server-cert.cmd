@echo off

if "%1" == "" then goto error_no_name_specified
if exist .\private\%1.key goto error_name_already_used

rem Generate key pair
openssl genrsa -out .\private\%1.key 4096

rem Generate certificate request
openssl req -new -key .\private\%1.key -out .\csr\%1.csr -config .\openssl.cnf

rem Process certificate request
openssl ca -config .\openssl.cnf --extfile .\server_cert.ext -extensions server_cert_with_san -notext -days 365 -in .\csr\%1.csr -out .\%1.crt

rem Create an export in PKCS12 format
openssl pkcs12 -export -in %1.crt -inkey .\private\%1.key -out .\%1.p12

goto end

:error_no_name_specified
echo "ERROR: You need to specify a name for the generated material"
goto end

:error_name_already_used
echo "ERROR: The specified name was already used"
goto end

:end