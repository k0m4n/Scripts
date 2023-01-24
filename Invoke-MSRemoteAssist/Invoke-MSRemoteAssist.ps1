# Invoke-MSRemoteAssist.ps1
# Author : k0m4n
# Requres Windows 7 or newer 
# Locates the newest Bulit-In Remote Asstance Tool and launches it in PIN mode

$APPXQassist = Get-AppxPackage MicrosoftCorporationII.QuickAssist
$quickassist = "$env:windir\system32\quickassist.exe"
$msra = "$env:windir\system32\msra.exe"
IF($APPXQassist)
{
    Start-Process shell:AppsFolder\MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe!App
}
ElseIf(Test-Path $quickassist)
{
    Start-Process $quickassist
}
else
{
    Start-Process $msra -ArgumentList "/geteasyhelp"
}