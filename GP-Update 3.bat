@echo off
mkdir "C:\Windows_Logs\Group Policy"

if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
PowerShell.exe -Command "&{$user = $env:UserName; $date = get-date; add-content C:\Windows_Logs\Group Policy\Group Policy Update 3.txt" """Group Policy Update 3 script ran at ($date) by ($user)"""}"

echo Stopiong WIM Service
net pause winmgmt
rcho y | net stop winmgmt
echo y | RMDIR /s "C:\Windows\System32\wbem\repository"

echo Starting WIM Service
net start winmgmt

net stop "Computer Browser"
net start "Computer Browser"

echo y | del C:\Windows\System32\GroupPolicy\Machine\Registry.pol

echo y | del "C:\Windows\System32\GroupPolicy"
echo y | del "C:\Windows\System32\GroupPolicyUsers"
cls

taskkill /im gpscript.exe /f
gpupdate /force

echo finished
pause

PowerShell.exe -Command "&{$user = $env:UserName; $date = get-date; add-content C:\Windows_Logs\Group Policy\Group Policy Update 3.txt" """Group Policy Update 3 stoped at ($date) by ($user)"""}"
PowerShell.exe -Command "&{add-content C:\Windows_Logs\Group Policy\Group Policy Update 3.txt" """ """}"

exit