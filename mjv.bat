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
    if exist "%%D\bin\java.exe" echo   %%~nxD
)
goto :end

:use
:: Check if the second argument is provided
if "%~2"=="" (
    echo Error: Please specify a Java version. Use `mjv list` to see available versions.
    goto :end
)
set "java_path=C:\Program Files\Java\%~2"
if not exist "%java_path%\bin\java.exe" (
    echo Error: Java version "%~2" not found in %java_path%.
    goto :end
)

:: Remove old Java paths from user-level PATH
for /f "tokens=2,*" %%A in ('reg query "HKCU\Environment" /v Path 2^>nul') do set "CURRENT_PATH=%%B"
set "NEW_PATH="
for %%P in (%CURRENT_PATH:;=%) do (
    echo %%P | findstr /i /c:"C:\Program Files\Java" >nul || set "NEW_PATH=!NEW_PATH!;%%P"
)

:: Set user-level PATH and JAVA_HOME
setx PATH "%NEW_PATH%;%java_path%\bin"
if %errorlevel% neq 0 (
    echo Error: Failed to set PATH.
    goto :end
)
setx JAVA_HOME "%java_path%"
if %errorlevel% neq 0 (
    echo Error: Failed to set JAVA_HOME.
    goto :end
)

echo Now using Java version: %~2
echo Note: Restart your terminal for changes to take effect.
goto :end


:used
java -version
goto :end

:help
echo Usage: mjv [command] [arguments]
echo.
echo Commands:
echo   list         - Display available Java versions in C:\Program Files\Java
echo   use [name]   - Set JAVA_HOME and update PATH for the specified Java version
echo                  Example: mjv use jdk-17
echo   used         - Show the currently active Java version
echo   --help       - Show this help message
echo.
goto :end

:unknown
echo Error: Unknown command. Use `mjv --help` for usage information.

:end
exit /b