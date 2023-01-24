
Function Get-OpenFile($initialDirectory)
{ 
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
Out-Null

$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.initialDirectory = $initialDirectory
$OpenFileDialog.filter = "All files (*.*)| *.*"
$OpenFileDialog.ShowDialog() | Out-Null
$OpenFileDialog.filename
}



Function Get-SaveFile($initialDirectory)
{ 
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
Out-Null

$SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
$SaveFileDialog.initialDirectory = $initialDirectory
$SaveFileDialog.filter = "All files (*.*)| *.*"
$SaveFileDialog.ShowDialog() | Out-Null
$SaveFileDialog.filename
} 


# open dialog box to select the .nessuss file. 
$InputFile = Get-OpenFile
$OutputFile = Get-SaveFile


#$Contents = [io.file]::ReadAllText($inputfile)
#$Contents = [io.file]::ReadAllText('C:\tools\wd\nessus\data\data.xml')
#$Global:OutFile = [System.IO.StreamWriter] "c:\tools\wd\nessus\outfile.csv"

$InputFile
$OutputFile