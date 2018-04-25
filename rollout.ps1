#Requires -RunAsAdministrator

# Récupération de l'architecture et du dossier de destination choisis
param(
[string]$Arch,
[string]$folder,
[string]$EmergencyClean

)

# Récupération de l'emplacement du repo sur la machine locale
$RolloutDirectory = $PWD
$WinboxDirectory = "$PWD\Winbox"

# Le script doit être lancé depuis le dossier Rollout
if (-Not ((Get-Item -Path ".\").name -contains 'Rollout' )) 
{
    Write-Host "Ce script doit être lancé depuis le répertoire Rollout"
    exit    
}

if ($EmergencyClean) {
    Dism /Unmount-Image /MountDir:$WinboxDirectory\$Arch\mount /Discard
    dism /cleanup-wim
}

# Vérification de l'existence du dossier de destination choisi
if ($folder) 
{
    if (-Not(Test-Path $folder)){Write-Host "$folder n'existe pas";exit}
}

# Titre de la fenêtre
$host.ui.RawUI.WindowTitle = "Rollout"

# Si elle est autre que amd64 ou x86, arrêt du script
If (-Not ($Arch -contains 'amd64' -Or $Arch -contains 'x86'))
{
    Write-Host ".\rollout.ps1 -Arch <amd64/x86> -Path <directory>"
    exit
}
# Titre de la fenêtre
$host.ui.RawUI.WindowTitle = "Rollout $Arch"

# Installation de BurntToast si il n'est pas déjà présent 
if (-Not(Test-Path C:\Users\$env:USERNAME\Documents\WindowsPowerShell\modules\BurntToast)){Copy-Item ./Modules/BurntToast C:\Users\$env:USERNAME\Documents\WindowsPowerShell\modules\BurntToast}

# Génération d'un WinPE dans le dossier Winbox via ADK selon l'architecture choisie
Get-Content "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\DandISetEnv.bat" | Out-File "$env:temp\DandISetEnv$Arch.bat" -encoding ASCII
Add-Content -Path $env:temp\DandISetEnv$Arch.bat -Value "copype $Arch $WinboxDirectory\$arch"
cmd.exe /c $env:temp\DandISetEnv$Arch.bat

# Montage de l'image à la racine selon l'architecture choisie 
Dism /Mount-Image /ImageFile:"$WinboxDirectory\$Arch\media\sources\boot.wim" /Index:1 /MountDir:"$WinboxDirectory\$Arch\mount"

# Configuration de la région sur fr-BE
Dism /image:$WinboxDirectory\$Arch\mount /Set-SysLocale:fr-BE
Dism /image:$WinboxDirectory\$Arch\mount /Set-UserLocale:fr-BE
Dism /image:$WinboxDirectory\$Arch\mount /Set-InputLocale:fr-BE

# Ajout des fichiers StartNet.cmd et Start.ps1
Remove-Item $WinboxDirectory\$Arch\mount\Windows\System32\StartNet.cmd
Copy-Item DeployementFiles\StartNet.cmd $WinboxDirectory\$Arch\mount\Windows\System32\
Copy-Item DeployementFiles\Start.ps1 $WinboxDirectory\$Arch\mount\Windows\System32\

# Ajout des packages 

Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\WinPE-WMI.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\WinPE-NetFX.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\en-us\WinPE-NetFX_en-us.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\WinPE-Scripting.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\WinPE-PowerShell.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\WinPE-StorageWMI.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\WinPE-DismCmdlets.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\WinPE-WinReCfg.cab"
Dism /Add-Package /Image:"$WinboxDirectory\$Arch\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\$Arch\WinPE_OCs\en-us\WinPE-WinReCfg_en-us.cab"

# Démontage et sauvegarde de l'image
Dism /Unmount-Image /MountDir:$WinboxDirectory\$Arch\mount /Commit

# Envoi de la Winbox vers le fichier de destination
If ($folder) 
{ 
    Copy-Item -Recurse $WinboxDirectory $folder
    Remove-Item $WinboxDirectory\$arch
    Write-Host "Winbox disponible en $folder !"
    Set-Location $folder
    $folder = $PWD # New-BurntToastNotification ne prends que les chemins absolus
    Set-Location $RolloutDirectory
}else
{
    Write-Host "Winbox $arch disponible !"
    $folder = $WinboxDirectory 
}

$logo = "$PWD\Ressources\logo.jpg"
$button = New-BTButton -Content 'Terrible' -Arguments "$folder"
New-BurntToastNotification -Text "Rollout", "Une Winbox $Arch est prête !" -Button $button -AppLogo $logo
