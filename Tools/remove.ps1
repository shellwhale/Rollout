Write-Host "Removing Winbox" -BackgroundColor Red -ForegroundColor White
Remove-Item C:\Users\$env:USERNAME\Desktop\Rollout\Winbox\amd64 -Force
Remove-Item C:\Users\$env:USERNAME\Desktop\Rollout\Winbox\x86 -Force
Remove-Item C:\Users\$env:USERNAME\winpetests\Winbox\* -Force