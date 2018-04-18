Write-Host "TEST DE LA CONNEXION RESEAU ..." -ForegroundColor Yellow 

while($true)
{
    If (Test-Connection ipxe.technocite.lan -Count 1) {Write-Host "RESEAU OK" -BackgroundColor Green -ForegroundColor Darkblue; break} 

    Else {Write-Host "PAS DE RESEAU - NOUVELLE TENTATIVE ..." -BackgroundColor Red -ForegroundColor White; Start-Sleep -Seconds 1}
}


Write-Host 
net use n: \\ipxesmb.technocite.lan\scripts$ techn0cite /user:scripts@pedagogique.lan

Set-Location n:\ipxe\
New-Item -Path "x:\scripts" -ItemType Directory
Copy-Item *.ps1 x:\scripts\ 

Start-Process n:\ipxe\VNC\winvnc.exe
Start-Process "x:\scripts\capture.ps1" -WindowStyle Minimized

Write-Host "DOWNLOAD DU SCRIPT A LANCER ..." -ForegroundColor Yellow 

While($true)
{
    if (Test-Path x:\script.bat) 
    {  
    Write-Host "LANCEMENT DU SCRIPT" -ForegroundColor Green
    break
    }

    else 
    {

    $url = "http://ipxe.technocite.lan/javascripts/ipxe.php?code=1"
    $output = "x:\script.bat"

    $wc = New-Object System.Net.WebClient
    $wc.DownloadFile($url, $output)

    }
}

Start-Process x:\script.bat

