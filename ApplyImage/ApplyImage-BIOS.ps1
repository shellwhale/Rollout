New-Item -Path R:\RecoveryImage -ItemType Directory

Copy-Item  z:\configurationSet\NewInstall\aria2c.exe X:\
X:\aria2c "%1.torrent" -c --dir="R:\RecoveryImage" --bt-tracker-interval=60 --seed-ratio=1.0 --seed-time=5 --file-allocation=none

Start-Sleep -Seconds 30

Rename-Item R:\RecoveryImage\*.wim Install.wim

dism /Apply-Image /ImageFile:"R:\RecoveryImage\Install.wim" /Index:1 /ApplyDir:W:\
IF     ERRORLEVEL 1 pause

Write-Host "Exécution de bcdboot" -BackgroundColor Magenta
W:\Windows\System32\bcdboot.exe W:\Windows

Write-Host "Copie de W:\Windows\System32\Recovery\Winre.wim vers S:\Recovery\WindowsRE\" -BackgroundColor Magenta
md S:\Recovery\WindowsRE
xcopy /h W:\Windows\System32\Recovery\Winre.wim S:\Recovery\WindowsRE\

Write-Host "Lancement de Reagentc.exe /Setreimage" -ForegroundColor Green
W:\Windows\System32\Reagentc.exe /Setreimage /Path S:\Recovery\WindowsRE /Target W:\Windows

Write-Host "Lancement de Reagentc.exe /Setosimage" -ForegroundColor Green
W:\Windows\System32\Reagentc.exe /Setosimage /Path R:\RecoveryImage /Target W:\Windows /Index 1

Write-Host "Image prête !" -ForegroundColor Green

Write-Host "Redémarrage" -ForegroundColor Green
Restart-Computer