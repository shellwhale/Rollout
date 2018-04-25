# Ce script a pour but de donner des instructions aux machines WinPE fraîchement démarrées
# ATTENTION ! Ce script est lancé depuis X:\Windows\System32\ soyez donc précis dans les chemins que vous utilisez


Write-Host "Construction du dossier X:\scripts" -BackgroundColor Magenta
New-Item -Path "X:\scripts" -ItemType Directory

Write-Host "Copie de tous les fichiers .ps1 de N:\IPXE vers x:\scripts" -BackgroundColor Magenta
Copy-Item N:\IPXE\*.ps1 x:\scripts\ 

Write-Host "Lancement de N:\IPXE\VNC\winvnc.exe" -BackgroundColor Magenta
Start-Process N:\IPXE\VNC\winvnc.exe







Write-Host "Test de la connexion avec ipxe.technocite.lan" -BackgroundColor Magenta

while($true)
{
    If (Test-Connection ipxe.technocite.lan -Count 1 -Quiet) 
    {Write-Host "Il y a connexion !" -BackgroundColor Green; break} 
    Else 
    { Write-Host "Aucune connexion, nouvelle tentative" -BackgroundColor Red; Start-Sleep -Seconds 1}
}





Write-Host "Construction de X:\deployement.ps1 via http://ipxe.technocite.lan/javascripts/ipxe.php" -BackgroundColor Magenta

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
            Write-Host "Impossible de prendre le fichier via http://ipxe.technocite.lan/javascripts/ipxe.php , nouvelle tentative" -BackgroundColor Red
            Start-Sleep -Seconds 1
        }

    }
}