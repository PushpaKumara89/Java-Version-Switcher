@echo off
setlocal enabledelayedexpansion

set "input=%1"
set "second=%2"

if "%input%"=="list" goto :list
if "%input%"=="use" goto :use
if "%input%"=="used" goto :used
if "%input%"=="--help" goto :help

goto :unknown

:list
set "folder=C:\Program Files\Java"
if not exist "%folder%" (
    echo Java folder not found: %folder%
    goto :end
)
echo Available Java versions:
for /d %%D in ("%folder%\*") do (
    echo %JAVA_HOME% | findstr /C:"%%~nxD" >nul
    if !errorlevel! equ 0 (
        echo  * %%~nxD  - Currently activated Java version
    ) else (
        echo    %%~nxD
    )   
)
goto :end

:use
:: Check if the second argument is provided
if "%~2"=="" (
    echo Error: Please specify a Java version. Use `jvs list` to see available versions.
    goto :end
)
set "java_path=C:\Program Files\Java\%~2"
if not exist "%java_path%\bin\java.exe" (
    echo Error: Java version "%~2" not found in %java_path%.
    goto :end
)

:: Get current PATH safely
for /f "tokens=2,*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "CURRENT_PATH=%%B"

:: Use a new variable for the filtered PATH
set "NEW_PATH="

:: Process PATH safely, handling special characters
for %%P in ("%CURRENT_PATH:;=" "%") do (
    echo %%P | findstr /i /c:"C:\Program Files\Java" >nul || set "NEW_PATH=!NEW_PATH!;%%~P"
)

:: Trim leading semicolon if present
if "!NEW_PATH:~0,1!"==";" set "NEW_PATH=!NEW_PATH:~1!"

:: Set PATH for the current session
set "PATH=%java_path%\bin;%NEW_PATH%"

:: Update system PATH and JAVA_HOME
setx PATH "%PATH%" >nul
setx JAVA_HOME "%java_path%" >nul

echo Now using Java version: %~2
echo Note: Restart your terminal for changes to take effect.
goto :end

:used
:: Check Java version
java -version 2>nul
if errorlevel 1 (
    echo Java is not configured properly or not installed.
) else (
    echo Active Java version:
    java -version
)
goto :end

:help
echo Usage: jvs [command] [arguments]
echo.
echo Commands:
echo   list         - Display available Java versions in C:\Program Files\Java
echo   use [name]   - Set JAVA_HOME and update PATH for the specified Java version
echo                  Example: jvs use jdk-17
echo   used         - Show the currently active Java version
echo   --help       - Show this help message
echo.
goto :end

:unknown
echo Error: Unknown command. Use `jvs --help` for usage information.

:end
exit /b
