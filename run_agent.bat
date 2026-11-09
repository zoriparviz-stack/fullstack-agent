@echo off
title AI Developer Agent Auto-Installer & Runner
cls

echo ==========================================================
echo       STARTING AI DEVELOPER AGENT (PYTHON / CODEX)
echo ==========================================================

:: گام ۱: بررسی نصب بودن پایتون
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [خطا] پایتون روی سیستم شما نصب نیست!
    echo لطفا ابتدا پایتون را نصب کرده و تیک Add to PATH را بزنید.
    pause
    exit
)

:: گام ۲: ساخت محیط مجازی اختصاصی در صورت عدم وجود
if not exist ".venv" (
    echo [پیام] در حال ساخت محیط مجازی (.venv)...
    python -m venv .venv
)

:: گام ۳: فعال‌سازی محیط مجازی
echo [پیام] در حال فعال سازی محیط مجازی...
call .venv\Scripts\activate.bat

:: گام ۴: ارتقای pip و نصب خودکار پکیج‌ها (در صورت وجود فایل requirements)
if exist "requirements.txt" (
    echo [پیام] در حال نصب خودکار پیش نیازهای پروژه (requirements)...
    python -m pip install --upgrade pip
    pip install -r requirements.txt
) else (
    echo [پیام] فایل requirements.txt یافت نشد. نصب پکیج های پایه...
    python -m pip install --upgrade pip
    pip install openai-codex nvidia-cublas-cu12
)

:: گام ۵: اجرای خودکار برنامه اصلی
echo ==========================================================
echo [موفقیت] پیش نیازها آماده شدند. در حال اجرای ایگنت هوش مصنوعی...
echo ==========================================================
if exist "main.py" (
    python main.py
) else if exist "app.py" (
    python app.py
) else (
    echo [خطا] فایل اصلی پروژه (main.py یا app.py) پیدا نشد!
    echo لطفا نام فایل اصلی پایتون خود را بررسی کنید.
)

pause