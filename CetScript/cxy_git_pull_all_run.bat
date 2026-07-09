@rem ============================================================
@rem 脚本名称: cxy_git_pull_all_run.bat
@rem 设计者:   CetXiyuan
@rem 创建时间: 2026-03-18
@rem 脚本描述: 启动器脚本，以绕过执行策略的方式调用
@rem           cxy_git_pull_all.ps1，批量拉取所有 Git 仓库的最新代码。
@rem ============================================================
@echo off
powershell -ExecutionPolicy Bypass -File "%~dp0cxy_git_pull_all.ps1"
