Write-Host "Removing Winbox" -BackgroundColor Red -ForegroundColor White
Remove-Item C:\Users\Simon\Desktop\Rollout\Winbox\amd64 -Force
Remove-Item C:\Users\Simon\Desktop\Rollout\Winbox\x86 -Force
Remove-Item C:\Users\Simon\winpetests\Winbox\* -Force