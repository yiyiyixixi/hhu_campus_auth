#!/bin/bash

#If received parameters is less than 2, print usage
#if [ "${#}" -lt "2" ]; then
#  echo "Usage: ./ruijie_general.sh username password"
#  echo "Example: ./ruijie_general.sh 201620000000 123456"
#  exit 1
#fi

SERVICE="中国移动(CMCC NET)" #可选值为：校园外网服务(out-campus NET)  中国电信(常州)   中国联通(常州)     中国移动(CMCC NET)
PASSWORD=""
USER_ID=""

#Exit the script when is already online, use www.google.cn/generate_204 to check the online status
captiveReturnCode=`curl -s -I -m 10 -o /dev/null -s -w %{http_code} http://www.google.cn/generate_204`
if [ "${captiveReturnCode}" = "204" ]; then
  echo "You are already online!"
  exit 0
fi

#If not online, begin Ruijie Auth

#Get Ruijie login page URL
loginPageURL=`curl -s "http://www.google.cn/generate_204" | awk -F \' '{print $2}'`

#Structure loginURL
loginURL=`echo ${loginPageURL} | awk -F \? '{print $1}'`
loginURL="${loginURL/index.jsp/InterFace.do?method=login}"

#Structure quertString
queryString=`echo ${loginPageURL} | awk -F \? '{print $2}'`
queryString="${queryString//&/%2526}"
queryString="${queryString//=/%253D}"

echo "loginURL: $loginURL"
echo "queryString: $queryString"


ENCODED_SERVICE=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(urllib.parse.quote(sys.argv[1])))" "$SERVICE")

ENCODED_PASSWORD=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(urllib.parse.quote(sys.argv[1])))" "$PASSWORD")

echo "ENCODED_SERVICE: $ENCODED_SERVICE"
echo "ENCODED_Password: $ENCODED_Password"

#Send Ruijie eportal auth request and output result
if [ -n "${loginURL}" ]; then
  authResult=`curl -s -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.91 Safari/537.36" -e "${loginPageURL}" -b "EPORTAL_COOKIE_USERNAME=; EPORTAL_COOKIE_PASSWORD=; EPORTAL_COOKIE_SERVER=; EPORTAL_COOKIE_SERVER_NAME=; EPORTAL_AUTO_LAND=; EPORTAL_USER_GROUP=; EPORTAL_COOKIE_OPERATORPWD=;" -d "userId=${USER_ID}&password=${ENCODED_PASSWORD}&service=${ENCODED_SERVICE}&queryString=${queryString}&operatorPwd=&operatorUserId=&validcode=&passwordEncrypt=false" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" "${loginURL}"`
  echo $authResult
fi
