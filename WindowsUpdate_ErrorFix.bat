@echo off

whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
    @powershell start-process "%~0" -verb runas
    exit

)

sc config "UsoSvc" start= auto
sc config "wuauserv" start= auto
net stop UsoSvc
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
ren C:\Windows\System32\catroot2 catroot2.old
net start UsoSvc
net start wuauserv
net start cryptSvc
net start bits
net start msiserver