#!/bin/bash
# 文件：cxy_git-ai_path_filter.sh
# 作者：CetXiyuan
# 功能：检查仓库路径是否在跳过列表中

# ================ 路径过滤配置 ================
REPO_PATH=$(git rev-parse --show-toplevel | sed 's/\//\\/g')

# 跳过路径列表（无需通配符）
SKIP_PATHS=(
  "F:\\sharefolder\\cetqtlearn"
  "F:\\sharefolder\\CetToolsRelease"
  "C:\\Users\\Administrator\\WorkBuddy"
  # 添加更多路径...
)

# 路径比较函数
function is_skip_path {
  local repo_path=$(echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/\\+$//')
  local skip_path=$(echo "$2" | tr '[:upper:]' '[:lower:]' | sed 's/\\+$//')
  
  [[ "$repo_path" == "$skip_path" ]] || [[ "$repo_path" == "$skip_path\\"* ]]
}

# 主检查逻辑
for path in "${SKIP_PATHS[@]}"; do
  if is_skip_path "$REPO_PATH" "$path"; then
    echo "⚠️ 跳过路径 [$REPO_PATH] 的AI Note上报（匹配跳过规则: $path）"
    exit 0  # 匹配到跳过规则，返回0表示跳过
  fi
done

exit 1  # 未匹配跳过规则，返回1表示继续执行