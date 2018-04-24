@echo off
rem @cls
set file=%1

ECHO Test de la connexion r‚seau, veuillez patienter...
PING -n 1 chateau.smb.ipxe.TECHNOCITE.LAN|find "ponse" >NUL
IF NOT ERRORLEVEL 1 goto :LACIE

PING -n 1 chateau.smb.ipxe.TECHNOCITE.LAN|find "Reply from " >NUL
IF NOT ERRORLEVEL 1 goto :LACIE
IF     ERRORLEVEL 1 goto :NORMAL

:LACIE
echo Connexion … Lacie (pas le chien)...
net use z: \\chateau.smb.ipxe.TECHNOCITE.LAN\deploiement$ techn0cite /user:scripts@pedagogique.lan 2> NUL
if errorlevel 1 goto NORMAL
if EXIST z:\images\%file%.torrent goto :connected
if EXIST z:\images\%file% goto :connected
net use z: /delete

:NORMAL
echo Connexion … SV-W2K12-PedaH.Pedagogique.Lan...
net use z: \\sv-w2k12-pedah.pedagogique.lan\deploiement$ techn0cite /user:scripts@pedagogique.lan 2> NUL

:connected
net use s: /delete
net use w: /delete
net use R: /delete
z:
cd z:\configurationSet\NewInstall
copy n:\IPXE\Scripts\diskpartfile.ps1 x:\scripts\

:checkFile
IF [%file%]==[] GOTO askFile
IF EXIST "z:\images\%file%".torrent GOTO fileExists
IF EXIST "z:\images\%file%" GOTO fileExists

:askFile
echo Le fichier renseign‚, %file% (ou son torrent), n'existe pas ! C'est dommage...
set /p file=Mais on est gentils, tu as droit … une autre chance (depuis Deploiement$\images\) : 
goto checkFile

:fileExists
echo Le fichier %file% existe, toutes nos f‚licitations !
start /MAX powershell.exe "x:\scripts\diskpartfile.ps1 ..\..\images\%file%"

:creatediskpart
rem TIMEOUT /T 30
if not exist x:\scripts\diskpart.txt goto :creatediskpart
diskpart /s x:\scripts\diskpart.txt
if not exist lock goto :continue
start /MIN powershell.exe "x:\scripts\dellock.ps1"
:copie
if not exist lock goto :continue
TIMEOUT /T 10
goto :copie

:continue
rem copy timeout.exe lock
ApplyImage-BIOS-temp-working.bat ..\..\images\%file%
x:
net use /delete z:
echo on
exit