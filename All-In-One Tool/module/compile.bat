@echo off
cls
echo         ####################################
echo         #                                  #
echo         #       Tweaks By HungHoaBinh      #
echo         #                                  #
echo         ####################################
title Compile App With Speed Profile
color 9
setlocal

:: Kiem tra su ton tai cua adb.exe
where adb.exe >nul 2>nul
if %errorlevel% neq 0 (
    echo adb.exe khong duoc tim thay.
    pause
    cd..
    tool.bat
    exit /b
)

:: Kiem tra thiet bi ket noi voi adb
adb devices | findstr /r /c:"device$" >nul
if %errorlevel% neq 0 (
    echo Khong co thiet bi ket noi voi adb.
    pause
    cd..
    tool.bat
    exit /b
)

:: Lay thong tin thiet bi
for /f "tokens=1,2" %%i in ('adb devices') do (
    if "%%j"=="device" (
        set device_id=%%i
    )
)
for /f "tokens=*" %%i in ('adb -s %device_id% shell getprop ro.product.model') do set device_name=%%i
for /f "tokens=*" %%i in ('adb -s %device_id% shell getprop ro.product.device') do set device_code=%%i
for /f "tokens=*" %%i in ('adb -s %device_id% shell getprop ro.build.version.release') do set android_version=%%i


echo =====================================
echo Thiet bi: %device_name%              
echo Ma thiet bi: %device_code%           
echo Phien ban Android: %android_version% 
echo =====================================


:: Thuc hien lenh adb voi package do nguoi dung nhap vao
set /p package="Nhap package name: "
adb shell cmd package compile -m speed -f %package%

pause
cd..
tool.bat
endlocal
