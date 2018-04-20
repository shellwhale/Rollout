# Ce script a pour but de donner des instructions aux machines WinPE fraîchement démarrées
# ATTENTION ! Ce script est lancé depuis X:\Windows\System32\ soyez donc précis dans les chemins que vous utilisez


Write-Host "<Création du dossier X:\scripts>" -BackgroundColor Magenta
New-Item -Path "X:\scripts" -ItemType Directory

Write-Host "<Copie de tous les fichiers .ps1 de N:\IPXE vers x:\scripts>" -BackgroundColor Magenta
Copy-Item N:\IPXE\*.ps1 x:\scripts\ 

Write-Host "<Lancement de N:\IPXE\VNC\winvnc.exe>" -BackgroundColor Magenta
Start-Process N:\IPXE\VNC\winvnc.exe







Write-Host "<Vérification de la connectivité avec ipxe.technocite.lan>" -BackgroundColor Magenta

while($true)
{
    If (Test-Connection ipxe.technocite.lan -Count 1) 
    {
        Write-Host "<Connecté !>" -BackgroundColor Green; break
    } 

    Else 
    {
        Write-Host "<Aucune connexion, nouvelle tentative>" -BackgroundColor Red
        Start-Sleep -Seconds 1
    }
}





Write-Host "<Génération de X:\deployement.bat via http://ipxe.technocite.lan/javascripts/ipxe.php>" -BackgroundColor Magenta

While($true)
{
    If (Test-Path X:\deployement.bat) 
    {  
        Write-Host "<Déplacement vers N:\IPXE>" -BackgroundColor Green
	    Write-Host "<Exécution de X:\deployement.bat>" -BackgroundColor Green
	    Set-Location N:\IPXE
        Start-Process X:\deployement.bat
        break
    }

    Else 
    {
        try 
        {
            $url = "http://ipxe.technocite.lan/javascripts/ipxe.php?code=1"
            $output = "X:\deployement.bat"

            $wc = New-Object System.Net.WebClient
            $wc.DownloadFile($url, $output)   
        }
        catch 
        {
            Write-Host "<Impossible de télécharger le fichier via http://ipxe.technocite.lan/javascripts/ipxe.php , nouvelle tentative>" -BackgroundColor Red
            Start-Sleep -Seconds 1
        }

    }
}





