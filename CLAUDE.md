# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 仓库性质

这是一个**发布/分发仓库**，不含源代码。存放内容：
- 各工具的 Windows 安装包（`.exe`）
- 公有授权文件（`.clic`）
- 软件自动升级配置（JSON）
- 辅助脚本

源代码位于独立仓库，路径在 `F:\sharefolder\cetqtlearn\` 下（如 `CetSScom`、`CetSimulateEcu` 等）。

## 主要维护任务

### 1. 更新软件版本

发布新版本时需同步更新两个文件：

**`CetSetup/zcetls_software_update.json`** — 更新对应工具的：
- `LatestVersion`：版本号字符串
- `UpdateTime`：发布日期
- `ReleaseNote`：更新说明（`\t\n` 分隔条目）
- `DownloadUrl`：Gitee API 下载地址

**`CetLicense/`** — 添加新版本的公有授权文件，命名规则：
```
{软件名}{版本号}_PUBLIC.clic
```
示例：`CetSimulateEcu531_PUBLIC.clic`（版本 V5.3.1 → 数字 531）

### 2. 批量拉取所有子仓库

```powershell
.\CetScript\cxy_git_pull_all.ps1
```
或双击 `CetScript\cxy_git_pull_all_run.bat`。

涵盖仓库：`CetCANTestTool`, `CetDevelopmentKit`, `CetDiagnosticInstrument`, `CetNetworkTester`, `CetSimulateEcu`, `CetSScom`, `CetVehicleCollector`, `CetCryptoToolkit`, `CetAssistTool`, `CetLoanCalculator`, `CetNetworkServer`, `CetQtTools`, `CetRemind`, `CetSuperLotto`, `CetToolDLLs`, `CetToolLicense`

## 架构说明

### 自动升级机制

软件启动时通过 HTTPS（经 nginx 代理）请求 `zcetls_software_update.json`，对比 `LatestVersion` 判断是否有新版本，有则提示下载 `DownloadUrl` 指向的安装包。

### 授权机制

`.clic` 文件由服务器自动生成，用户安装后自动加载，无需手动激活。`LicPublic.cnf` 记录各工具名称到授权文件路径的映射。

### Git pre-push 钩子

`pre-push` 钩子在推送前统计 AI/人工代码贡献行数并上报内部监控服务器。`cxy_git-ai_path_filter.sh` 定义跳过上报的路径（`cetqtlearn`、`CetToolsRelease` 等）。
