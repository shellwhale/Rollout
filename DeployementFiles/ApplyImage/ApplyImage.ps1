$firmware = powershell ./GetFirmwareType.ps1

if ($firmware -contains "BIOS") 
{
    echo "Tu es en BIOS"
}
elseif ($firmware -contains "UEFI") 
{
    echo "Tu es en UEFI"    
}
else 
{
    Write-Host "Architecture non compatible"
    Start-Sleep -Seconds 10
}

