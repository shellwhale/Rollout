md R:\RecoveryImage

copy aria2c.exe x:\
x:\aria2c "%1.torrent" -c --dir="R:\RecoveryImage" --bt-tracker-interval=60 --seed-ratio=1.0 --seed-time=5 --file-allocation=none

TIMEOUT /T 30
ren R:\RecoveryImage\*.wim Install.wim

dism /Apply-Image /ImageFile:"R:\RecoveryImage\Install.wim" /Index:1 /ApplyDir:W:\
IF     ERRORLEVEL 1 pause

powershell Write-Host "Lancement de bcdboot" -ForegroundColor Green
powershell W:\Windows\System32\bcdboot.exe W:\Windows

powershell Write-Host "Copie de W:\Windows\System32\Recovery\Winre.wim vers S:\Recovery\WindowsRE\" -ForegroundColor Green
powershell md S:\Recovery\WindowsRE
powershell xcopy /h W:\Windows\System32\Recovery\Winre.wim S:\Recovery\WindowsRE\

powershell Write-Host "Lancement de Reagentc.exe /Setreimage" -ForegroundColor Green
powershell W:\Windows\System32\Reagentc.exe /Setreimage /Path S:\Recovery\WindowsRE /Target W:\Windows
powershell Write-Host "Lancement de Reagentc.exe /Setosimage" -ForegroundColor Green
powershell W:\Windows\System32\Reagentc.exe /Setosimage /Path R:\RecoveryImage /Target W:\Windows /Index 1


powershell restart-computer