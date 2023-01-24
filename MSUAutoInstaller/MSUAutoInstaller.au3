#RequireAdmin
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Description=Automaticly Install WSU Updates In Current Folder
#AutoIt3Wrapper_Res_Fileversion=1.0.0.24
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include <array.au3>
#cs ----------------------------------------------------------------------------
	
	SCRIPT INFORMATION
	
	Language:		AutoIT
	Author:         k0m4n
	License:		GNU\GPLv3
	Date:			02/19/2013
	Version:		See Above
	
	Script Function:
	Automaticly Install WSU Updates In Current Folder
	
#ce ----------------------------------------------------------------------------
AutoItSetOption("MouseCoordMode", 0)
AutoItSetOption("PixelCoordMode", 0)
AutoItSetOption("TrayIconDebug", 1)
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("TrayIconHide", 0)
AutoItSetOption("TrayAutoPause", 0)
AutoItSetOption("TrayMenuMode", 1)
$nVersion = FileGetVersion(@ScriptFullPath)
$strScriptName = StringTrimRight(@ScriptName, 4)
$strLogfile = @TempDir & "\" & $strScriptName & ".log"
; Script Start - Add your code below here
Dim $aUpdates
$aUpdates = _FileListToArray(@ScriptDir, "*.msu", 1)
$kernelver = StringLeft(FileGetVersion(@WindowsDir & "\system32\ntoskrnl.exe"), 3)
ProgressOn($strScriptName, "Installing Upates...", "", -1, -1, 16)
For $loop = 1 To $aUpdates[0]
	ProgressSet(($loop - 1) / $aUpdates[0] * 100, $aUpdates[$loop] & @CRLF & Round(($loop - 1) / $aUpdates[0] * 100) & "%")
	If StringInStr($aUpdates[$loop], @OSArch) And StringInStr($aUpdates[$loop], $kernelver) Then
		_FileWriteLog($strLogfile, "Installing Update: " & $aUpdates[$loop])
		$return = RunWait("wusa " & $aUpdates[$loop] & " /quiet /norestart")
		_FileWriteLog($strLogfile, "Update Returned Code: " & $return)
	Else
		_FileWriteLog($strLogfile, "Skipping Update: " & $aUpdates[$loop])
	EndIf
	ProgressSet($loop / $aUpdates[0] * 100, $aUpdates[$loop] & @CRLF & Round($loop / $aUpdates[0] * 100) & "%")
Next
ProgressOff()