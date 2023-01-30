# Check if the script is running with elevated permissions
if(-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")){
  Write-Host "This script must be run with administrator privileges. Please re-run as an administrator."
  exit
}

$nVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo((Get-Command $MyInvocation.MyCommand).Path).FileVersion
$strScriptName = $MyInvocation.MyCommand.Name.TrimEnd(".ps1")
$strLogFile = "$env:TEMP\$strScriptName.log"

$aryCommonDesktop = $env:USERPROFILE.Split("\")
$strProfilesRoot = [String]::Join("\", $aryCommonDesktop[0..($aryCommonDesktop.Length - 3)])

Write-Output "Profiles Root Found at: $strProfilesRoot" | Out-File -FilePath $strLogFile -Append

$aryProfilelist = Get-ChildItem $strProfilesRoot | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty Name

switch ($strProfilesRoot) {
    'C:\Users' {
        foreach ($profile in $aryProfilelist) {
            $path1 = "$strProfilesRoot\$profile\AppData\Local\Microsoft\Credentials"
            $path2 = "$strProfilesRoot\$profile\AppData\Roaming\Microsoft\Credentials"
            if (Test-Path $path1) {
                Remove-Item $path1 -Recurse -Force | Out-Null
                Write-Output "Deleted Credential folder at: $path1" | Out-File -FilePath $strLogFile -Append
            } else {
                Write-Output "Error Deleting Credential folder at: $path1 or directory does not exist" | Out-File -FilePath $strLogFile -Append
            }
            if (Test-Path $path2) {
                Remove-Item $path2 -Recurse -Force | Out-Null
                Write-Output "Deleted Credential folder at: $path2" | Out-File -FilePath $strLogFile -Append
            } else {
                Write-Output "Error Deleting Credential folder at: $path2 or directory does not exist" | Out-File -FilePath $strLogFile -Append
            }
        }
    }
    'C:\Documents and Settings' {
        foreach ($profile in $aryProfilelist) {
            $path1 = "$strProfilesRoot\$profile\Application Data\Local\Microsoft\Credentials"
            $path2 = "$strProfilesRoot\$profile\Application Data\Microsoft\Credentials"
            if (Test-Path $path1) {
                Remove-Item $path1 -Recurse -Force | Out-Null
                Write-Output "Deleted Credential folder at: $path1" | Out-File -FilePath $strLogFile -Append
            } else {
                Write-Output "Error Deleting Credential folder at: $path1 or directory does not exist" | Out-File -File $strLogFile -Append
                 }
        }
    }
}