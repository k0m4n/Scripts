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