#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Description=Clean out all cached windows credentials
#AutoIt3Wrapper_Res_Fileversion=1.1.0.8
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Tidy_Stop_OnError=n
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------
	
	SCRIPT INFORMATION
	
	Language:		AutoIT
	Author:        k0m4n
	License:		GNU\GPLv3
	Date:			1/5/2013
	Version:		1.x
	
	Script Function:
	Clean out all windows credentials
	
#ce ----------------------------------------------------------------------------
#include <File.au3>
#include <array.au3>
#RequireAdmin
AutoItSetOption("MouseCoordMode", 0)
AutoItSetOption("PixelCoordMode", 0)
AutoItSetOption("TrayIconDebug", 1)
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("TrayIconHide", 0)
AutoItSetOption("TrayAutoPause", 0)
AutoItSetOption("TrayMenuMode", 1)
$nVersion = FileGetVersion(@ScriptFullPath)
$strScriptName = StringTrimRight(@ScriptName, 4)
$strLogFile = @TempDir & "\" & StringTrimRight(@ScriptName, 4) & ".log"

$aryCommonDesktop = StringSplit(@DesktopCommonDir, "\", 1)

Dim $strProfilesRoot
For $nLoop = 1 To $aryCommonDesktop[0] - 2
	$strProfilesRoot &= $aryCommonDesktop[$nLoop]
	If $nLoop < $aryCommonDesktop[0] - 2 Then
		$strProfilesRoot &= "\"
	EndIf
Next
_FileWriteLog($strLogFile, "Profiles Root Found at: " & $strProfilesRoot)
;MsgBox(0, "", "$strProfilesRoot = " & $strProfilesRoot)

Dim $aryProfilelist
$aryProfilelist = _FileListToArray($strProfilesRoot, "*", 2)
Switch $strProfilesRoot
	Case "C:\Users"
		For $nLoop = 1 To $aryProfilelist[0]
			$return = DirRemove($strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\AppData\Local\Microsoft\Credentials", 1)
			If $return = 1 Then
				_FileWriteLog($strLogFile, "Deleted Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\AppData\Local\Microsoft\Credentials")
			Else
				_FileWriteLog($strLogFile, "Error Deleting Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\AppData\Local\Microsoft\Credentials or directory does not exist")
			EndIf
			$return = DirRemove($strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\AppData\Roaming\Microsoft\Credentials", 1)
			If $return = 1 Then
				_FileWriteLog($strLogFile, "Deleted Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\AppData\Roaming\Microsoft\Credentials")
			Else
				_FileWriteLog($strLogFile, "Error Deleting Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\AppData\Roaming\Microsoft\Credentials or directory does not exist")
			EndIf
		Next
	Case "C:\Documents and Settings"
		For $nLoop = 1 To $aryProfilelist[0]
			$return = DirRemove($strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\Application Data\Local\Microsoft\Credentials", 1)
			If $return = 1 Then
				_FileWriteLog($strLogFile, "Deleted Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\Application Data\Local\Microsoft\Credentials")
			Else
				_FileWriteLog($strLogFile, "Error Deleting Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\Application Data\Local\Microsoft\Credentials or directory does not exist")
			EndIf
			$retun = DirRemove($strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\Local Settings\Application Data\Roaming\Microsoft\Credentials", 1)
			If $return = 1 Then
				_FileWriteLog($strLogFile, "Deleted Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\Local Settings\Application Data\Local\Microsoft\Credentials")
			Else
				_FileWriteLog($strLogFile, "Error Deleting Credential foleder at : " & $strProfilesRoot & "\" & $aryProfilelist[$nLoop] & "\Local Settings\Application Data\Local\Microsoft\Credentials or directory does not exist")
			EndIf
		Next
EndSwitch