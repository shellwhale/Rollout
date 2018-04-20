# Copy-Itempe x86 C:\x86

Write-Host "VERSION x86" -BackgroundColor Red -ForegroundColor White
Write-Host "Nettoyage des points de montage"  -ForegroundColor Yellow

Dism /Cleanup-Mountpoints
Dism /Mount-Image /ImageFile:"C:\x86\media\sources\boot.wim" /Index:1 /MountDir:"C:\x86\mount"

Dism /image:c:\x86\mount /Set-SysLocale:fr-BE
Dism /image:c:\x86\mount /Set-UserLocale:fr-BE
Dism /image:c:\x86\mount /Set-InputLocale:fr-BE

Write-Host "Ajout du fichier StartNet.cmd"  -ForegroundColor Yellow

rm C:\x86\mount\Windows\System32\StartNet.cmd
Copy-Item C:\Users\$env:USERNAME\Desktop\Rollout\StartNet.cmd C:\x86\mount\Windows\System32\

Write-Host "Ajout du fichier Start.ps1"  -ForegroundColor Yellow
Copy-Item C:\Users\$env:USERNAME\Desktop\Rollout\Start.ps1 C:\amd64\mount\Windows\System32\

Write-Host "Ajout des packages"  -ForegroundColor Yellow

Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-WMI.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-NetFX.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-NetFX_en-us.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-Scripting.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-PowerShell.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-StorageWMI.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-DismCmdlets.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-WinReCfg.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-WinReCfg_en-us.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\WinPE-SecureBootCmdlets.cab"
Dism /Add-Package /Image:"C:\x86\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\x86\WinPE_OCs\en-us\WinPE-SecureBootCmdlets_en-us.cab"

Write-Host "Sauvegarde des modifications"  -ForegroundColor Yellow

Dism /Unmount-Image /MountDir:C:\x86\mount /Commit

Write-Host "Génération d'un Winboot à utiliser avec iPXE" -Foreground Yellow

Move-Item C:\x86 C:\Users\$env:USERNAME\Desktop\Rollout\Winbox

Write-Host "Winbox disponible x86" -Foreground Green

New-BurntToastNotification -Text 'Rollout', 'x86 fini ! Terrible ! ' 
