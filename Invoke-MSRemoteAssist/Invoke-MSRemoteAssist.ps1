# Invoke-MSRemoteAssist.ps1
# Author : k0m4n
#
# This script is used to launch the Remote Assistance tool on a Windows system. 
# The script first checks if the Quick Assist app is installed by querying the AppxPackage for "MicrosoftCorporationII.QuickAssist". 
# If it exists, it starts the app. If not, it checks for the presence of the "quickassist.exe" file in the system32 folder and starts it if it is present. 
# If neither of those are found, it starts the "msra.exe" file with the argument "/geteasyhelp". 
# The Remote Assistance tool allows a user to remotely connect to and control another user's computer to provide technical assistance.


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