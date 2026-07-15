@echo off
title Cet Tool工具发布脚本
echo 说明：生成程序的release目录和使用windeployqt.exe生成QT发布的依赖库
echo 输出当前工作目录: 
echo %cd%

rem 输入程序名
echo *********************************************
set /p ProgramName=请输入程序名: 
echo 选择的程序名：%ProgramName%
if "%ProgramName%"=="" (
	echo 程序名为空
	pause
	exit
)

rem 选择打包版本
echo *********************************************
echo 请选择打包的版本，并确保响应版本已经生成完成
echo 1:Desktop_Qt_5_15_2_MinGW_32bit-Release
echo 2:Desktop_Qt_5_15_2_MSVC2019_64bit-Release
set /p VersionType=请输入1或者2：
echo 选择的版本：%VersionType%
if not %VersionType%==1 (if not %VersionType%==2 ( 
	echo 输入值错误
	pause
	exit
) )
echo *********************************************

rem Qt编译器路径
if %VersionType%==1 (
	set QCOMPLIE_DIR=D:\qtcomplies\mingw81_32
) else (
	set QCOMPLIE_DIR=D:\qtcomplies\msvc2019_64
)

rem Qt部署程序路径
if %VersionType%==1 (
	set WINDEPLOYQT_EXE=%QCOMPLIE_DIR%\bin\windeployqt.exe
	set RELEASE_DIR=.\%ProgramName%\build-%ProgramName%-Desktop_Qt_5_15_2_MinGW_32bit-Release\release
) else (
	set WINDEPLOYQT_EXE="%QCOMPLIE_DIR%\bin\windeployqt.exe"
	set RELEASE_DIR=.\%ProgramName%\build-%ProgramName%-Desktop_Qt_5_15_2_MSVC2019_64bit-Release\release
)
echo windeployqt路径: %WINDEPLOYQT_EXE%
rem 判断QT部署程序是否存在
if not exist %WINDEPLOYQT_EXE% (
	echo "WINDEPLOYQT_EXE 不存在，需要重新设置。"%WINDEPLOYQT_EXE%
	pause
	exit
)
rem 判断QT程序的目标路径是否存在
if not exist %RELEASE_DIR% (
	echo 目标路径不存在，生成目标路径后，再需要重新设置。
	echo %RELEASE_DIR%
	pause
	exit
)

set COMPLIE_BIN_DIR=%QCOMPLIE_DIR%\bin

if %VersionType%==1 (
	echo *********************************************
	echo ## .\%ProgramName%\Desktop_Qt_5_15_2_MinGW_32bit-Release ##
	
	rem 创建软件目录
	mkdir .\%ProgramName%\%ProgramName%-Release
	rem 复制软件文件
	echo 复制 "%RELEASE_DIR%\%ProgramName%.exe -> .\%ProgramName%\%ProgramName%-Release\"
	copy /Y %RELEASE_DIR%\%ProgramName%.exe .\%ProgramName%\%ProgramName%-Release\
	
	rem 使用QT部署程序打包QT依赖项
	echo 执行 "%WINDEPLOYQT_EXE% .\%ProgramName%\%ProgramName%-Release\%ProgramName%.exe --qmldir %QCOMPLIE_DIR%\qml"
	%WINDEPLOYQT_EXE% .\%ProgramName%\%ProgramName%-Release\%ProgramName%.exe --qmldir %QCOMPLIE_DIR%\qml
	if %errorlevel%==0 (
		echo 复制QT依赖库成功
	) else (
		echo 复制QT依赖库失败
		pause
		exit
	)

	rem 复制编译线程依赖的库
	copy "%COMPLIE_BIN_DIR%\libstdc++-6.dll" .\%ProgramName%\%ProgramName%-Release\
	copy "%COMPLIE_BIN_DIR%\libgcc_s_dw2-1.dll" .\%ProgramName%\%ProgramName%-Release\
	copy "%COMPLIE_BIN_DIR%\libwinpthread-1.dll" .\%ProgramName%\%ProgramName%-Release\

	rem 复制网络通信依赖的库
	copy "%COMPLIE_BIN_DIR%\Qt5Network.dll" .\%ProgramName%\%ProgramName%-Release\
	
	rem 复制https依赖的库 ( OpenSSL 1.0.x 及之前)
	rem # copy "D:\qtcomplies\Tools\mingw810_32\opt\bin\libeay32.dll" .\%ProgramName%\%ProgramName%-Release\
	rem # copy "D:\qtcomplies\Tools\mingw810_32\opt\bin\ssleay32.dll" .\%ProgramName%\%ProgramName%-Release\

	rem 复制https依赖的库 ( OpenSSL 1.1.x 及之后)
	copy "D:\qtcomplies\Tools\QtCreator\bin\libcrypto-1_1.dll" .\%ProgramName%\%ProgramName%-Release\
	copy "D:\qtcomplies\Tools\QtCreator\bin\libssl-1_1.dll" .\%ProgramName%\%ProgramName%-Release\

)

if %VersionType%==2 (
	echo *********************************************
	echo ## .\%ProgramName%\Desktop_Qt_5_15_2_MSVC2017_64bit-Release ##
	rem 创建软件目录
	mkdir .\%ProgramName%\%ProgramName%-Release
	rem 复制软件文件
	copy /Y %RELEASE_DIR%\%ProgramName%.exe .\%ProgramName%\%ProgramName%-Release\

	rem 使用QT部署程序打包QT依赖项
	%WINDEPLOYQT_EXE% .\%ProgramName%\%ProgramName%-Release\%ProgramName%.exe --qmldir %QCOMPLIE_DIR%\qml
	if %errorlevel%==0 (
		echo 复制QT依赖库成功
	)else (
		echo 复制QT依赖库失败
		pause
		exit
	)

	rem 复制编译线程依赖的库
	copy "%COMPLIE_BIN_DIR%\libstdc++-6.dll" .\%ProgramName%\%ProgramName%-Release\
	copy "%COMPLIE_BIN_DIR%\libgcc_s_dw2-1.dll" .\%ProgramName%\%ProgramName%-Release\
	copy "%COMPLIE_BIN_DIR%\libwinpthread-1.dll" .\%ProgramName%\%ProgramName%-Release\

	rem 复制网络通信依赖的库
	copy "%COMPLIE_BIN_DIR%\Qt5Network.dll" .\%ProgramName%\%ProgramName%-Release\
)

echo ################## 打包成功 ###################
echo ## VersionType=%VersionType%(1:MinGW_32bit,2:MSVC2017_64bit)
echo ## %ProgramName%.exe
echo #################################################
pause
exit

