#!/bin/sh

# 显示使用方法
show_usage() {
	echo "用法: $0 [base_dir] [-f]"
	echo "示例: $0 ~/v"
	echo "选项:"
	echo "  -f    强制执行，即使目录不存在"
	echo "  -h    显示帮助信息"
	echo "如果不指定 base_dir，将使用默认值: ~/v"
}

# 处理命令行参数
FORCE=0
while [ $# -gt 0 ]; do
	case $1 in
	-h | --help)
		show_usage
		exit 0
		;;
	-f | --force)
		FORCE=1
		shift
		;;
	*)
		BASE_DIR=$1
		shift
		;;
	esac
done

# 定义基础目录并展开路径
BASE_DIR=${BASE_DIR:-$HOME/v}

# 检查目录是否存在
if [ ! -d "$BASE_DIR" ] && [ $FORCE -eq 0 ]; then
	echo "错误: 目录 $BASE_DIR 不存在"
	echo "使用 -f 选项强制执行"
	exit 1
fi

# 动态获取子目录（最多6个）
SUBDIRS=$(ls -1 "$BASE_DIR" 2>/dev/null | grep -v '^\.' | head -n 6)
if [ -z "$SUBDIRS" ]; then
	echo "警告: 在 $BASE_DIR 中没有找到任何子目录"
	exit 1
fi

# 检查主配置文件是否可写
CONFIG_FILE="$HOME/.gitconfig"
if ! touch -a "$CONFIG_FILE" 2>/dev/null; then
	echo "错误: 无法写入 $CONFIG_FILE"
	exit 1
fi

# 检查是否已存在相同 BASE_DIR 的配置
if grep -q "# Base directory: ${BASE_DIR}$" "$CONFIG_FILE"; then
	echo "已存在 ${BASE_DIR} 的配置块，跳过"
	exit 0
fi

# 创建临时文件
TEMP_CONFIG=$(mktemp)
if [ $? -ne 0 ]; then
	echo "错误: 无法创建临时文件"
	exit 1
fi

# 添加分隔注释
echo "" >>"$TEMP_CONFIG"
echo "# Generated Git configurations - $(date '+%Y-%m-%d %H:%M:%S')" >>"$TEMP_CONFIG"
echo "# Base directory: ${BASE_DIR}" >>"$TEMP_CONFIG"

# 标记是否有新配置
NEW_CONFIGS=0

# 遍历子目录并生成配置
echo "$SUBDIRS" | while read -r dir; do
	# 只处理存在的目录
	if [ -d "${BASE_DIR}/${dir}" ]; then
		# 检查配置是否已存在
		if grep -q "gitdir:${BASE_DIR}/${dir}/" "$CONFIG_FILE"; then
			echo "配置已存在，跳过: ${BASE_DIR}/${dir}"
			continue
		fi

		echo "找到新目录: ${BASE_DIR}/${dir}"
		NEW_CONFIGS=1

		# 追加 includeIf 配置到临时文件
		cat >>"$TEMP_CONFIG" <<EOF

[includeIf "gitdir:${BASE_DIR}/${dir}/"]
    path = ~/.gitconfig-${dir}
EOF

		# 创建子配置文件（如果不存在）
		config_file="$HOME/.gitconfig-${dir}"
		if [ ! -f "$config_file" ]; then
			if ! echo "# Git configuration for ${dir}" >"$config_file" 2>/dev/null; then
				echo "警告: 无法创建配置文件 $config_file"
				continue
			fi
			echo "Created configuration file: $config_file"
		fi
	else
		echo "跳过不存在的目录: ${BASE_DIR}/${dir}"
	fi
done

# 检查是否有新配置需要追加
if [ -s "$TEMP_CONFIG" ]; then
	# 追加新配置到主配置文件
	cat "$TEMP_CONFIG" >>"$CONFIG_FILE"
	echo "新的 Git 配置已追加到 $CONFIG_FILE"
else
	echo "没有新的配置需要追加"
fi

# 清理临时文件
rm -f "$TEMP_CONFIG"
