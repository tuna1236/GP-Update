@echo off
mkdir "C:\Windows_Logs\Group Policy"

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
PPowerShell.exe -Command "&{$user = $env:UserName; $date = get-date; add-content C:\Windows_Logs\Group Policy\Group Policy Update 2.txt" """Group Policy Update 2 script ran at ($date) by ($user)"""}"

echo Stopiong WIM Service
net pause winmgmt
echo y | net stop winmgmt
echo y | RMDIR /s "C:\Windows\System32\wbem\repository"

echo Starting WIM Service
net start winmgmt

net stop "Computer Browser"
net start "Computer Browser"

echo y | del C:\Windows\System32\GroupPolicy\Machine\Registry.pol

echo Starting GP Update
taskkill /im gpscript.exe /f
gpupdate /force

echo Finished
pause

PowerShell.exe -Command "&{$user = $env:UserName; $date = get-date; add-content C:\Windows_Logs\Group Policy\Group Policy Update 2.txt" """Group Policy Update 2 stoped at ($date) by ($user)"""}"
PowerShell.exe -Command "&{add-content C:\Windows_Logs\Group Policy\Group Policy Update 2.txt" """ """}"

exit