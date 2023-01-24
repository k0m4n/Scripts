# ----------------------------------------------------------------------------
#
#	SCRIPT INFORMATION
#
#	Language:		PowerShell
#	Author:			k0m4n
#	Licence:		GNU\GPLv3
#	Date:			08/13/2013
#	Version:		3.0.0.0
#
#	Script Function:
#		Helpdesk Remote Tools Launcher
#	Dependencies:
#		These Dependencies must e in the ame foder as the script (*.ps1) file
#		for full funcationality.
#		Bluescreenview.exe		NirSoftB lescreenView
#		Psexec.exe				Systeternals PSEXEC
#
# ----------------------------------------------------------------------------
[void][Reflection.Assembly]::Load("System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
[void][Reflection.Assembly]::Load("mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
[void][Reflection.Assembly]::Load("System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")

function Main {
	Param ([String]$Commandline)
	
	if((Call-MainForm_pff) -eq "OK")
	{
		
	}
	
	$global:ExitCode = 0 
}

function Call-MainForm_pff
{
	[void][reflection.assembly]::Load("System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Drawing, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
	[void][reflection.assembly]::Load("mscorlib, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Data, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
	[void][reflection.assembly]::Load("System.DirectoryServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
	
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$MainForm = New-Object 'System.Windows.Forms.Form'
	$groupbox1 = New-Object 'System.Windows.Forms.GroupBox'
	$buttonBlueScreenViewer = New-Object 'System.Windows.Forms.Button'
	$btnC = New-Object 'System.Windows.Forms.Button'
	$btnREGEDIT = New-Object 'System.Windows.Forms.Button'
	$btnCMD = New-Object 'System.Windows.Forms.Button'
	$btnCompMgmt = New-Object 'System.Windows.Forms.Button'
	$btnRDP = New-Object 'System.Windows.Forms.Button'
	$btnRA = New-Object 'System.Windows.Forms.Button'
	$lstComputerHistoy = New-Object 'System.Windows.Forms.ListBox'
	$txtComputer = New-Object 'System.Windows.Forms.TextBox'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'


	$OnLoadFormEvent={
	
	}
	
	
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
	
	function update-history
	{
		foreach ($strComputerHistoryItem in $lstComputerHistoy.Items)
		{
			if ($strComputerHistoryItem -like $txtComputer.Text)
			{
				$blnFound = $true
			}
		}
		If ($blnFound -ne $true)
		{
			Load-ListBox $lstComputerHistoy $txtComputer.Text -Append
		}
	}
	
	$btnRA_Click={
		update-history
		Start-Process -FilePath "$env:Windir\System32\msra.exe" -ArgumentList ("/offerra " + $txtComputer.Text)
	}
	
	$btnRDP_Click={
		update-history
		Start-Process -FilePath "$env:Windir\System32\mstsc.exe" -ArgumentList ("/v " + $txtComputer.Text)
	}
	
	
	$btnCompMgmt_Click={
		update-history
		Start-Process -FilePath "$env:Windir\System32\compmgmt.msc" -ArgumentList ("/computer=" + $txtComputer.Text)
	}
	
	$btnCMD_Click={
		update-history
		Start-Process -FilePath "psexec" -ArgumentList ("\\" + $txtComputer.Text + " cmd")
	}
	
	$btnREGEDIT_Click={
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
	
	$btnC_Click={
		update-history
		Start-Process -FilePath "$env:Windir\explorer.exe" -ArgumentList ("\\" + $txtComputer.Text + "\C$")
	}
	
	$buttonBlueScreenViewer_Click={
		update-history
		Start-Process -FilePath ($ScriptDirectory + "\BlueScreenView.exe") -ArgumentList ("/MiniDumpFolder \\" + $txtComputer.Text + "\C$\windows\minidump")
	}
	
	$lstComputerHistoy_Click={
		$txtComputer.Text = $lstComputerHistoy.SelectedItem
	}
		
	$Form_StateCorrection_Load=
	{
		$MainForm.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		$script:MainForm_lstComputerHistoy = $lstComputerHistoy.SelectedItems
		$script:MainForm_txtComputer = $txtComputer.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		try
		{
			$buttonBlueScreenViewer.remove_Click($buttonBlueScreenViewer_Click)
			$btnC.remove_Click($btnC_Click)
			$btnREGEDIT.remove_Click($btnREGEDIT_Click)
			$btnCMD.remove_Click($btnCMD_Click)
			$btnCompMgmt.remove_Click($btnCompMgmt_Click)
			$btnRDP.remove_Click($btnRDP_Click)
			$btnRA.remove_Click($btnRA_Click)
			$lstComputerHistoy.remove_Click($lstComputerHistoy_Click)
			$MainForm.remove_Load($OnLoadFormEvent)
			$MainForm.remove_Load($Form_StateCorrection_Load)
			$MainForm.remove_Closing($Form_StoreValues_Closing)
			$MainForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch [Exception]
		{ }
	}
	$MainForm.Controls.Add($groupbox1)
	$MainForm.Controls.Add($lstComputerHistoy)
	$MainForm.Controls.Add($txtComputer)
	$MainForm.ClientSize = '345, 286'
	$MainForm.FormBorderStyle = 'FixedSingle'
	$MainForm.Name = "MainForm"
	$MainForm.StartPosition = 'CenterScreen'
	$MainForm.Text = "CCOPSware v3"
	$MainForm.add_Load($OnLoadFormEvent)
	
	$groupbox1.Controls.Add($buttonBlueScreenViewer)
	$groupbox1.Controls.Add($btnC)
	$groupbox1.Controls.Add($btnREGEDIT)
	$groupbox1.Controls.Add($btnCMD)
	$groupbox1.Controls.Add($btnCompMgmt)
	$groupbox1.Controls.Add($btnRDP)
	$groupbox1.Controls.Add($btnRA)
	$groupbox1.Location = '141, 13'
	$groupbox1.Name = "groupbox1"
	$groupbox1.Size = '193, 260'
	$groupbox1.TabIndex = 2
	$groupbox1.TabStop = $False
	$groupbox1.Text = "Remote Tools"

	$buttonBlueScreenViewer.Location = '6, 227'
	$buttonBlueScreenViewer.Name = "buttonBlueScreenViewer"
	$buttonBlueScreenViewer.Size = '176, 23'
	$buttonBlueScreenViewer.TabIndex = 7
	$buttonBlueScreenViewer.Text = "Blue Screen Viewer"
	$buttonBlueScreenViewer.UseVisualStyleBackColor = $True
	$buttonBlueScreenViewer.add_Click($buttonBlueScreenViewer_Click)

	$btnC.Location = '7, 169'
	$btnC.Name = "btnC"
	$btnC.Size = '176, 23'
	$btnC.TabIndex = 5
	$btnC.Text = "Hidden C$ Share"
	$btnC.UseVisualStyleBackColor = $True
	$btnC.add_Click($btnC_Click)

	$btnREGEDIT.Location = '7, 139'
	$btnREGEDIT.Name = "btnREGEDIT"
	$btnREGEDIT.Size = '176, 23'
	$btnREGEDIT.TabIndex = 4
	$btnREGEDIT.Text = "Registry Editior"
	$btnREGEDIT.UseVisualStyleBackColor = $True
	$btnREGEDIT.add_Click($btnREGEDIT_Click)

	$btnCMD.Location = '7, 109'
	$btnCMD.Name = "btnCMD"
	$btnCMD.Size = '176, 23'
	$btnCMD.TabIndex = 3
	$btnCMD.Text = "Comand Prompt"
	$btnCMD.UseVisualStyleBackColor = $True
	$btnCMD.add_Click($btnCMD_Click)

	$btnCompMgmt.Location = '7, 79'
	$btnCompMgmt.Name = "btnCompMgmt"
	$btnCompMgmt.Size = '176, 23'
	$btnCompMgmt.TabIndex = 2
	$btnCompMgmt.Text = "Computer Management"
	$btnCompMgmt.UseVisualStyleBackColor = $True
	$btnCompMgmt.add_Click($btnCompMgmt_Click)

	$btnRDP.Location = '7, 49'
	$btnRDP.Name = "btnRDP"
	$btnRDP.Size = '176, 23'
	$btnRDP.TabIndex = 1
	$btnRDP.Text = "Remote Desktop Connection"
	$btnRDP.UseVisualStyleBackColor = $True
	$btnRDP.add_Click($btnRDP_Click)

	$btnRA.Location = '7, 19'
	$btnRA.Name = "btnRA"
	$btnRA.Size = '177, 23'
	$btnRA.TabIndex = 0
	$btnRA.Text = "Windows Remote Assitance"
	$btnRA.UseVisualStyleBackColor = $True
	$btnRA.add_Click($btnRA_Click)

	$lstComputerHistoy.FormattingEnabled = $True
	$lstComputerHistoy.Location = '13, 48'
	$lstComputerHistoy.Name = "lstComputerHistoy"
	$lstComputerHistoy.Size = '120, 225'
	$lstComputerHistoy.TabIndex = 1
	$lstComputerHistoy.add_Click($lstComputerHistoy_Click)

	$txtComputer.Location = '13, 22'
	$txtComputer.Name = "txtComputer"
	$txtComputer.Size = '122, 20'
	$txtComputer.TabIndex = 0

	$InitialFormWindowState = $MainForm.WindowState
	$MainForm.add_Load($Form_StateCorrection_Load)
	$MainForm.add_FormClosed($Form_Cleanup_FormClosed)
	$MainForm.add_Closing($Form_StoreValues_Closing)
	return $MainForm.ShowDialog()

}

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

Main ($CommandLine)
