@echo off

mkdir "C:\Windows_Logs\Group Policy"
PPowerShell.exe -Command "&{$user = $env:UserName; $date = get-date; add-content C:\Windows_Logs\Group Policy\Group Policy Update 1.txt" """Group Policy Update 1 script ran at ($date) by ($user)"""}"

echo Starting GP Update
taskkill /im gpscript.exe /f
gpupdate /force

echo Finished
pause

PowerShell.exe -Command "&{$user = $env:UserName; $date = get-date; add-content C:\Windows_Logs\Group Policy\Group Policy Update 1.txt" """Group Policy Update 1 stoped at ($date) by ($user)"""}"
PowerShell.exe -Command "&{add-content C:\Windows_Logs\Group Policy\Group Policy Update 1.txt" """ """}"

exit