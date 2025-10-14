@echo off
:: =====================================
:: Enable ANSI colors and UTF-8 on Windows 10
:: =====================================

echo.
echo 🔧 Enabling ANSI color support in CMD...
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul

echo 🔧 Setting UTF-8 as default...
chcp 65001 >nul

echo 🔧 Setting terminal title and appearance...
title OTG Server - Console with Colors

:: Optional: change default text and background color (white on black)
color 0F

echo ✅ ANSI color support successfully enabled!
echo 💡 Close and reopen CMD to apply the changes.
echo.

pause
exit
