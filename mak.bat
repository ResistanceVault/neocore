@echo off
set backupPath=%path%
set NEODEV=%appdata%\neocore\neodev-sdk
path=%NEODEV%\m68k\bin;%appdata%\neocore\bin;%windir%\System32\WindowsPowerShell\v1.0\
@echo on
make %1 %2 %3
@echo off
path=%backupPath%