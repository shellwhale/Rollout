param([string]$image)
$connected = $false


# Test de la connexion au lecteur réseau 
while($connected -eq $false)
{
    Write-Host "Connexion à \\sv-w2k12-pedah.pedagogique.lan\deploiement$ ..."
    net use z: \\sv-w2k12-pedah.pedagogique.lan\deploiement$ techn0cite /user:scripts@pedagogique.lan
    if (Test-Path Z:\) 
    {
        Write-Host "Lecteur Z: monté" -ForegroundColor Green
        $connected = $true
    }
    else 
    {
        Write-Host "Impossible de monter le lecteur Z: via sv-w2k12-pedah.pedagogique.lan\deploiement$" -ForegroundColor Red
    }
}

# Vérification de l'existence de l'image

if ((Test-Path Z:\images\$image) -Or (Test-Path Z:\images\$image.torrent)) 
{
    Write-Host "Z:\images\$image existe !" -ForegroundColor Green

    # Formatage des partitions 
    cp N:\IPXE\Scripts\diskpartfile.ps1 x:\scripts\diskpartfile.ps1
    $process= "powershell.exe"
    $arguments = "x:\scripts\diskpartfile.ps1 Z:\images\$image"
    # Démarrage de Diskpart en parallèle (pour gagner du temps)
    Start-Process $process $arguments -WindowStyle Maximized
    diskpart.exe /s x:\scripts\diskpart.txt
}
else 
{
    Write-Host "Z:\images\$image n'existe pas !" -ForegroundColor Red    
}


md R:\RecoveryImage

Copy-Item Z:\configurationSet\NewInstall\aria2c.exe x:\
x:\aria2c "z:\images\$image.torrent" -c --dir="R:\RecoveryImage" --bt-tracker-interval=60 --seed-ratio=1.0 --seed-time=5 --file-allocation=none

Rename-Item R:\RecoveryImage\*.wim Install.wim

dism /Apply-Image /ImageFile:"R:\RecoveryImage\Install.wim" /Index:1 /ApplyDir:W:\

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

pause
Restart-Computer



