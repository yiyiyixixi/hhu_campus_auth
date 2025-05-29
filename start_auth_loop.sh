#!/bin/bash

while true; do
  echo "$(date) - 开始执行校园网认证"
  /usr/local/bin/ruijie_general_python.sh
  echo "$(date) - 认证完成，等待下一轮"
  sleep 1800  # 休眠1800秒（30分钟），根据需求调整
done

