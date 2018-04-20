param([string]$image)


Write-Host "Test de la connexion avec chateau.smb.ipxe.technocite.lan" -BackgroundColor Magenta

while($true)
{
    If (Test-Connection chateau.smb.ipxe.technocite.lan -Count 1) 
    {Write-Host "Il y a connexion !" -BackgroundColor Green; break} 
    Else 
    {Write-Host "Aucune connexion, nouvelle tentative" -BackgroundColor Red; Start-Sleep -Seconds 1}
}
Write-Host "Montage du lecteur Z:" -BackgroundColor Magenta
net use z: \\sv-w2k12-pedah.pedagogique.lan\deploiement$ techn0cite /user:scripts@pedagogique.lan 


If (Test-Path Z:\images\Pedagogique\$image.torrent) 
{
    Write-Host "Z:\image\$image.torrent existe"
}
Elseif 
{
    Write-Host "Z:\image\$image.torrent n'existe pas"
    pause
}

Set-Location Z:\configurationSet\NewInstall
Copy-Item N:\IPXE\Scripts\diskpartfile.ps1 X:\scripts\

try 
{
    X:\scripts\diskpartfile.ps1 ..\..\images\$image
    diskpart /s x:\scripts\diskpart.txt
}
else 
{
    Write-Host "Impossible de lancer le script diskpart" -BackgroundColor Red
}

Start-Process -WindowStyle Minimized X:\scripts\dellock.ps1

New-Item -Path R:\RecoveryImage -ItemType Directory

Copy-Item  z:\configurationSet\NewInstall\aria2c.exe X:\
X:\aria2c "$image.torrent" -c --dir="R:\RecoveryImage" --bt-tracker-interval=60 --seed-ratio=1.0 --seed-time=5 --file-allocation=none

Start-Sleep -Seconds 30

Rename-Item R:\RecoveryImage\*.wim Install.wim

Dism /Apply-Image /ImageFile:"R:\RecoveryImage\Install.wim" /Index:1 /ApplyDir:W:\

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