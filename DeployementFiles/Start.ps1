# Création du lecteur réseau N:\ via \\sv-w2k12-pedah.pedagogique.lan\deploiement$
$connected = $false
while($connected -eq $false)
{
    Write-Host "Connexion à \\sv-w2k12-pedah.pedagogique.lan\deploiement$ ..."
    net use n: \\ipxesmb.technocite.lan\scripts$ techn0cite /user:scripts@pedagogique.lan
    if (Test-Path N:\) 
    {
        Write-Host "Lecteur N: monté" -ForegroundColor Green
        $connected = $true
    }
    else 
    {
        Write-Host "Impossible de monter le lecteur Z: via sv-w2k12-pedah.pedagogique.lan\deploiement$" -ForegroundColor Red
    }
}

# Éxécution du script N:\IPXE\Ready.ps1
while($true) 
{
    if (Test-Path N:\IPXE\Ready.ps1) {N:\IPXE\Ready.ps1; break}
    else {Write-Host "Impossible de lancer fichier N:/IPXE/Ready.ps1, il existe au moins ?" -ForegroundColor Red; Start-Sleep -s 1}
}