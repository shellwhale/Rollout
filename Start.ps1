Write-Host "Montage du lecteur N:" -BackgroundColor Magenta
net use n: \\ipxesmb.technocite.lan\scripts$ techn0cite /user:scripts@pedagogique.lan # à remplacer avec Powershell et catch l'erreur
Write-Host  "Paré à bosser ! Exécution du fichier N:\IPXE\Ready.ps1" 

while($true)
{
    try { N:\IPXE\Ready.ps1 ; break}
    catch 
    {
        Write-Host "Impossible d'exécuter le fichier Ready.ps1, il est là au moins ?"
        Write-Host "Nouvelle tentative" -BackgroundColor Red
        Start-Sleep -s 1
    }
}


