# copype amd64 C:\amd64

Write-Host "VERSION amd64" -BackgroundColor Red -ForegroundColor White
Write-Host "Nettoyage des points de montage"  -ForegroundColor Yellow

Dism /Cleanup-Mountpoints
Dism /Mount-Image /ImageFile:"C:\amd64\media\sources\boot.wim" /Index:1 /MountDir:"C:\amd64\mount"

Dism /image:c:\amd64\mount /Set-SysLocale:fr-BE
Dism /image:c:\amd64\mount /Set-UserLocale:fr-BE
Dism /image:c:\amd64\mount /Set-InputLocale:fr-BE

Write-Host "Ajout du fichier StartNet.cmd"  -ForegroundColor Yellow

rm C:\amd64\mount\Windows\System32\StartNet.cmd
copy C:\Users\Simon\Desktop\Rollout\StartNet.cmd C:\amd64\mount\Windows\System32\

Write-Host "Ajout du fichier Start.ps1"  -ForegroundColor Yellow
copy C:\Users\Simon\Desktop\Rollout\Start.ps1 C:\amd64\mount\Windows\System32\

Write-Host "Ajout des packages"  -ForegroundColor Yellow

Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFX.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFX_en-us.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-StorageWMI.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-DismCmdlets.cab"
Dism /Add-Package /Image:"C:\amd64\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"

Write-Host "Sauvegarde des modifications"  -ForegroundColor Yellow

Dism /Unmount-Image /MountDir:C:\amd64\mount /Commit

Write-Host "Génération d'un Winboot à utiliser avec iPXE" -Foreground Yellow

move C:\amd64 C:\Users\Simon\Desktop\Rollout\Winbox

Write-Host "Winbox disponible amd64" -Foreground Green

