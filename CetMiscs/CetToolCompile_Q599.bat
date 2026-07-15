@echo off
set build_title=编译Cet Tool工具CMD脚本
title %build_title%
echo 说明：替代QtCreator软件进行项目构建及编译
echo 输出当前工作目录: 
echo %cd%

rem 输入项目名
echo *********************************************
set /p ProjectName=请输入项目名: 
if "%ProjectName%"=="" (
	echo 项目名为空
	pause
	exit
)

:set_build_thread
cls
set build_thread=
SET /P build_thread=　　　请输入编译线程数(1~32)(越大越快，电脑越卡)，然后回车：
If "%build_thread%"=="" Goto set_build_thread
If %build_thread% gtr 32 set build_thread=32
If %build_thread% LSS 2  set build_thread=1

title %build_title%，编译线程数:%build_thread%

set START_DIR=%cd%
set TARGET_DIR=%cd%\%ProjectName%
set BUILD_DIR=%TARGET_DIR%\build-%ProjectName%-Desktop_Qt_5_9_9_MinGW_32bit-Release
if not exist %BUILD_DIR% (
	@echo [创建目录]: %BUILD_DIR%
	mkdir %BUILD_DIR%
)

set QT_MAKE="D:\Qt\Qt5.9.9\5.9.9\mingw53_32\bin\qmake.exe"
set COMPILE_MAKE="D:\Qt\Qt5.9.9\Tools\mingw530_32\bin\mingw32-make.exe"

@echo [进入目录]: %BUILD_DIR%
cd %BUILD_DIR%

:build_task_establishment
@echo [构建 qmake]: %ProjectName%.pro
@echo %QT_MAKE% %TARGET_DIR%\%ProjectName%\%ProjectName%.pro -spec win32-g++
%QT_MAKE% %TARGET_DIR%\%ProjectName%\%ProjectName%.pro -spec win32-g++

@echo [清除 clean]: %ProjectName%
@echo %COMPILE_MAKE% -j%build_thread% -f %BUILD_DIR%\Makefile.Release clean
%COMPILE_MAKE% -j%build_thread% -f %BUILD_DIR%\Makefile.Release clean

:build_task_start
@echo [编译 make]: %ProjectName%
@echo %COMPILE_MAKE% -j%build_thread% -f %BUILD_DIR%\Makefile.Release
%COMPILE_MAKE% -j%build_thread% -f %BUILD_DIR%\Makefile.Release
echo ################## 【%ProjectName%】编译完成 ###################
goto build_task_end_choise

:build_task_clean
@echo [清除 clean]: %ProjectName%
%COMPILE_MAKE% clean -j%build_thread% in %BUILD_DIR%
echo ################## 【%ProjectName%】清除完成 ###################

:build_task_end_choise
echo 输入1:重新编译
echo.
echo 输入2:重新构建
echo.
echo 输入3:清除 clean
echo.
echo 输入exit:退出编译
echo.
set build_exit=
SET /P build_exit=　　　请输入：
If "%build_exit%"=="1" goto build_task_start
If "%build_exit%"=="2" goto build_task_establishment
If "%build_exit%"=="3" goto build_task_clean
If "%build_exit%"=="exit" goto build_end
If "%build_exit%"==""    goto build_task_end_choise
goto build_task_end_choise 

:build_end
@echo [离开目录]: %BUILD_DIR%
cd %START_DIR%
exit 0