Write-Host "Deploying both amd64 and x86" -BackgroundColor Red -ForegroundColor White
move ./Winbox/amd64 C:\Users\Simon\winpetests\winbox
move ./Winbox/x86 C:\Users\Simon\winpetests\winbox
cp ./Winbox/wimboot C:\Users\Simon\winpetests\winbox