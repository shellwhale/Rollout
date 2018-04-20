Write-Host "Deploying both amd64 and x86" -BackgroundColor Red -ForegroundColor White
Move-Item C:\amd64 C:\Users\$env:USERNAME\winpetests\winbox
Move-Item C:\x86 C:\Users\$env:USERNAME\winpetests\winbox
Copy-Item C:\Users\$env:USERNAME\winpetests\winbox\* C:\Users\$env:USERNAME\winpetests\winbox\