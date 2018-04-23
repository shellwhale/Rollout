Write-Host "Montage du lecteur N:" -BackgroundColor Magenta
net use n: \\ipxesmb.technocite.lan\scripts$ techn0cite /user:scripts@pedagogique.lan # à remplacer avec Powershell et catch l'erreur
Write-Host  "Au travail ! Lancement de N:\IPXE\Ready.ps1" 

while($true)
{
    try { N:\IPXE\Ready.ps1 ; break}
    catch 
    {
        Write-Host "Impossible de lancer fichier Ready.ps1, il existe au moins ?"
        Write-Host "Nouvelle tentative" -BackgroundColor Red
        Start-Sleep -s 1
    }
}