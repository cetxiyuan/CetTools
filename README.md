# CetTools 发布仓库

> 存放 CetXiyuan 发布的正式版可执行软件、软件授权文件和软件升级配置文件。

---

## 仓库结构

```
CetTools/
├── CetSetup/                      # 各软件安装包及升级配置
│   ├── *-Setup-Release-*.exe      # 各工具安装程序（正式版）
│   ├── *-Setup-Patch-*.exe        # 各工具补丁包
│   ├── CetCommandLineTool.exe     # 命令行工具
│   ├── CetCommandLineTool.cnf     # 命令行工具配置文件
│   ├── software_update.json       # 软件升级描述文件（通用）
│   ├── software_update.zip        # 软件升级配置压缩包
│   ├── zcetls_software_update.json# 软件升级描述文件（TLS/HTTPS版）
│   └── zcetls_software_update.zip # 软件升级配置压缩包（TLS/HTTPS版）
├── CetLicense/                    # 各软件各版本的公有授权文件（.clic）
│   ├── *.clic                     # 公有授权文件
│   ├── LicPublic.cnf              # 授权路径映射配置
│   └── zcetls_software_auth.cxy   # 授权信息表
├── CetScript/                     # 辅助脚本
│   ├── CetToolsRemote.bat         # 远程执行脚本（记录执行日志）
│   ├── cxy_git_pull_all.ps1       # 批量 git pull 所有子仓库脚本
│   ├── cxy_git_pull_all_run.bat   # 上述脚本的启动器
│   └── script.bat                 # 通用脚本
└── README.md
```

---

## 软件清单

| 软件名称 | 最新版本 | 更新日期 | 说明 |
|---|---|---|---|
| **CetCANTestTool** | 正式版 V3.5.0 + 补丁包 V3.5.0.7171 | 2026-07-17 | CAN 总线测试工具 |
| **CetDevelopmentKit** | 正式版 V2.5.0 + 补丁包 V2.5.0.7171 | 2026-07-17 | 开发集成工具包，支持 ADB 数据导出 |
| **CetVehicleCollector** | 正式版 V2.5.0 + 补丁包 V2.5.0.7171 | 2026-07-17 | 车辆数据采集工具，支持 GBK/UTF-8 编码自适应 |
| **CetDiagnosticInstrument** | 正式版 V4.5.0 + 补丁包 V4.5.0.7171 | 2026-07-17 | 诊断仪工具 |
| **CetNetworkTester** | 正式版 V3.5.0 + 补丁包 V3.5.0.7171 | 2026-07-17 | 网络测试工具，支持新能源 GB32960(2025版) 协议解析 |
| **CetSimulateEcu** | 正式版 V5.5.0 + 补丁包 V5.5.0.7171 | 2026-07-17 | ECU 模拟工具，支持 OTA 升级功能 |
| **CetSScom** | 正式版 V5.5.0 + 补丁包 V5.5.0.7171 | 2026-07-17 | 串口通信工具，支持 GBK/UTF-8 编码自适应 |
| **CetCryptoToolkit** | 正式版 V2.5.0 + 补丁包 V2.5.0.7171 | 2026-07-17 | 加密工具包，基于 OpenSSL，支持国密 SM2 及验签 |
| **CetAssistTool** | V1.1.2 | — | 辅助工具 |
| **CetRemind** | V1.3.3 | — | 提醒工具 |
| **CetLoanCalculator** | V1.2.2 | — | 贷款计算器 |
| **CetSuperLotto** | V2.4.2 | — | 超级乐透工具 |
| **CetToolDLLs** | V2.1.3 | — | 共享库 DLL 安装包（供各工具精简体积使用） |
| **CetCommandLineTool** | — | 2026-07-20 | 命令行工具（集成于各软件） |

---

## 软件授权（CetLicense）

`CetLicense/` 目录下存放各工具各版本的 **公有授权文件**（`.clic` 格式），命名规则：

```
{软件名}{版本号}_PUBLIC.clic
```

示例：`CetSimulateEcu480_PUBLIC.clic`

公有授权文件由服务器自动生成，用户安装后自动加载，无需手动激活。

---

## 软件自动升级机制

`CetSetup/zcetls_software_update.json` 描述了各工具的远程升级信息，软件启动时通过 HTTPS 请求（经 nginx 代理）查询该文件，判断是否有新版本可用。

字段说明：

| 字段 | 含义 |
|---|---|
| `LatestVersion` | 当前最新版本号 |
| `UpdateTime` | 发布日期 |
| `ReleaseNote` | 版本更新说明 |
| `DownloadUrl` | 升级包下载地址（Gitee API） |
| `installCommand` | 安装后校验命令 |
| `promptMessage` | 启动时提示信息 |

---

## 辅助脚本说明

### `CetScript/cxy_git_pull_all.ps1`

批量对以下所有子仓库执行 `git pull`，输出成功/失败汇总：

```
CetCANTestTool, CetDevelopmentKit, CetDiagnosticInstrument,
CetNetworkTester, CetSimulateEcu, CetSScom, CetVehicleCollector,
CetCryptoToolkit, CetAssistTool, CetLoanCalculator, CetNetworkServer,
CetQtTools, CetRemind, CetSuperLotto, CetToolDLLs, CetToolLicense
```

运行方式：双击 `cxy_git_pull_all_run.bat` 或在 PowerShell 中执行：

```powershell
.\CetScript\cxy_git_pull_all.ps1
```

## 作者

**CetXiyuan**
