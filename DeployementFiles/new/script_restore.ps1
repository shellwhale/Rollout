param([string]$image)
$connected = $false

Function Copy-WithProgress
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        $Source,
        [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        $Destination
    )

    $Source=$Source.tolower()
    $Filelist=Get-Childitem "$Source" -Recurse
    $Total=$Filelist.count
    $Position=0

    foreach ($File in $Filelist)
    {
        $Filename=$File.Fullname.tolower().replace($Source,'')
        $DestinationFile=($Destination+$Filename)
        Write-Progress -Activity "Copying data from '$source' to '$Destination'" -Status "Copying File $Filename" -PercentComplete (($Position/$total)*100)
        Copy-Item $File.FullName -Destination $DestinationFile
        $Position++
    }
}

# Test de la connexion au lecteur réseau \\sv-w2k12-pedah.pedagogique.lan\deploiement$ 
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
        Start-Sleep -Seconds 1
    }
}

# Préparation des partitions

$file = "Z:\images\$image"
Write-Host "L'image $file sera utilisée pour le déploiement..."
$taille=([int](((Get-Item $file).length)/1MB))+500
cd x:\scripts

New-Item –name "diskpart.txt" –itemtype file –force | Out-Null
$FirmwareType = (Get-FirmwareType).FirmwareType
if ($FirmwareType -eq "BIOS")
{
    Add-Content –path "x:\scripts\diskpart.txt" 'select disk 0
    clean
    rem == 1. System partition ======================
    create partition primary size=350
    format quick fs=ntfs label="System"
    assign letter="S"
    active



    rem == 2. Windows partition =====================
    create partition primary'
    Add-Content –path x:\scripts\diskpart.txt  "shrink minimum=$taille"
    Add-Content –path x:\scripts\diskpart.txt 'format quick fs=ntfs label="Windows"
    assign letter="W"

    rem == 3. Recovery tools partition ==============
    create partition primary
    format quick fs=ntfs label="Recovery image"
    assign letter="R"
    set id=27
    list volume
    exit
    '
}
elseif ($FirmwareType -eq "UEFI") 
{
    Add-Content –path "x:\scripts\diskpart.txt" 'select disk 0
    
    rem == 1. System partition =========================
    clean
    convert gpt
    create partition efi size=350
    format quick fs=fat32 label="System"
    assign letter="S"


    rem == 2. Microsoft Reserved (MSR) partition =======
    create partition msr size=16



    rem == 3. Windows partition ========================
    create partition primary
    ' 
    Add-Content –path x:\scripts\diskpart.txt "shrink minimum=$taille"
    Add-Content –path x:\scripts\diskpart.txt 'format quick fs=ntfs label="Windows"
    assign letter="W"

    rem === 4. Recovery tools partition ================
    create partition primary
    format quick fs=ntfs label="Recovery tools"
    assign letter="R"
    set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"
    gpt attributes=0x8000000000000001
    list volume
    exit
    '
}


diskpart.exe /s x:\scripts\diskpart.txt 
md R:\RecoveryImage

# Vérification de l'existence de l'image et téléchargement 

if (Test-Path Z:\images\$image.torrent)
{
    Write-Host "Z:\images\$image.torrent existe !" -ForegroundColor Green
    Copy-Item Z:\configurationSet\NewInstall\aria2c.exe x:\
    x:\aria2c "z:\images\$image.torrent" -c --dir="R:\RecoveryImage" --bt-tracker-interval=60 --seed-ratio=1.0 --seed-time=5 --file-allocation=none    
    
}
elseif (Test-Path Z:\images\$image)
{
    Write-Host "Z:\images\$image existe !" -ForegroundColor Green
    $src = "Z:\images\$image"
    $dst = "R:\RecoveryImage"
    Copy-WithProgress -Source $src -Destination $dst  
}
else 
{
    Write-Host "Z:\images\$image n'existe pas !" -ForegroundColor Red
    Write-Host "Z:\images\$image.torrent n'existe pas !" -ForegroundColor Red     
}   

Rename-Item R:\RecoveryImage\*.wim Install.wim

cmd.exe /c call powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
Dism /Apply-Image /ImageFile:"R:\RecoveryImage\Install.wim" /Index:1 /ApplyDir:W:\

Write-Host "Lancement de bcdboot" -ForegroundColor Green
W:\Windows\System32\bcdboot.exe W:\Windows

md R:\Recovery\WindowsRE
xcopy /h W:\Windows\System32\Recovery\Winre.wim R:\Recovery\WindowsRE\
W:\Windows\System32\Reagentc.exe /Setreimage /Path R:\Recovery\WindowsRE /Target W:\Windows

Write-Host "Lancement de Reagentc.exe /Setosimage" -ForegroundColor Green
W:\Windows\System32\Reagentc.exe /Setosimage /Path R:\RecoveryImage /Target W:\Windows /Index 1

Write-Host "Image prête !" -ForegroundColor Green
Write-Host "Redémarrage" -ForegroundColor Green

Restart-Computer