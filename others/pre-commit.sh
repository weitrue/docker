#!/bin/bash
STAGED_GO_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep ".go$")
if [[ $STAGED_GO_FILES == "" ]]; then
  exit 0
fi
PASS=true

for FILE in $STAGED_GO_FILES; do
  # 跳过 vendor 目录下的文件
  if [[ $FILE == "vendor"* ]]; then
    continue
  fi

  # 调整排序导入包
  goimports-reviser -file-path $FILE -local "gitlab.com.cn" project-name "gitlab.com.cn/test/backend-micro/" -rm-unused
  if [[ $? != 0 ]]; then
    PASS=false
  fi

  # 格式化代码
  gofumpt -w -s -extra $FILE
  if [[ $? != 0 ]]; then
    PASS=false
  fi

  # 上述操作可能会对文件作出改动
  # 所以此处将更改提交至暂存区
  git add $FILE
done

if ! $PASS; then
  printf "\033[31m COMMIT FAILED \033[0m\n"
  exit 1
else
  printf "\033[32m COMMIT SUCCEEDED \033[0m\n"
fi

exit 0
