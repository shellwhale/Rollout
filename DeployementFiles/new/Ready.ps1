# Ce script est executé par les machines WinPE fraîchement démarrées
# ATTENTION ! Ce script est lancé depuis X:\Windows\System32\ soyez donc précis dans les chemins que vous utilisez
# Par pitié n'utilisez pas de chemins relatifs mais uniquement des absolus, il y a des stagiaires qui souffrent autrement
# Pour une meilleure compréhension du système de déploiement, se référer au plan dans [ajouter chemin documentation ]

New-Item -Path "X:\scripts" -ItemType Directory
Copy-Item N:\IPXE\*.ps1 x:\scripts\ 
Start-Process N:\IPXE\VNC\winvnc.exe

while($true)
{
    If (Test-Connection ipxe.technocite.lan -Count 1 -Quiet) {break} 
    Else { Write-Host "Aucune connexion avec ipxe.technocite.lan" -ForegroundColor Red; Start-Sleep -Seconds 1}
}

While($true)
{
    If (Test-Path X:\deployement.ps1) 
    {  
        Write-Host "En route vers N:\IPXE" -BackgroundColor Green
        Write-Host "Construction de X:\deployement.ps1" -BackgroundColor Green
        Set-Location N:\IPXE
        powershell X:\deployement.ps1
        break
    }

    Else 
    {
        try 
        {
            $url = "http://ipxe.technocite.lan/javascripts/ipxe2018.php?code=1"
            $output = "X:\deployement.ps1"

            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($url, $output)   
        }
        catch 
        {
            Write-Host "Impossible de récupérer le fichier via http://ipxe.technocite.lan/javascripts/ipxe.php" -ForegroundColor Red
            Start-Sleep -Seconds 1
        }
    }
}