rem == ApplyImage-BIOS.bat ==

rem == These commands deploy a specified Windows
rem    image file to the Windows partition, and configure
rem    the system partition.

rem    Usage:   ApplyImage WimFileName 
rem    Example: ApplyImage E:\Images\ThinImage.wim ==

rem == Copy the image to the recovery partition ==
md R:\RecoveryImage

REM LockFile plus utile, même déconseillé vu P2P
REM type nul >>lock

IF NOT EXIST %1.torrent GOTO CopyWim


REM Ancienne commande de copie
REM esentutl /y "%1" /d "R:\RecoveryImage\Install.wim" /o
copy aria2c.exe X:\
x:\aria2c "%1.torrent" -c --dir="R:\RecoveryImage" --bt-tracker-interval=60 --seed-ratio=1.0 --seed-time=5 --file-allocation=none

REM Aria2C ne tient pas compte de --out pour les torrents, on renomme à la main au bout de trente secondes...
TIMEOUT /T 30
ren R:\RecoveryImage\*.wim Install.wim

REM LockFile plus utile, voir ci-haut
REM del lock /q
GOTO InstallWim

:CopyWim
esentutl /y "%1" /d "R:\RecoveryImage\Install.wim" /o

:InstallWim

rem == Apply the image to the Windows partition ==
dism /Apply-Image /ImageFile:"R:\RecoveryImage\Install.wim" /Index:1 /ApplyDir:W:\
IF     ERRORLEVEL 1 pause

rem == Copy boot files to the System partition ==
pause
W:\Windows\System32\bcdboot W:\Windows

rem == Copy the Windows RE image to the System partition ==
md W:\Windows\System32\Recovery\
copy winre.wim W:\Windows\System32\Recovery\Winre.wim
md S:\Recovery\WindowsRE
xcopy /h W:\Windows\System32\Recovery\Winre.wim S:\Recovery\WindowsRE\

rem == Register the location of the recovery tools ==
W:\Windows\System32\Reagentc /Setreimage /Path S:\Recovery\WindowsRE /Target W:\Windows

rem == Register the location of the push-button reset recovery image. ===
W:\Windows\System32\Reagentc /Setosimage /Path R:\RecoveryImage /Target W:\Windows /Index 1

exit