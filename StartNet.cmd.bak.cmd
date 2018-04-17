@echo off
wpeinit
:TRYAGAIN
ECHO Test de la connection reseau, Veuillez patienter...
PING -n 1 ipxe.technocite.lan|find "Reply from " >NUL
IF NOT ERRORLEVEL 1 goto :SUCCESS
IF     ERRORLEVEL 1 goto :TRYAGAIN

:SUCCESS
echo Reseau OK, suite du script
net use n: \\ipxesmb.technocite.lan\scripts$ techn0cite /user:scripts@pedagogique.lan
n:

cd ipxe
script.bat