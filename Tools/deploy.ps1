Write-Host "Deploying both amd64 and x86" -BackgroundColor Red -ForegroundColor White
Move-Item C:\amd64 C:\Users\Simon\winpetests\winbox
Move-Item C:\x86 C:\Users\Simon\winpetests\winbox
Copy-Item C:\Users\Simon\winpetests\winbox\* C:\Users\Simon\winpetests\winbox\