@echo off
set backupPath=%path%
set NEODEV=build\neodev-sdk

set gccPath="..\build\gcc\gcc-2.95.2"
set includePath="..\build\include"
set libraryPath="..\build\lib"

:initial
if "%1"=="" goto done
echo              %1
set aux=%1
if "%aux:~0,1%"=="-" (
   set nome=%aux:~1,250%
) else (
   set "%nome%=%1"
   set nome=
)
shift
goto initial
:done

echo %gccPath%
echo %includePath%
echo %libraryPath%

rem gccPath=..\build\gcc\gcc-2.95.2
rem gccPath=..\build\gcc\MinGW-m68k-elf-13.1.0\bin

set INCLUDE_PATH=%includePath%
set LIBRARY_PATH=%libraryPath%

if not exist %gccPath% (
  echo %gccPath% not found
  exit 1
)

if not exist %includePath% (
  echo %includePath% not found
  exit 1
)

if not exist %libraryPath% (
  echo %libraryPath% not found
  exit 1
)

path=%gccPath%;%windir%;%windir%\System32;%windir%\System32\WindowsPowerShell\v1.0\

set error=0
@echo on
make -f Makefile %1 %2 %3
if %errorlevel% neq 0 (
  @echo off
  set error=%errorlevel%
)
@echo off
path=%backupPath%
exit /b %error%
