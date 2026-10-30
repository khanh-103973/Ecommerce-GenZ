@echo off
cd /d "%~dp0"
where dotnet >nul 2>nul
if errorlevel 1 (
  echo Khong tim thay .NET SDK. Hay cai .NET 10 SDK.
  pause
  exit /b 1
)
where npm >nul 2>nul
if errorlevel 1 (
  echo Khong tim thay npm. Hay cai Node.js LTS.
  pause
  exit /b 1
)
echo Dang mo API va giao dien. Khong chay lai neu hai cua so da mo.
start "GenZ Fashion - API" /D "%~dp0" cmd /k "dotnet run --project GenZFashion.Api --launch-profile https"
if exist "%~dp0GenZFashion.Web\node_modules" (
  start "GenZ Fashion - Web" /D "%~dp0GenZFashion.Web" cmd /k "npm run dev"
) else (
  start "GenZ Fashion - Web" /D "%~dp0GenZFashion.Web" cmd /k "npm ci && npm run dev"
)
echo Cho API va Web khoi dong, sau do mo http://127.0.0.1:5173
echo De dung: nhan Ctrl+C trong tung cua so, roi dong cua so.
timeout /t 5 /nobreak >nul
start "" "http://127.0.0.1:5173"
