#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=USMT.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=User State Migration Tool (USMT)
#AutoIt3Wrapper_Res_Description=User State Migration Tool (USMT)
#AutoIt3Wrapper_Res_Fileversion=2.2.2.67
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
;#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Tidy_Stop_OnError=n
;#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	SCRIPT INFORMATION

	Language:		AutoIT
	Author:         k0m4n
	Licence:		GNU\GPLv3
	Date:			05/06/2014
	Version:		See Above

	Script Function:
	GUI for User State Migration Tool (USMT)

#ce ----------------------------------------------------------------------------
;AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("MouseCoordMode", 0)
AutoItSetOption("PixelCoordMode", 0)
AutoItSetOption("TrayIconDebug", 1)
AutoItSetOption("WinTitleMatchMode", 4)
AutoItSetOption("TrayIconHide", 0)
AutoItSetOption("TrayAutoPause", 0)
AutoItSetOption("TrayMenuMode", 1)
; Script Start - Add your code below here
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <file.au3>
#include <array.au3>
;windows comatibility check
If @Compiled Then
	$nVersion = FileGetVersion(@ScriptFullPath)
Else
	$nVersion = "(SOURCE CODE)"
EndIf
#cs
$titlebar = StringTrimRight(@ScriptName, 4) & "  " & $nVersion
If @OSArch = "x64" And @AutoItX64 = 0 Then
	MsgBox(16, $titlebar, "You must run the 64-Bit version")
	Exit
EndIf
$nNtVerion = FileGetVersion(@WindowsDir & "\system32\ntoskrnl.exe")
Select
	Case $nNtVerion <= 5.1
		MsgBox(16, $titlebar, "Only Windows XP and wewer are supported")
		Exit
	Case $nNtVerion >= 6.2
		MsgBox(16, $titlebar, "Windows 8 Is not supported yet")
		Exit
EndSelect
#ce
#Region ### START Koda GUI section ### Form=.\frmmain.kxf
$frmMain = GUICreate("USMT", 349, 108, -1, -1)
$rdoScanstate = GUICtrlCreateRadio("ScanState", 8, 6, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$rdoLoadstate = GUICtrlCreateRadio("LoadState", 136, 6, 113, 17)
$txtNUCPath = GUICtrlCreateInput("\\NAS\Share\" & @ComputerName, 64, 34, 185, 21)
$lbltxtUNCPath = GUICtrlCreateLabel("Data Path", 8, 36, 52, 17)
$cmdUNCPathBrowse = GUICtrlCreateButton("Browse", 256, 32, 83, 25)
$txtPassword = GUICtrlCreateInput("", 88, 62, 161, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_PASSWORD))
GUICtrlSetState(-1, $GUI_DISABLE)
$chkEncrypt = GUICtrlCreateCheckbox("Encryption*", 8, 64, 73, 17)
$chkCompress = GUICtrlCreateCheckbox("Compression", 256, 64, 81, 17)
$cmdRun = GUICtrlCreateButton("RUN", 256, 1, 83, 26, $BS_DEFPUSHBUTTON)
$lblEncryption = GUICtrlCreateLabel("*Encryption is required on all portable drives!", 8, 88, 212, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

			; Scanstate Bubble is Clicked
		Case $rdoScanstate
			If BitAND(GUICtrlRead($rdoScanstate), $GUI_CHECKED) Then
				GUICtrlSetState($rdoLoadstate, $GUI_UNCHECKED)
			ElseIf BitAND(GUICtrlRead($chkEncrypt), $GUI_UNCHECKED) Then
				GUICtrlSetState($rdoLoadstate, $GUI_CHECKED)
			EndIf

			; LoadState Bubble is Clicked
		Case $rdoLoadstate
			If BitAND(GUICtrlRead($rdoLoadstate), $GUI_CHECKED) Then
				GUICtrlSetState($rdoScanstate, $GUI_UNCHECKED)
			ElseIf BitAND(GUICtrlRead($chkEncrypt), $GUI_UNCHECKED) Then
				GUICtrlSetState($rdoLoadstate, $GUI_CHECKED)
			EndIf

			; Encrypt Chaeckbox is Clicked
		Case $chkEncrypt
			If BitAND(GUICtrlRead($chkEncrypt), $GUI_CHECKED) Then
				GUICtrlSetState($txtPassword, $GUI_ENABLE)
				GUICtrlSetState($chkCompress, $GUI_DISABLE)
				GUICtrlSetState($chkCompress, $GUI_UNCHECKED)
			ElseIf BitAND(GUICtrlRead($chkEncrypt), $GUI_UNCHECKED) Then
				GUICtrlSetState($txtPassword, $GUI_DISABLE)
				GUICtrlSetState($chkCompress, $GUI_ENABLE)
			EndIf

			; Encrypt Chaeckbox is Clicked
		Case $chkCompress
			If BitAND(GUICtrlRead($chkCompress), $GUI_CHECKED) Then
				GUICtrlSetState($txtPassword, $GUI_DISABLE)
				GUICtrlSetState($chkEncrypt, $GUI_DISABLE)
				GUICtrlSetState($chkEncrypt, $GUI_UNCHECKED)
			ElseIf BitAND(GUICtrlRead($chkCompress), $GUI_UNCHECKED) Then
				GUICtrlSetState($txtPassword, $GUI_DISABLE)
				GUICtrlSetState($chkEncrypt, $GUI_ENABLE)
			EndIf

			; Browse Button Is Clicked
		Case $cmdUNCPathBrowse
			GUICtrlSetData($txtNUCPath, FileSelectFolder("Slecect Path For Data", "", 7, GUICtrlRead($txtNUCPath)))

			; Run Button Is Clicked
		Case $cmdRun
			GUISetState(@SW_HIDE)
			Dim $strCommand
			If BitAND(GUICtrlRead($rdoScanstate), $GUI_CHECKED) Then
				If BitAND(GUICtrlRead($chkEncrypt), $GUI_UNCHECKED) Then
					$blnRequireEncryptoion = MsgBox(52, "USMT", "You have have chose not to encrypt the data" & @CRLF & "Encryption is required for any portable storage device" & @CRLF & "Are you sure you want to store the data in a non-encrypted format?")
					If $blnRequireEncryptoion = 7 Then
						GUISetState(@SW_SHOW)
						ContinueLoop
					EndIf
				EndIf
			EndIf
			If BitAND(GUICtrlRead($chkEncrypt), $GUI_CHECKED) Then
				If Not GUICtrlRead($txtPassword) Then
					MsgBox(16, "USMT", "Password not specified" & @CRLF & "A password is required for encryption" & @CRLF & "Ether enter a password or unckeck encryption")
					GUISetState(@SW_SHOW)
					ContinueLoop
				EndIf
			EndIf
			If BitAND(GUICtrlRead($rdoScanstate), $GUI_CHECKED) Then
				$strCommand &= 'scanstate'
			ElseIf BitAND(GUICtrlRead($rdoLoadstate), $GUI_CHECKED) Then
				$strCommand &= 'loadstate'
			EndIf
			$strCommand &= ' /i:migdocs2.xml /i:migapp.xml /i:excludefolders.xml /i:oracle.xml /i:nofrmcache.xml /i:wallpaper.xml /i:noTheme.xml /c /progress:"' & StringStripWS(GUICtrlRead($txtNUCPath), 3) & '\progress.log" '
			$strCommand &= '"' & StringStripWS(GUICtrlRead($txtNUCPath), 3) & '\DATA"'
			If BitAND(GUICtrlRead($chkEncrypt), $GUI_CHECKED) Then
				If BitAND(GUICtrlRead($rdoScanstate), $GUI_CHECKED) Then
					$strCommand &= ' /encrypt'
				ElseIf BitAND(GUICtrlRead($rdoLoadstate), $GUI_CHECKED) Then
					$strCommand &= ' /decrypt'
				EndIf
				$strCommand &= ' /key:'
				$strCommand &= GUICtrlRead($txtPassword)
			EndIf
			If BitAND(GUICtrlRead($chkCompress), $GUI_UNCHECKED) And BitAND(GUICtrlRead($chkEncrypt), $GUI_UNCHECKED) Then
				$strCommand &= ' /nocompress'
			EndIf
			$strCommand &= ' /v:13 /ue:*\administrator /ue:corp\ad-*'
			If BitAND(GUICtrlRead($rdoScanstate), $GUI_CHECKED) Then
				$strCommand &= ' /l:"' & StringStripWS(GUICtrlRead($txtNUCPath), 3) & '\scanstate.log"'
			ElseIf BitAND(GUICtrlRead($rdoLoadstate), $GUI_CHECKED) Then
				$strCommand &= ' /l:"' & StringStripWS(GUICtrlRead($txtNUCPath), 3) & '\loadstate.log"'
			EndIf
			GUISetState(@SW_HIDE)
			ExitLoop
	EndSwitch
WEnd
;run command
$errCommand = RunWait($strCommand)
;copy log files to scratch
If $errCommand Then
	FileCopy(GUICtrlRead($txtNUCPath) & '\scanstate.log', "\\corp\corpdata\Scratch-so\charles\SCRIPTS\USMT\_LOGS\" & @ComputerName & "\scanstate.log", 8)
	FileCopy(GUICtrlRead($txtNUCPath) & '\loadstate.log', "\\corp\corpdata\Scratch-so\charles\SCRIPTS\USMT\_LOGS\" & @ComputerName & "\loadstate.log", 8)
	FileCopy(GUICtrlRead($txtNUCPath) & '\progress.log', "\\corp\corpdata\Scratch-so\charles\SCRIPTS\USMT\_LOGS\" & @ComputerName & "\progress.log", 8)
EndIf
;return errors
Switch $errCommand
	Case 0
		MsgBox(64, "USMT", "0: Successful run")
	Case 1
		MsgBox(16, "USMT", "1: Command line help requested")
	Case 2
		MsgBox(16, "USMT", "2: User chose to cancel (such as pressing CTRL+C)")
	Case 3
		MsgBox(16, "USMT", "3: At least one error was skipped as a result of /c")
	Case 11
		MsgBox(16, "USMT", "11: INVALID PARAMETERS")
	Case 12
		MsgBox(16, "USMT", "12: Command line arguments cannot exceed 256 characters")
	Case 13
		MsgBox(16, "USMT", "13: Log path argument is invalid for /l")
	Case 14
		MsgBox(16, "USMT", "14: Unable to create a local account because /lac was not specified")
	Case 26
		MsgBox(16, "USMT", "26: INIT ERROR")
	Case 27
		MsgBox(16, "USMT", "27: INVALID STORE LOCATION")
	Case 28
		MsgBox(16, "USMT", "28: Script file is invalid for /i")
	Case 29
		MsgBox(16, "USMT", "29: FAILED MIGRATION STARTUP")
	Case 31
		MsgBox(16, "USMT", "31: An error occurred during the discover phase; the log should have more specific information")
	Case 32
		MsgBox(16, "USMT", "32: An error occurred processing the migration system")
	Case 33
		MsgBox(16, "USMT", "33: UNABLE TO READ KEY")
	Case 34
		MsgBox(16, "USMT", "34: No rights to create user profiles")
	Case 35
		MsgBox(16, "USMT", "35: A store path can't be used because it contains data that could not be overwritten")
	Case 36
		MsgBox(16, "USMT", "36: UNSUPPORTED PLATFORM")
	Case 37
		MsgBox(16, "USMT", "37: The store holds encrypted data but the correct encryption key was not provided")
	Case 38
		MsgBox(16, "USMT", "38: An error occurred during store access")
	Case 39
		MsgBox(16, "USMT", "39: Error reading Config.xml")
	Case 40
		MsgBox(16, "USMT", "40: Error writing to the progress log")
	Case 41
		MsgBox(16, "USMT", "41: Can't overwrite existing file")
	Case 61
		MsgBox(16, "USMT", "61: Processing stopped due to an I/O error")
	Case 71
		MsgBox(16, "USMT", "71: OPERATING ENVIRONMENT FAILED")
	Case 72
		MsgBox(16, "USMT", "72: UNABLE TO DO MIGRATION")
EndSwitch
