@echo off
title Cet Tool工具DLLs的发布
echo 说明：将新Cet Tool工具的插件和共享库分别复制到工具的插件目录以及根目录下
echo 
echo 输出当前工作目录: 
echo %cd%

for %%i in (CetCANTestTool,CetDevelopmentKit,CetDiagnosticInstrument,
	CetNetworkTester,CetSimulateEcu,CetSScom,CetVehicleCollector,
	CetCryptoToolkit)  do (

	if not exist %%i (
		echo 目标路径不存在，生成目标路径后，再需要重新设置。
		echo %%i
		pause
		exit
	)

	echo 复制到 %%i\%%i-Release\plugins\ 目录下
	xcopy /i /y CetToolDLLs\CetToolDLLs\plugins\*.dll %%i\%%i-Release\plugins\
	xcopy /i /y CetToolDLLs\CetToolDLLs\plugins\CetPlugins.ini %%i\%%i-Release\plugins\

	echo 复制 CetProductWizard.dll 共享库 ...
	xcopy /i /y CetToolDLLs\CetToolDLLs\libs\CetProductWizard.dll %%i\%%i-Release\
	xcopy /i /y CetToolDLLs\CetToolDLLs\libs\CetProductWizard.dll %%i\%%i\libs\
	
	echo 复制 productwizard.h 安装向导 ...
	xcopy /i /y CetToolDLLs\CetToolLibs\CetProductWizard\productwizard.h %%i\%%i\mainwindow

	echo 复制 cettoolplugincontext.h 工具插件上下文 ...
	xcopy /i /y CetToolDLLs\CetToolLibs\CetProductWizard\cettoolplugincontext.h %%i\%%i\mainwindow
)

echo ################## 插件复制结束 ###################
pause
exit
