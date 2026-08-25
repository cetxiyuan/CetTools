@echo off
title 发布Cet Tool工具
echo 说明：将软件包复制到指定的服务器目录下
echo 输出当前工作目录: 
echo %cd%

for %%i in (CetAssistTool,CetCANTestTool,CetDevelopmentKit,CetDiagnosticInstrument,
	CetNetworkTester,CetRemind,CetSimulateEcu,CetSScom,CetVehicleCollector,
	CetCryptoToolkit)  do (
	if not exist F:\sharefolder\cetqtlearn\%%i (
		echo 目标路径不存在，生成目标路径后，再需要重新设置。
		echo F:\sharefolder\cetqtlearn\%%i
		pause
		exit
	)

	echo 复制到 E:\httpwebsite\CetTools\CetSetup\ 目录下
	xcopy /i /y F:\sharefolder\cetqtlearn\%%i\%%i-Setup\Output\%%i-Setup-*-V*.exe E:\httpwebsite\CetTools\CetSetup\

	echo 复制到 F:\sharefolder\CetToolsRelease\CetTools\CetSetup\ 目录下
	xcopy /i /y F:\sharefolder\cetqtlearn\%%i\%%i-Setup\Output\%%i-Setup-Release-V*.exe F:\sharefolder\CetToolsRelease\CetTools\CetSetup\
)

echo ################## 程序发布结束 ###################
pause
exit
