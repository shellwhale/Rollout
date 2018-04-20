@echo off
wpeinit
Wpeutil DisableFirewall

powershell Set-ExecutionPolicy -ExecutionPolicy Bypass
powershell Start.ps1