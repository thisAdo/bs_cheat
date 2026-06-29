@echo off
setlocal
cd /d "%~dp0"

if not exist "bsd_brawl_v67.264.apk" (
echo ERROR: Falta bsd_brawl_v67.264.apk en esta carpeta.
exit /b 1
)

if not exist "index.js" (
echo ERROR: Falta index.js en esta carpeta.
exit /b 1
)

if not exist "config.arm64.txt" (
echo ERROR: Falta config.arm64.txt en esta carpeta.
exit /b 1
)

where frida-gadget >nul 2>&1
if errorlevel 1 (
echo ERROR: frida-gadget no esta instalado.
echo Ejecuta: pip install frida-gadget --upgrade
exit /b 1
)

copy /Y config.arm64.txt config.txt >nul

echo.
echo Construyendo APK arm64...
echo.

frida-gadget bsd_brawl_v67.264.apk --arch arm64 --config config.txt --js index.js --sign

if errorlevel 1 (
echo.
echo ERROR: fallo el build.
exit /b 1
)

echo.
echo Build terminado.
echo.
echo APKs encontrados:
dir /b *.apk
echo.
pause
endlocal
