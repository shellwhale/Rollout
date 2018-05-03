<#
This is a Resource designer script which generates a mof schema for DCPP_POSTBehavior resource in DellBIOSProvider module.


#>

$blockdefinition = New-xDscResourceProperty -name BlockDefinition -Type String -Attribute Key
$category = New-xDscResourceProperty -name Category -Type String -Attribute Write
$autoon = New-xDscResourceProperty -name AutoOn -Type String -Attribute Write  -ValidateSet @("EveryDay", "Disabled", "WeekDays", "SelectDays")
$autoonhour = New-xDscResourceProperty -name AutoOnHr -Type Uint16 -Attribute Write
$autoonminute = New-xDscResourceProperty -name AutoOnMn -Type Uint16 -Attribute Write
$autoonsunday= New-xDscResourceProperty -name AutoOnSun -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$autoonmonday= New-xDscResourceProperty -name AutoOnMon -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$autoontuesday= New-xDscResourceProperty -name AutoOnTue -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$autoonwednesday= New-xDscResourceProperty -name AutoOnWed -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$autoonthursday= New-xDscResourceProperty -name AutoOnThur -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$autoonfriday= New-xDscResourceProperty -name AutoOnFri -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$autoonsaturday= New-xDscResourceProperty -name AutoOnSat -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$deepsleepcontrol = New-xDscResourceProperty -name DeepSleepCtrl -Type String -Attribute Write -ValidateSet @("Disabled", "S5Only", "S4AndS5")
$fanspeedcontrol= New-xDscResourceProperty -name FanSpeed -Type string -Attribute Write  -ValidateSet @("Auto", "High", "Med", "Low", "MedHigh", "MedLow" )
$fanspeedlevel = New-xDscResourceProperty -name FanSpeedLvl -Type Uint16 -Attribute Write
$usbwakesupport= New-xDscResourceProperty -name UsbWake -Type string -Attribute Write  -ValidateSet @("Disabled", "Enabled")
$fancontroloverride= New-xDscResourceProperty -name FanCtrlOvrd -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$acbehavior= New-xDscResourceProperty -name AcPwrRcvry -Type string -Attribute Write  -ValidateSet @("Off", "On", "Last")
$wakeonLAN= New-xDscResourceProperty -name WakeOnLan -Type string -Attribute Write  -ValidateSet @("AddInCard","Onboard", "Disabled", "LanOnly","LanWithPxeBoot", "WlanOnly", "LanWlan" )
$sfpwakeonLAN= New-xDscResourceProperty -name SfpwakeOnLan -Type string -Attribute Write  -ValidateSet @("SFP","LANSFP", "SFPPXE")
$wakeOnAc = New-xDscResourceProperty -name WakeOnAc -Type String -Attribute Write  -ValidateSet @("Disabled", "Enabled")
$wakeOnDock = New-xDscResourceProperty -name WakeOnDock -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$lidSwitch = New-xDscResourceProperty -name LidSwitch -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$blinkPowerSupply1LED = New-xDscResourceProperty -name BlinkPowerSupply1LED -Type string -Attribute Write  -ValidateSet @("Enabled")
$blinkPowerSupply2LED = New-xDscResourceProperty -name BlinkPowerSupply2LED -Type string -Attribute Write  -ValidateSet @("Enabled")
$wlanAutoSense = New-xDscResourceProperty -name WlanAutoSense -Type String -Attribute Write  -ValidateSet @("Disabled", "Enabled")
$wwanAutoSense = New-xDscResourceProperty -name WwanAutoSense -Type String -Attribute Write  -ValidateSet @("Disabled", "Enabled")
$blocksleep= New-xDscResourceProperty -name BlockSleep -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$sleepMode= New-xDscResourceProperty -name SleepMode -Type string -Attribute Write  -ValidateSet @("OSAutomaticSelection", "ForceS3")
$primarybatterychargeconfiguration= New-xDscResourceProperty -name PrimaryBattChargeCfg -Type string -Attribute Write  -ValidateSet @("Auto", "Standard", "Express", "PrimAcUse", "Custom"  )
$customChargeStart = New-xDscResourceProperty -name CustomChargeStart -Type Uint16 -Attribute Write
$customChargeEnd = New-xDscResourceProperty -name CustomChargeStop -Type Uint16 -Attribute Write
$batteryslicechargeconfiguration= New-xDscResourceProperty -name SliceBattChargeCfg -Type string -Attribute Write  -ValidateSet @("Standard", "Express")
$modbatteryconfiguration= New-xDscResourceProperty -name ModBattChargeCfg -Type string -Attribute Write  -ValidateSet @("Standard", "Express")
$dockbatteryconfiguration= New-xDscResourceProperty -name DockBatteryChargeConfiguration -Type string -Attribute Write  -ValidateSet @("Standard", "Express")
$intelsmartconnect= New-xDscResourceProperty -name IntlSmartConnect -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$intelreadymode= New-xDscResourceProperty -name IntelReadyModeEn -Type string -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$peakshift = New-xDscResourceProperty -name PeakShiftCfg -Type String -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$peakshiftbatterythreshold = New-xDscResourceProperty -name PeakShiftBatteryThreshold -Type Uint16 -Attribute Write
$peakshiftdayconfiguration = New-xDscResourceProperty -name PeakShiftDayConfiguration -Type String -Attribute Write  
$starttime = New-xDscResourceProperty -name StartTime -Type String -Attribute Write
$endtime = New-xDscResourceProperty -name EndTime -Type String -Attribute Write
$chargestarttime = New-xDscResourceProperty -name ChargeStartTime -Type String -Attribute Write
$advancedbatterychargingmode = New-xDscResourceProperty -name AdvBatteryChargeCfg -Type String -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$advancedbatterychargeconfiguration = New-xDscResourceProperty -name AdvancedBatteryChargeConfiguration -Type String -Attribute Write
$typeCOverload = New-xDscResourceProperty -name Type_CBatteryOverloadProtection -Type String -Attribute Write  -ValidateSet @("7.5Watts", "15Watts")
$beginningofday = New-xDscResourceProperty -name BeginningOfDay -Type String -Attribute Write
$workperiod = New-xDscResourceProperty -name WorkPeriod -Type String -Attribute Write
$docksupportonbattery = New-xDscResourceProperty -name DockSupportOnBattery -Type String -Attribute Write  -ValidateSet @("Enabled", "Disabled")
$Password = New-xDscResourceProperty -Name Password -Type string -Attribute Write -Description "Password"
$SecurePassword = New-xDscResourceProperty -Name SecurePassword -Type string -Attribute Write -Description "SecurePassword"
$PathToKey = New-xDscResourceProperty -Name PathToKey -Type string -Attribute Write

$properties = @($blockdefinition,$category,$autoon,$autoonhour,$autoonminute,$autoonsunday,$autoonmonday,$autoontuesday,$autoonwednesday,$autoonthursday,$autoonfriday,$autoonsaturday,$deepsleepcontrol,$fanspeedcontrol,$fanspeedlevel,$usbwakesupport,$fancontroloverride,$acbehavior,$wakeonLAN,$sfpwakeonLAN,$wakeOnAc,$wakeOnDock,$lidSwitch,$blinkPowerSupply1LED,$blinkPowerSupply2LED,$wlanAutoSense,$wwanAutoSense,$blocksleep,$sleepMode,$primarybatterychargeconfiguration,$customChargeStart,$customChargeEnd,$batteryslicechargeconfiguration,$modbatteryconfiguration,$dockbatteryconfiguration,$intelsmartconnect,$intelreadymode,$peakshift,$peakshiftbatterythreshold,$peakshiftdayconfiguration,$starttime,$endtime,$chargestarttime,$advancedbatterychargingmode,$advancedbatterychargeconfiguration,$typeCOverload,$beginningofday,$workperiod,$docksupportonbattery,$Password,$SecurePassword,$PathToKey)

New-xDscResource -ModuleName DellBIOSProviderX86 -Name DCPP_PowerManagement -Property $properties -Path 'C:\Program Files\WindowsPowerShell\Modules' -FriendlyName "PowerManagement" -Force -Verbose

# SIG # Begin signature block
# MIIVSQYJKoZIhvcNAQcCoIIVOjCCFTYCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCA2jN+0I7R201Wi
# k/tQQzhHP6jnl+os0P/q8WfTBgoKKKCCCiMwggTCMIIDqqADAgECAhANhLMrA8kb
# dRADSKysMihfMA0GCSqGSIb3DQEBCwUAMH8xCzAJBgNVBAYTAlVTMR0wGwYDVQQK
# ExRTeW1hbnRlYyBDb3Jwb3JhdGlvbjEfMB0GA1UECxMWU3ltYW50ZWMgVHJ1c3Qg
# TmV0d29yazEwMC4GA1UEAxMnU3ltYW50ZWMgQ2xhc3MgMyBTSEEyNTYgQ29kZSBT
# aWduaW5nIENBMB4XDTE2MDEyMDAwMDAwMFoXDTE5MDIxODIzNTk1OVowWjELMAkG
# A1UEBhMCVVMxDjAMBgNVBAgTBVRleGFzMRMwEQYDVQQHEwpSb3VuZCBSb2NrMRIw
# EAYDVQQKFAlEZWxsIEluYy4xEjAQBgNVBAMUCURlbGwgSW5jLjCCASIwDQYJKoZI
# hvcNAQEBBQADggEPADCCAQoCggEBAIiB7p20xoJ8RMmDhIKNR/g0X6OhJWWiaLL6
# OY8sCfY9B8BhCOKzCgNQU+g5Jdu5GZ+J7G8S7evlJfhskLH4fhkGYjn4a1sPw/mD
# m/qMaE4n9WLaRourdOIIWgYftCGmjrlpTq7d4rYZ+Oo+iaQTR1OIrnJ7UbV6YYKp
# /buZ3pcrWAB7ox3UDeH/UigGP+QIix5mQrRmQLgZyJkg5V9EB/m2HYmQ+w13VNIf
# adxPklaF1sNMJTRwzKzqZru4N7goue63NAu8COhQ9+c8MIom+VjDVuDR01UY25vQ
# IVJ8Sbk3ORD20Eb6a7ZxVb29Lkn6/cOccCf6tuAe7sd9skZAbJsCAwEAAaOCAV0w
# ggFZMAkGA1UdEwQCMAAwDgYDVR0PAQH/BAQDAgeAMCsGA1UdHwQkMCIwIKAeoByG
# Gmh0dHA6Ly9zdi5zeW1jYi5jb20vc3YuY3JsMGEGA1UdIARaMFgwVgYGZ4EMAQQB
# MEwwIwYIKwYBBQUHAgEWF2h0dHBzOi8vZC5zeW1jYi5jb20vY3BzMCUGCCsGAQUF
# BwICMBkMF2h0dHBzOi8vZC5zeW1jYi5jb20vcnBhMBMGA1UdJQQMMAoGCCsGAQUF
# BwMDMFcGCCsGAQUFBwEBBEswSTAfBggrBgEFBQcwAYYTaHR0cDovL3N2LnN5bWNk
# LmNvbTAmBggrBgEFBQcwAoYaaHR0cDovL3N2LnN5bWNiLmNvbS9zdi5jcnQwHwYD
# VR0jBBgwFoAUljtT8Hkzl699g+8uK8zKt4YecmYwHQYDVR0OBBYEFIb5/xrKh87H
# XzS6cRL1o7LqbfaDMA0GCSqGSIb3DQEBCwUAA4IBAQCFWAnqZghMKytZjfSKt94F
# eB/VfyFl+3tWhPN8SFkXUdIDljd3t5dggtIYAc7TPKfOr8JngIRQmM0lOyj/bzOM
# Chdb8nEbKV4R6krbF423gSVFcYoZsiCoqV2An5OrnnRDPPmgWs5wJvgwk/iGeEYE
# /DQE8J0hWVr4tTQVKRaCBM4DVfK4Z2Mp5BAewp9jxvDS/cuguTQdQP+mtYxmkkXU
# SyTq+olOm8YVPAw0tpRGbZjPdxK2++EIeVrTL7jscqhuMx8d985A4corhmQdZ7Un
# qTurFTSdgqxqZeJiYVFqhp1c9wbCwFuCSTyJiissW+BC4lt+N2oFOSieit7gnmP8
# MIIFWTCCBEGgAwIBAgIQPXjX+XZJYLJhffTwHsqGKjANBgkqhkiG9w0BAQsFADCB
# yjELMAkGA1UEBhMCVVMxFzAVBgNVBAoTDlZlcmlTaWduLCBJbmMuMR8wHQYDVQQL
# ExZWZXJpU2lnbiBUcnVzdCBOZXR3b3JrMTowOAYDVQQLEzEoYykgMjAwNiBWZXJp
# U2lnbiwgSW5jLiAtIEZvciBhdXRob3JpemVkIHVzZSBvbmx5MUUwQwYDVQQDEzxW
# ZXJpU2lnbiBDbGFzcyAzIFB1YmxpYyBQcmltYXJ5IENlcnRpZmljYXRpb24gQXV0
# aG9yaXR5IC0gRzUwHhcNMTMxMjEwMDAwMDAwWhcNMjMxMjA5MjM1OTU5WjB/MQsw
# CQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNV
# BAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxMDAuBgNVBAMTJ1N5bWFudGVjIENs
# YXNzIDMgU0hBMjU2IENvZGUgU2lnbmluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQAD
# ggEPADCCAQoCggEBAJeDHgAWryyx0gjE12iTUWAecfbiR7TbWE0jYmq0v1obUfej
# DRh3aLvYNqsvIVDanvPnXydOC8KXyAlwk6naXA1OpA2RoLTsFM6RclQuzqPbROlS
# Gz9BPMpK5KrA6DmrU8wh0MzPf5vmwsxYaoIV7j02zxzFlwckjvF7vjEtPW7ctZlC
# n0thlV8ccO4XfduL5WGJeMdoG68ReBqYrsRVR1PZszLWoQ5GQMWXkorRU6eZW4U1
# V9Pqk2JhIArHMHckEU1ig7a6e2iCMe5lyt/51Y2yNdyMK29qclxghJzyDJRewFZS
# AEjM0/ilfd4v1xPkOKiE1Ua4E4bCG53qWjjdm9sCAwEAAaOCAYMwggF/MC8GCCsG
# AQUFBwEBBCMwITAfBggrBgEFBQcwAYYTaHR0cDovL3MyLnN5bWNiLmNvbTASBgNV
# HRMBAf8ECDAGAQH/AgEAMGwGA1UdIARlMGMwYQYLYIZIAYb4RQEHFwMwUjAmBggr
# BgEFBQcCARYaaHR0cDovL3d3dy5zeW1hdXRoLmNvbS9jcHMwKAYIKwYBBQUHAgIw
# HBoaaHR0cDovL3d3dy5zeW1hdXRoLmNvbS9ycGEwMAYDVR0fBCkwJzAloCOgIYYf
# aHR0cDovL3MxLnN5bWNiLmNvbS9wY2EzLWc1LmNybDAdBgNVHSUEFjAUBggrBgEF
# BQcDAgYIKwYBBQUHAwMwDgYDVR0PAQH/BAQDAgEGMCkGA1UdEQQiMCCkHjAcMRow
# GAYDVQQDExFTeW1hbnRlY1BLSS0xLTU2NzAdBgNVHQ4EFgQUljtT8Hkzl699g+8u
# K8zKt4YecmYwHwYDVR0jBBgwFoAUf9Nlp8Ld7LvwMAnzQzn6Aq8zMTMwDQYJKoZI
# hvcNAQELBQADggEBABOFGh5pqTf3oL2kr34dYVP+nYxeDKZ1HngXI9397BoDVTn7
# cZXHZVqnjjDSRFph23Bv2iEFwi5zuknx0ZP+XcnNXgPgiZ4/dB7X9ziLqdbPuzUv
# M1ioklbRyE07guZ5hBb8KLCxR/Mdoj7uh9mmf6RWpT+thC4p3ny8qKqjPQQB6rqT
# og5QIikXTIfkOhFf1qQliZsFay+0yQFMJ3sLrBkFIqBgFT/ayftNTI/7cmd3/SeU
# x7o1DohJ/o39KK9KEr0Ns5cF3kQMFfo2KwPcwVAB8aERXRTl4r0nS1S+K4ReD6bD
# dAUK75fDiSKxH3fzvc1D1PFMqT+1i4SvZPLQFCExggp8MIIKeAIBATCBkzB/MQsw
# CQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAdBgNV
# BAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxMDAuBgNVBAMTJ1N5bWFudGVjIENs
# YXNzIDMgU0hBMjU2IENvZGUgU2lnbmluZyBDQQIQDYSzKwPJG3UQA0isrDIoXzAN
# BglghkgBZQMEAgEFAKCBrDAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgor
# BgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQg1NUU3Ni+
# C9bHDg0RWVomzY8kNoM9Z+YcEFv1faM4JxAwQAYKKwYBBAGCNwIBDDEyMDCgFoAU
# AEQAZQBsAGwALAAgAEkAbgBjAC6hFoAUaHR0cDovL3d3dy5kZWxsLmNvbSAwDQYJ
# KoZIhvcNAQEBBQAEggEAF6fGwBbgZ4W8w3jQUciDrPXGF0CjJjTnG1JwY4Q5PqCD
# qCxqTXYaW/vy8yUIfQgUQgfhpnbOBgqNa0OWatBWLjmJ0wFp3FcbUm3+oFezL0k6
# gK5/Xxh5qnAOPbnuJdytIeFGygD230IqmXA2PrrUW8ySgoIOcZ9PZk0J27DP++7B
# z+pHg9mcOLBgzhfK3OCpw8AHo3LywpNQNSFYaRMpT3rRLMbb12YACADYSBVDu9Yk
# 3jtI2L7RN7Rg1805g6iSATvAuurXy9CZNfZ++CbgEJrQ0qTjdgpLA7H8oQsBMKzG
# keDCtIlXR+FE6teI9Ql6WHtkMqFme2WN4xX2osQsyaGCCAowgggGBgorBgEEAYI3
# AwMBMYIH9jCCB/IGCSqGSIb3DQEHAqCCB+MwggffAgEDMQ8wDQYJYIZIAWUDBAIB
# BQAwbQYLKoZIhvcNAQkQAQSgXgRcMFoCAQEGCmCGSAGG/W4BBxgwMTANBglghkgB
# ZQMEAgEFAAQgzu7IKNXsLTaCOH/rHPMorY0OXApDFfy08izf5bRmfwsCBRnc4rFt
# GA8yMDE3MTEyMjA4NDgwOFqgggTxMIIE7TCCA9WgAwIBAgIIPG49fSM2JU0wDQYJ
# KoZIhvcNAQELBQAwgY8xCzAJBgNVBAYTAlVTMRAwDgYDVQQIEwdBcml6b25hMRMw
# EQYDVQQHEwpTY290dHNkYWxlMSUwIwYDVQQKExxTdGFyZmllbGQgVGVjaG5vbG9n
# aWVzLCBJbmMuMTIwMAYDVQQDEylTdGFyZmllbGQgUm9vdCBDZXJ0aWZpY2F0ZSBB
# dXRob3JpdHkgLSBHMjAeFw0xNjEyMTMwNzAwMDBaFw0yMTEyMTMwNzAwMDBaMIGI
# MQswCQYDVQQGEwJVUzEQMA4GA1UECBMHQXJpem9uYTETMBEGA1UEBxMKU2NvdHRz
# ZGFsZTElMCMGA1UEChMcU3RhcmZpZWxkIFRlY2hub2xvZ2llcywgSW5jLjErMCkG
# A1UEAxMiU3RhcmZpZWxkIFRpbWVzdGFtcCBBdXRob3JpdHkgLSBHMjCCASIwDQYJ
# KoZIhvcNAQEBBQADggEPADCCAQoCggEBAMMSt+zDfQd/+EDESIH4xIOLzJkCgOFq
# yWKYMsVjvYH7vCdlU0EAGu2AlzYiIjKbaGYLbQFtOf+ohaiLl6ewX04FImdW6c97
# 5Uoie+XnMGYOVySnWHIXv/q6fFX7Rgwh50vOMCDuKHCCpx3MrYU5g0kP3J+Psv9j
# E2Nc0jkOeHQadrpVTo8HGCWoz7XCLFIfCdjjWkoDLu4B0/9yehNaC+ZwrOy9cnUE
# NhnE/+0WMIoUdOLkD/Eq24ATVBVXBe7Q3o4/7hzYWPoABigrHpB6q1u1ILpB+Ze2
# K3rdWz4t93k+yqCybnZVFKuJZy53VS4PDszfiRHfIEZo2TZGBgIVfX8CAwEAAaOC
# AVAwggFMMAwGA1UdEwEB/wQCMAAwDgYDVR0PAQH/BAQDAgbAMBYGA1UdJQEB/wQM
# MAoGCCsGAQUFBwMIMB0GA1UdDgQWBBTFhkohftnytX2hAaysXl3+FYL3vzAfBgNV
# HSMEGDAWgBR8DDIfp9kwf8R9aKNiqKHOqwdbJzA6BggrBgEFBQcBAQQuMCwwKgYI
# KwYBBQUHMAGGHmh0dHA6Ly9vY3NwLnN0YXJmaWVsZHRlY2guY29tLzBGBgNVHR8E
# PzA9MDugOaA3hjVodHRwOi8vY3JsLnN0YXJmaWVsZHRlY2guY29tL3JlcG9zaXRv
# cnkvc2Zyb290LWcyLmNybDBQBgNVHSAESTBHMEUGC2CGSAGG/W4BBxcCMDYwNAYI
# KwYBBQUHAgEWKGh0dHA6Ly9jcmwuc3RhcmZpZWxkdGVjaC5jb20vcmVwb3NpdG9y
# eS8wDQYJKoZIhvcNAQELBQADggEBAC1Tnm2HG1bh1d39Qe2NWq9CxxtZRHG3BR0h
# jgVznfEgv9I7fSQrnKbuE1q03r7BkLyZ57qQPIHN7Sm/DtfRpQ/XzO3V/SKcXcHp
# LSZNjCX38cTr4Bpnk0TzQFtCYiFGjEY66pvDLKOLdkpXqfdZjxCyhpAArlcH9EhO
# HEMjXDgJnurEtSG4G5RpS1/hA6BDI6+v/rgTCEuKUVCVMwkUWF5+elrNt2UN2SJA
# uwRwoYddTw3w68FU6YlPydL9DGxdS8UzP4udpfkuZGekvHm2nikbD+4J7NDXm4k9
# c2NzMwbdVlg7LDCoqVntapOQqZS4XMqSD6/eo/X14FBwhx4tB60xggJjMIICXwIB
# ATCBnDCBjzELMAkGA1UEBhMCVVMxEDAOBgNVBAgTB0FyaXpvbmExEzARBgNVBAcT
# ClNjb3R0c2RhbGUxJTAjBgNVBAoTHFN0YXJmaWVsZCBUZWNobm9sb2dpZXMsIElu
# Yy4xMjAwBgNVBAMTKVN0YXJmaWVsZCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0
# eSAtIEcyAgg8bj19IzYlTTANBglghkgBZQMEAgEFAKCBmDAaBgkqhkiG9w0BCQMx
# DQYLKoZIhvcNAQkQAQQwHAYJKoZIhvcNAQkFMQ8XDTE3MTEyMjA4NDgwOFowKwYL
# KoZIhvcNAQkQAgwxHDAaMBgwFgQUcUS1PxpdOR3drHG2ByGQjJsb8/YwLwYJKoZI
# hvcNAQkEMSIEIB+HAKzETOYcFKf4+XfnahkYa6jHLZp6pCF0o19U7WKWMA0GCSqG
# SIb3DQEBAQUABIIBAG/0n0gR9smrLpYBpN7dUM2iNcZfRJ69dK/erKBSmuB9Nn92
# AtzrKFfX3WaPKyiFX33j9Z0EOHgKxh9Z/kZTaZNqH7kWI8MUUsCIcA3HD16qxZNR
# J1DdsEntWMoLMYhSBBFrRJ/GcN8uP0JJ6WD+P00ukf2+xOW08ao1rKTYVY/MI6fg
# dsALuVrfVgVleYNR7DeEDI/ueOTXBsIuKLtu73tS/xkvjwzWgbbq8+fl9T2mewB+
# puq6WGWscH7SieSgWT2V6HnUpPtkXqy9eQF98ODowH6IAKpl3Y5L6ljVvFe2LwhA
# E1bKQF+ED+JthV5LonNiGF2Wym/82dNsiNrU/8g=
# SIG # End signature block
