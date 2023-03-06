﻿# ----------------------------------------------------------------------------
#
#	SCRIPT INFORMATION
#
#	Language:		PowerShell
#	Author:			k0m4n
#	Licence:		GNU\GPLv3
#	Date:			12/11/2013
#	Version:		3.1.0.0
#
#	Script Function:
#		Remote Tools Console
#	Dependencies:
#		These Dependencies must be in the same foder as the script (*.ps1) file
#		for full funcationality.
#		Bluescreenview.exe		NirSoft BluescreenView
#		Psexec.exe				Systeternals PSEXEC
#       WinMTR.exe              WinMTR
#
# ----------------------------------------------------------------------------
#Generated Form Function

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $arguments 
break
}

function GenerateForm {
########################################################################
# Code Generated By: SAPIEN Technologies PrimalForms (Community Edition) v1.0.10.0
# Generated On: 12/11/2013 9:29 AM
# Generated By: cekeisle
########################################################################

#region Import the Assemblies
[reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null
[reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
#endregion


function Get-ScriptDirectory
{ 
	if($hostinvocation -ne $null)
	{
		Split-Path $hostinvocation.MyCommand.path
	}
	else
	{
		Split-Path $script:MyInvocation.MyCommand.Path
	}
}
	
[string]$ScriptDirectory = Get-ScriptDirectory


	function Load-ListBox 
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ListBox or CheckedListBox.
	
		.DESCRIPTION
			Use this function to dynamically load items into the ListBox control.
	
		.PARAMETER  ListBox
			The ListBox control you want to add items to.
	
		.PARAMETER  Items
			The object or objects you wish to load into the ListBox's Items collection.
	
		.PARAMETER  DisplayMember
			Indicates the property to display for the items in this control.
		
		.PARAMETER  Append
			Adds the item(s) to the ListBox without clearing the Items collection.
		
		.EXAMPLE
			Load-ListBox $ListBox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Load-ListBox $listBox1 "Red" -Append
			Load-ListBox $listBox1 "White" -Append
			Load-ListBox $listBox1 "Blue" -Append
		
		.EXAMPLE
			Load-ListBox $listBox1 (Get-Process) "ProcessName"
	#>
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			[System.Windows.Forms.ListBox]$ListBox,
			[ValidateNotNull()]
			[Parameter(Mandatory=$true)]
			$Items,
		    [Parameter(Mandatory=$false)]
			[string]$DisplayMember,
			[switch]$Append
		)
		
		if(-not $Append)
		{
			$listBox.Items.Clear()	
		}
		
		if($Items -is [System.Windows.Forms.ListBox+ObjectCollection])
		{
			$listBox.Items.AddRange($Items)
		}
		elseif ($Items -is [Array])
		{
			$listBox.BeginUpdate()
			foreach($obj in $Items)
			{
				$listBox.Items.Add($obj)
			}
			$listBox.EndUpdate()
		}
		else
		{
			$listBox.Items.Add($Items)	
		}
	
		$listBox.DisplayMember = $DisplayMember	
	}

#region Generated Form Objects
$form1 = New-Object System.Windows.Forms.Form
$btnClear = New-Object System.Windows.Forms.Button
$grpDatabase = New-Object System.Windows.Forms.GroupBox
$btnAD = New-Object System.Windows.Forms.Button
$btnSCCM = New-Object System.Windows.Forms.Button
$grpRemoteTools = New-Object System.Windows.Forms.GroupBox
$btnWinMTR = New-Object System.Windows.Forms.Button
$btnBSOD = New-Object System.Windows.Forms.Button
$btnC = New-Object System.Windows.Forms.Button
$btnREGEDIT = New-Object System.Windows.Forms.Button
$btnPSEXEC = New-Object System.Windows.Forms.Button
$btnCOmpMgmt = New-Object System.Windows.Forms.Button
$btnRDC = New-Object System.Windows.Forms.Button
$btnRA = New-Object System.Windows.Forms.Button
$listBox1 = New-Object System.Windows.Forms.ListBox
$txtComputer = New-Object System.Windows.Forms.TextBox
$InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState
#endregion Generated Form Objects

function update-history
	{
		foreach ($strComputerHistoryItem in $listBox1.Items)
		{
			if ($strComputerHistoryItem -like $txtComputer.Text)
			{
				$blnFound = $true
			}
		}
		If ($blnFound -ne $true)
		{
			Load-ListBox $listBox1 $txtComputer.Text -Append
		}
	}

#----------------------------------------------
#Generated Event Script Blocks
#----------------------------------------------
#Provide Custom Code for events specified in PrimalForms.
$btnRA_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath "$env:Windir\System32\msra.exe" -ArgumentList ("/offerra " + $txtComputer.Text)
}

$btnClear_OnClick= 
{
#TODO: Place custom script here
Load-ListBox $listBox1 ""
}

$btnRDC_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath "$env:Windir\System32\mstsc.exe" -ArgumentList ("/v " + $txtComputer.Text)
}

$btnBSOD_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath ($ScriptDirectory + "\BlueScreenView.exe") -ArgumentList ("/MiniDumpFolder \\" + $txtComputer.Text + "\C$\windows\minidump")
}

$btnSCCM_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process "iexplore.exe" -ArgumentList ("http://ap-SMSRPT-p01/Reports/Pages/ReportViewer.aspx?/ConfigMgr_CM1/!Custom+Reports/Server+Inventory+for+CMDB+Link&rs:Command=Render&computername=" + $txtComputer.Text)
}

$btnPSEXEC_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath ($ScriptDirectory + "\psexec.exe") -ArgumentList ("\\" + $txtComputer.Text + " cmd")
}

$btnAD_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath "$env:Windir\System32\WindowsPowerShell\v1.0\powershell.exe" -ArgumentList (" -noexit get-adcomputer " + $txtComputer.Text + " -properties managedBy,description")
}

$btnREGEDIT_OnClick= 
{
#TODO: Place custom script here
update-history
add-type -AssemblyName microsoft.VisualBasic
add-type -AssemblyName System.Windows.Forms
regedit
start-sleep -Milliseconds 500
[Microsoft.VisualBasic.Interaction]::AppActivate("Registry Editior")
[System.Windows.Forms.SendKeys]::SendWait("%(FC)")
start-sleep -Milliseconds 500
[Microsoft.VisualBasic.Interaction]::AppActivate("Select Computer")
[System.Windows.Forms.SendKeys]::SendWait("%E")
[System.Windows.Forms.SendKeys]::SendWait($txtComputer.Text)
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}

$btnWinMTR_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath ($ScriptDirectory + "\WinMTR.exe") -ArgumentList ($txtComputer.Text)
}

$btnC_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath "$env:Windir\explorer.exe" -ArgumentList ("\\" + $txtComputer.Text + "\C$")
}


$btnCOmpMgmt_OnClick= 
{
#TODO: Place custom script here
update-history
Start-Process -FilePath "$env:Windir\System32\compmgmt.msc" -ArgumentList ("/computer=" + $txtComputer.Text)
}

$listBox1_Click={
$txtComputer.Text = $listBox1.SelectedItem
}


$OnLoadForm_StateCorrection=
{#Correct the initial state of the form to prevent the .Net maximized form issue
	$form1.WindowState = $InitialFormWindowState
}

#----------------------------------------------
#region Generated Form Code
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 400
$System_Drawing_Size.Width = 371
$form1.ClientSize = $System_Drawing_Size
$form1.DataBindings.DefaultDataSourceUpdateMode = 0
$form1.FormBorderStyle = 1
$form1.Name = "form1"
$form1.Text = "HelpDesk Tool v3.1"


$btnClear.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 12
$System_Drawing_Point.Y = 359
$btnClear.Location = $System_Drawing_Point
$btnClear.Name = "btnClear"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 121
$btnClear.Size = $System_Drawing_Size
$btnClear.TabIndex = 4
$btnClear.Text = "Clear History"
$btnClear.UseVisualStyleBackColor = $True
$btnClear.add_Click($btnClear_OnClick)

$form1.Controls.Add($btnClear)


$grpDatabase.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 139
$System_Drawing_Point.Y = 281
$grpDatabase.Location = $System_Drawing_Point
$grpDatabase.Name = "grpDatabase"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 107
$System_Drawing_Size.Width = 220
$grpDatabase.Size = $System_Drawing_Size
$grpDatabase.TabIndex = 3
$grpDatabase.TabStop = $False
$grpDatabase.Text = "Database Lookup"

$form1.Controls.Add($grpDatabase)

$btnAD.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 78
$btnAD.Location = $System_Drawing_Point
$btnAD.Name = "btnAD"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnAD.Size = $System_Drawing_Size
$btnAD.TabIndex = 2
$btnAD.Text = "Active Directory"
$btnAD.UseVisualStyleBackColor = $True
$btnAD.add_Click($btnAD_OnClick)

$grpDatabase.Controls.Add($btnAD)


$btnSCCM.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 49
$btnSCCM.Location = $System_Drawing_Point
$btnSCCM.Name = "btnSCCM"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnSCCM.Size = $System_Drawing_Size
$btnSCCM.TabIndex = 1
$btnSCCM.Text = "Configuration Manager"
$btnSCCM.UseVisualStyleBackColor = $True
$btnSCCM.add_Click($btnSCCM_OnClick)

$grpDatabase.Controls.Add($btnSCCM)


$grpRemoteTools.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 139
$System_Drawing_Point.Y = 13
$grpRemoteTools.Location = $System_Drawing_Point
$grpRemoteTools.Name = "grpRemoteTools"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 261
$System_Drawing_Size.Width = 220
$grpRemoteTools.Size = $System_Drawing_Size
$grpRemoteTools.TabIndex = 2
$grpRemoteTools.TabStop = $False
$grpRemoteTools.Text = "Remote Tools"

$form1.Controls.Add($grpRemoteTools)

$btnWinMTR.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 225
$btnWinMTR.Location = $System_Drawing_Point
$btnWinMTR.Name = "btnWinMTR"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnWinMTR.Size = $System_Drawing_Size
$btnWinMTR.TabIndex = 7
$btnWinMTR.Text = "Ping \ Trace"
$btnWinMTR.UseVisualStyleBackColor = $True
$btnWinMTR.add_Click($btnWinMTR_OnClick)

$grpRemoteTools.Controls.Add($btnWinMTR)


$btnBSOD.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 196
$btnBSOD.Location = $System_Drawing_Point
$btnBSOD.Name = "btnBSOD"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnBSOD.Size = $System_Drawing_Size
$btnBSOD.TabIndex = 6
$btnBSOD.Text = "BlueScreenViewer"
$btnBSOD.UseVisualStyleBackColor = $True
$btnBSOD.add_Click($btnBSOD_OnClick)

$grpRemoteTools.Controls.Add($btnBSOD)


$btnC.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 167
$btnC.Location = $System_Drawing_Point
$btnC.Name = "btnC"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnC.Size = $System_Drawing_Size
$btnC.TabIndex = 5
$btnC.Text = "C Drive"
$btnC.UseVisualStyleBackColor = $True
$btnC.add_Click($btnC_OnClick)

$grpRemoteTools.Controls.Add($btnC)


$btnREGEDIT.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 138
$btnREGEDIT.Location = $System_Drawing_Point
$btnREGEDIT.Name = "btnREGEDIT"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnREGEDIT.Size = $System_Drawing_Size
$btnREGEDIT.TabIndex = 4
$btnREGEDIT.Text = "Registriy Editior"
$btnREGEDIT.UseVisualStyleBackColor = $True
$btnREGEDIT.add_Click($btnREGEDIT_OnClick)

$grpRemoteTools.Controls.Add($btnREGEDIT)


$btnPSEXEC.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 109
$btnPSEXEC.Location = $System_Drawing_Point
$btnPSEXEC.Name = "btnPSEXEC"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnPSEXEC.Size = $System_Drawing_Size
$btnPSEXEC.TabIndex = 3
$btnPSEXEC.Text = "Command Prompt"
$btnPSEXEC.UseVisualStyleBackColor = $True
$btnPSEXEC.add_Click($btnPSEXEC_OnClick)

$grpRemoteTools.Controls.Add($btnPSEXEC)


$btnCOmpMgmt.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 79
$btnCOmpMgmt.Location = $System_Drawing_Point
$btnCOmpMgmt.Name = "btnCOmpMgmt"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnCOmpMgmt.Size = $System_Drawing_Size
$btnCOmpMgmt.TabIndex = 2
$btnCOmpMgmt.Text = "Computer Management"
$btnCOmpMgmt.UseVisualStyleBackColor = $True
$btnCOmpMgmt.add_Click($btnCOmpMgmt_OnClick)

$grpRemoteTools.Controls.Add($btnCOmpMgmt)


$btnRDC.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 49
$btnRDC.Location = $System_Drawing_Point
$btnRDC.Name = "btnRDC"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnRDC.Size = $System_Drawing_Size
$btnRDC.TabIndex = 1
$btnRDC.Text = "Remote Desktop Connection"
$btnRDC.UseVisualStyleBackColor = $True
$btnRDC.add_Click($btnRDC_OnClick)

$grpRemoteTools.Controls.Add($btnRDC)


$btnRA.DataBindings.DefaultDataSourceUpdateMode = 0

$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 7
$System_Drawing_Point.Y = 20
$btnRA.Location = $System_Drawing_Point
$btnRA.Name = "btnRA"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 23
$System_Drawing_Size.Width = 207
$btnRA.Size = $System_Drawing_Size
$btnRA.TabIndex = 0
$btnRA.Text = "Windows Remote Assistance"
$btnRA.UseVisualStyleBackColor = $True
$btnRA.add_Click($btnRA_OnClick)

$grpRemoteTools.Controls.Add($btnRA)


$listBox1.DataBindings.DefaultDataSourceUpdateMode = 0
$listBox1.FormattingEnabled = $True
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 13
$System_Drawing_Point.Y = 40
$listBox1.Location = $System_Drawing_Point
$listBox1.Name = "listBox1"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 316
$System_Drawing_Size.Width = 120
$listBox1.Size = $System_Drawing_Size
$listBox1.TabIndex = 1
$listBox1.add_Click($listBox1_Click)

$form1.Controls.Add($listBox1)

$txtComputer.DataBindings.DefaultDataSourceUpdateMode = 0
$System_Drawing_Point = New-Object System.Drawing.Point
$System_Drawing_Point.X = 13
$System_Drawing_Point.Y = 13
$txtComputer.Location = $System_Drawing_Point
$txtComputer.Name = "txtComputer"
$System_Drawing_Size = New-Object System.Drawing.Size
$System_Drawing_Size.Height = 20
$System_Drawing_Size.Width = 120
$txtComputer.Size = $System_Drawing_Size
$txtComputer.TabIndex = 0

$form1.Controls.Add($txtComputer)

#endregion Generated Form Code

#Save the initial state of the form
$InitialFormWindowState = $form1.WindowState
#Init the OnLoad event to correct the initial state of the form
$form1.add_Load($OnLoadForm_StateCorrection)
#Show the Form
$form1.ShowDialog()| Out-Null

} #End Function

#Call the Function
GenerateForm
