# Invoke-MSRemoteAssist.ps1
# Requres Windows 7 or newer 
# Locates the newest Bulit-In Remote Asstance Tool and launches it in PIN mode

$quickassist = "$env:windir\system32\quickassist.exe"
$msra = "$env:windir\system32\msra.exe"
If(Test-Path $quickassist)
{
    Start-Process $quickassist
}
else
{
    Start-Process $msra -ArgumentList "/geteasyhelp"
}