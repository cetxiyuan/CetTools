@echo off
title Cet Tool工具的打包脚本
echo 说明：打包Cet Tool工具软件，生成对应的压缩包
echo 输出当前工作目录: 
echo %cd%

rem 选择打包模式
echo *********************************************
echo 请选择打包模式
echo  1: 打包所有支持的CetTool({CetTool} {CetTool}-Release {CetTool}-Patch {CetTool}-Setup)
echo  2: 打包源代码内容({CetTool})
echo  3: 打包Patch内容({CetTool}-Patch)
echo  4: 打包Release内容({CetTool}-Release)
echo  5: 打包Setup内容({CetTool}-Setup)
set /p Mode=请输入(1,2,3,4,5)：
echo 选择的模式：%Mode%
if not %Mode%==1 (if not %Mode%==2 ( if not %Mode%==3 ( if not %Mode%==4 ( if not %Mode%==5 (
	echo 输入值错误
	pause
	exit
) ) ) ) )
echo *********************************************

mkdir YXCETTOOLPACK_OUTPUT
rem 设置输出目录
set OUTPUT_DIR=%cd%\YXCETTOOLPACK_OUTPUT
set CETTOOLDIRS=CetAssistTool,CetCANTestTool,CetDevelopmentKit,CetDiagnosticInstrument,^
CetLoanCalculator,CetNetworkServer,CetNetworkTester,CetQtTools,CetRemind,CetSimulateEcu,^
CetSScom,CetSuperLotto,CetToolLicense,CetVehicleCollector,CetCryptoToolkit

if %Mode%==1 (
	mkdir %OUTPUT_DIR%\XYCetToolPack-all

	for %%i in (%CETTOOLDIRS%)  do (

		if not exist %%i (
			echo 目标路径不存在，生成目标路径后，再需要重新设置。
			echo %%i
			pause
			exit
		)

		if %%i==CetToolLicense (
			tar -zcvf %%i-all.tar.gz %%i\.git* %%i\README.md %%i\%%i %%i\%%i-Patch %%i\%%i-Release %%i\%%i-Setup ^
				%%i\CetToolDLLs %%i\CetToolLibs\.git* %%i\CetToolLibs\Cet* %%i\CetToolPlugins\.git* ^
				%%i\CetToolPlugins\Cet*
		) else (
			tar -zcvf %%i-all.tar.gz %%i\.git* %%i\README.md %%i\%%i %%i\%%i-Patch %%i\%%i-Release %%i\%%i-Setup
		)
		xcopy /i /y %%i-all.tar.gz %OUTPUT_DIR%\XYCetToolPack-all\
		del %%i-all.tar.gz
	)

	rem 切换到输出目录
	cd %OUTPUT_DIR%
	
	echo 正在打包 XYCetToolPack-all
	tar -zcvf XYCetToolPack-all.tar.gz XYCetToolPack-all\*.*
)

if %Mode%==2 (
	mkdir %OUTPUT_DIR%\XYCetToolPack-src

	for %%i in (%CETTOOLDIRS%)  do (

		if not exist %%i (
			echo 目标路径不存在，生成目标路径后，再需要重新设置。
			echo %%i
			pause
			exit
		)

		if %%i==CetToolLicense (
			tar -zcvf %%i-src.tar.gz %%i\.git* %%i\README.md %%i\%%i %%i\CetToolLibs\.git* %%i\CetToolLibs\Cet* ^
				%%i\CetToolPlugins\.git* %%i\CetToolPlugins\Cet*
		) else (
			tar -zcvf %%i-src.tar.gz %%i\.git* %%i\README.md %%i\%%i
		)

		xcopy /i /y %%i-src.tar.gz %OUTPUT_DIR%\XYCetToolPack-src\
		del %%i-src.tar.gz
	)

	rem 切换到输出目录
	cd %OUTPUT_DIR%

	echo 正在打包 XYCetToolPack-src
	tar -zcvf XYCetToolPack-src.tar.gz XYCetToolPack-src\*.*
)

if %Mode%==3 (
	mkdir %OUTPUT_DIR%\XYCetToolPack-patch

	for %%i in (%CETTOOLDIRS%)  do (

		if not exist %%i (
			echo 目标路径不存在，生成目标路径后，再需要重新设置。
			echo %%i
			pause
			exit
		)
		
	 	tar -zcvf %%i-patch.tar.gz %%i\%%i-Patch
		xcopy /i /y %%i-patch.tar.gz %OUTPUT_DIR%\XYCetToolPack-patch\
		del %%i-patch.tar.gz
	)

	rem 切换到输出目录
	cd %OUTPUT_DIR%

	echo 正在打包 XYCetToolPack-patch
	tar -zcvf XYCetToolPack-patch.tar.gz XYCetToolPack-patch\*.*
)

if %Mode%==4 (
	mkdir %OUTPUT_DIR%\XYCetToolPack-release

	for %%i in (%CETTOOLDIRS%)  do (

		if not exist %%i (
			echo 目标路径不存在，生成目标路径后，再需要重新设置。
			echo %%i
			pause
			exit
		)
		
	 	tar -zcvf %%i-release.tar.gz %%i\%%i-Release
		xcopy /i /y %%i-release.tar.gz %OUTPUT_DIR%\XYCetToolPack-release\
		del %%i-release.tar.gz
	)

	rem 切换到输出目录
	cd %OUTPUT_DIR%

	echo 正在打包 XYCetToolPack-release
	tar -zcvf XYCetToolPack-release.tar.gz XYCetToolPack-release\*.*
)

if %Mode%==5 (
	mkdir %OUTPUT_DIR%\XYCetToolPack-setup

	for %%i in (%CETTOOLDIRS%)  do (

		if not exist %%i (
			echo 目标路径不存在，生成目标路径后，再需要重新设置。
			echo %%i
			pause
			exit
		)
		
	 	tar -zcvf %%i-setup.tar.gz %%i\%%i-Setup
		xcopy /i /y %%i-setup.tar.gz %OUTPUT_DIR%\XYCetToolPack-setup\
		del %%i-setup.tar.gz
	)

	rem 切换到输出目录
	cd %OUTPUT_DIR%

	echo 正在打包 XYCetToolPack-setup
	tar -zcvf XYCetToolPack-setup.tar.gz XYCetToolPack-setup\*.*
)

echo ################## 打包成功 ###################
echo ## 打包模式=%Mode%
echo ## 1: 打包所有支持的CetTool({CetTool} {CetTool}-Release {CetTool}-Patch {CetTool}-Setup)
echo ## 2: 打包源代码内容({CetTool})
echo ## 3: 打包Patch内容({CetTool-Patch})
echo ## 4: 打包Release内容({CetTool}-Release)
echo ## 5: 打包Setup内容({CetTool}-Setup)
echo #################################################
pause
exit
