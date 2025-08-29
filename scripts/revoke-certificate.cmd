@echo off

if "%1"=="" goto no_serial_number_specified
if not exist .\certs\%1.pem goto cert_not_found

rem Revoke the certificate
openssl ca -config .\openssl.cnf -revoke .\certs\%1.pem

goto end

:no_serial_number_specified
echo "ERROR: You need to specify a serial number"
goto end

:cert_not_found
echo "ERROR: The certificate with the specified serial number was not found: %1"
goto end

:end
