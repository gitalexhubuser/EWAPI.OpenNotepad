@echo off
setlocal
chcp 65001 >nul

echo ======================================================
echo Удаление протокола HNG
echo ======================================================
echo.

reg delete "HKCU\Software\Classes\hng" /f >nul 2>&1

if %ERRORLEVEL% equ 0 (
    echo [УСПЕХ] Протокол HNG успешно удален из реестра.
) else (
    echo [ИНФО] Протокол HNG не был найден в реестре или уже удален.
)

echo.
pause
