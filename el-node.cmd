@echo off
setlocal enabledelayedexpansion

rem Get full script directory with trailing backslash, e.g. C:\Users\morten\...
set SCRIPT_DIR=%~dp0

rem Extract drive letter (e.g. C)
set DRIVE=%SCRIPT_DIR:~0,1%

rem Convert drive letter to lowercase (a-z)
for %%L in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do (
  if /I "%DRIVE%"=="%%L" set DRIVE=%%L
)

rem Remove drive and colon from path, e.g. \Users\morten\...
set PATH_NO_DRIVE=%SCRIPT_DIR:~2%

rem Build WSL path: /mnt/<drive-letter-lowercase>/<rest-of-path> + script name
set "BASH_SCRIPT_PATH=/mnt/%DRIVE%%PATH_NO_DRIVE%nodeTypescriptInit.sh"

rem Replace backslashes with forward slashes
set "BASH_SCRIPT_PATH=!BASH_SCRIPT_PATH:\=/!"

rem Run the script with bash
bash "!BASH_SCRIPT_PATH!"

endlocal
