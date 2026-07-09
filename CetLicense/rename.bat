@echo off
setlocal enabledelayedexpansion

:: 配置参数
set /p base=请输入目标名: 
if "%base%"=="" (
	echo 项目名为空
	pause
	exit
)
set /p end=请输入结束值: 
if "%end%"=="" (
	echo 结束值为空
	pause
	exit
)
set "suffix=_PUBLIC.clic"
set "start=100"
set "step=10"

:: 检查源文件是否存在
if not exist "%base%%start%%suffix%" (
    echo 错误：找不到源文件 "%base%%start%%suffix%"
    pause
    exit /b
)

:: 批量复制/重命名
for /L %%n in (%start%,%step%,%end%) do (
    if %%n gtr %start% (
        set "newfile=%base%%%n%suffix%"
        echo 生成: "!newfile!"
        copy "%base%%start%%suffix%" "!newfile!" >nul
    )
)

echo 已完成！生成从 %start% 到 %end%（步长 %step%）的所有文件
pause
