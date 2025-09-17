# hhu_campus_auth
河海大学锐捷校园网认证脚本

其中`ruijie_general_python.sh`使用`python3`实现`url encode`

`ruijie_general.sh`使用`curl`命令实现`url encode`

推荐前者，兼容性更好

## 使用方法
修改`ruijie_general_python.sh`中的`USER_ID`和`PASSWORD`为你的学号和密码

默认`SERVICE`字段为`中国移动(CMCC NET)`（可选值为`校园外网服务(out-campus NET)`、`中国电信(常州)`、`中国联通(常州)`、`中国移动(CMCC NET)`）

执行 `./ruijie_general_python.sh`
或
使用`dockerfile`构建镜像

注：windows下可使用`git bash`命令行执行sh文件

## More
脚本基于 https://github.com/callmeliwen/RuijiePortalLoginTool 实现

指定网卡 loginPageURL=`curl -s -L --interface wlan0 -v "http://10.96.0.155" | awk -F \' '{print $2}'`

