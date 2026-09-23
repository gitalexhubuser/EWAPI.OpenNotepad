@echo off

set "PYTHON=C:\Users\VisualCode\AppData\Local\Programs\Python\Python311\python.exe"
set "SCRIPT=C:\HNG\hng_handler.py"

reg add "HKCU\Software\Classes\hng" /ve /d "URL:HNG Protocol" /f
reg add "HKCU\Software\Classes\hng" /v "URL Protocol" /d "" /f

reg add "HKCU\Software\Classes\hng\shell\open\command" /ve /d "\"%PYTHON%\" \"%SCRIPT%\" \"%%1\"" /f

echo.
echo HNG protocol installed.
echo.
pause
