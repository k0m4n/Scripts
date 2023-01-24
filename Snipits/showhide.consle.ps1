Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
 
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
 
function Show-Console {
   $consolePtr = [Console.Window]::GetConsoleWindow()
  #5 show
 [Console.Window]::ShowWindow($consolePtr, 5)
}
 
function Hide-Console {
    $consolePtr = [Console.Window]::GetConsoleWindow()
  #0 hide
 [Console.Window]::ShowWindow($consolePtr, 0)
}