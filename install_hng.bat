@echo off
setlocal
chcp 65001 >nul

set "SCRIPT=%~dp0hng_handler.py"

if not exist "%SCRIPT%" goto :ERR_NO_SCRIPT

:: 1. Проверяем py launcher
for /f "usebackq delims=" %%i in (`py -c "import sys; print(sys.executable)" 2^>nul`) do (
    if exist "%%i" (
        set "PYTHON=%%i"
        goto :FOUND_PYTHON
    )
)

:: 2. Проверяем python.exe в PATH
for /f "delims=" %%i in ('where.exe python.exe 2^>nul') do (
    echo "%%i" | findstr /i "WindowsApps" >nul
    if errorlevel 1 (
        if exist "%%i" (
            set "PYTHON=%%i"
            goto :FOUND_PYTHON
        )
    )
)

:: 3. Проверяем в папке пользователя AppData
for /d %%d in ("%LOCALAPPDATA%\Programs\Python\Python*") do (
    if exist "%%d\python.exe" (
        set "PYTHON=%%d\python.exe"
        goto :FOUND_PYTHON
    )
)

:: 4. Проверяем в Program Files
for /d %%d in ("%ProgramFiles%\Python*") do (
    if exist "%%d\python.exe" (
        set "PYTHON=%%d\python.exe"
        goto :FOUND_PYTHON
    )
)

for /d %%d in ("%ProgramFiles(x86)%\Python*") do (
    if exist "%%d\python.exe" (
        set "PYTHON=%%d\python.exe"
        goto :FOUND_PYTHON
    )
)

:ERR_NO_PYTHON
echo.
echo ======================================================
echo [ОШИБКА] Python не найден на этом компьютере!
echo ======================================================
echo Пожалуйста, установите Python (https://www.python.org)
echo и обязательно отметьте галочку "Add python.exe to PATH".
echo.
pause
exit /b 1

:ERR_NO_SCRIPT
echo.
echo [ОШИБКА] Файл hng_handler.py не найден в папке:
echo "%~dp0"
echo.
pause
exit /b 1

:FOUND_PYTHON
echo.
echo ======================================================
echo Настройка протокола HNG
echo ======================================================
echo Скрипт: %SCRIPT%
echo Python: %PYTHON%
echo ======================================================
echo.

reg add "HKCU\Software\Classes\hng" /ve /d "URL:HNG Protocol" /f >nul
reg add "HKCU\Software\Classes\hng" /v "URL Protocol" /d "" /f >nul
reg add "HKCU\Software\Classes\hng\shell\open\command" /ve /d "\"%PYTHON%\" \"%SCRIPT%\" \"%%1\"" /f >nul

if %ERRORLEVEL% equ 0 (
    echo [УСПЕХ] Протокол HNG успешно зарегистрирован!
    echo.
    echo Теперь ссылки вида:
    echo   hng://notepad/C:/путь/к/файлу.txt
    echo будут открывать Блокнот.
) else (
    echo [ОШИБКА] Не удалось зарегистрировать протокол в реестре.
)

echo.
pause
