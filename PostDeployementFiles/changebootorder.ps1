# Dépendances pour DellBiosProvider
# vcredist2010
# vcredist2012
# Les installer avec Chocolatey ..

Install-Module -Name GetFirmwareBIOSorUEFI  -Force
Import-Module GetFirmwareBIOSorUEFI  
if ((Get-FirmwareType).firmwaretype -eq "UEFI") 
{
    Install-Module DellBiosProvider -Force;
    Import-Module DellBiosProvider;
    # Vérification de l'existance de DellSmbios:\
    if (-Not(Test-Path DellSmbios:\)) {Write-Host "DellSmbios:\ n'existe pas ! Le BIOS n'est peut être pas à jour ... ?" -Foregroundcolor Red}
    # Récupération des objets DeviceName, DeviceNumber
    $a = (ls DellSmbios:\BootSequence\).CurrentValue | Select-Object DeviceName,DeviceNumber;
    # Récupération du DeviceNumber qui corresponds à celui du Windows Boot Manager
    $windows = ($a | ? DeviceName -match "Windows Boot Manager");
    # Définition d'une séquence pour être sûr que Windows Boot Manager doit démarrer en dernier
    $sequence = "";
    ((ls DellSmbios:\BootSequence\BootSequence).currentvalue) | ForEach-Object { # Boucle à travers chaque valeur
        # Si le DeviceNumber n'est pas celui de Windows Boot Manager, il est ajouté à la séquence
        if (-Not($_.DeviceNumber -eq $windows.DeviceNumber)) 
        {
            $sequence = -join($sequence,$_.DeviceNumber,",");
        }
    }
    # Windows Boot Manager est ajouté en dernier à la séquence
    $sequence = -join($sequence,$windows.DeviceNumber);
    Set-Item DellSmbios:\BootSequence\BootSequence $sequence; 
}
else 
{
    Write-Host "Système en UEFI, pas de changement de BootSequence nécessaire" -Foregroundcolor Green   
}











