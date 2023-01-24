#RequireAdmin
#include <File.au3>
#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=SDE.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_Res_Comment=Sempra Energy
#AutoIt3Wrapper_Res_Description=Enable Remote Server Administration Toolkit (RSAT)
#AutoIt3Wrapper_Res_Fileversion=1.1.0.22
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=Sempra Energy
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs --------------------------------------------------------------------------------------------------------
	
	SCRIPT INFORMATION
	
	Language:		AutoIT
	Author:         Charles Keisler
	Company:		Sempra Energy
	URL:			http://www.sempra.com
	License:		Internal Use Only
	Date:			02/19/2013
	Version:		See Above
	
	Script Function:
	Enables All Features Listed in the .LST file by the sem name as the .exe file
	Windows Feature names can be found by running the 'dism /online /get-features' command
	and are case sensitive. This script supresses reboots but a reboot is recommended after running.
	
#ce --------------------------------------------------------------------------------------------------------
AutoItSetOption("MouseCoordMode", 0)
AutoItSetOption("PixelCoordMode", 0)
AutoItSetOption("TrayIconDebug", 1)
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("TrayIconHide", 0)
AutoItSetOption("TrayAutoPause", 0)
AutoItSetOption("TrayMenuMode", 1)
$nVersion = FileGetVersion(@ScriptFullPath)
$strScriptName = StringTrimRight(@ScriptName, 4)
$strLogPath = @TempDir & "\" & $strScriptName & ".log"
$strTitle = "Enabling Windows Features"
Dim $aFeatures
If FileExists($strScriptName & ".lst") Then
	_FileReadToArray($strScriptName & ".lst", $aFeatures)
Else
	MsgBox(16, $strTitle, "Cannot find list" & @CRLF & "please create a file called " & $strScriptName & ".lst in the same foledr as " & @ScriptName & " with a list of windows features to enable")
	Exit
EndIf
ProgressOn($strTitle, $strTitle & "...", "", -1, -1, 16)
For $loop = 1 To $aFeatures[0]
	EnbaleFeature($aFeatures[$loop], $loop, $aFeatures[0])
Next
Func EnbaleFeature($feature, $CommandNumber, $ofNumber)
	ProgressSet(($CommandNumber - 1) / $ofNumber * 100, $feature)
	$retun = RunWait("dism /online /enable-feature /featurename:" & $feature & " /NoRestart", @SystemDir, @SW_HIDE)
	_FileWriteLog($strLogPath, $feature & " reutrned code : " & $retun)
	ProgressSet($CommandNumber / $ofNumber * 100, $feature)
EndFunc   ;==>EnbaleFeature