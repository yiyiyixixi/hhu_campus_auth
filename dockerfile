FROM alpine:latest

RUN apk add --no-cache bash curl coreutils gawk python3

COPY ruijie_general_python.sh /usr/local/bin/ruijie_general_python.sh
COPY start_auth_loop.sh /usr/local/bin/start_auth_loop.sh

RUN chmod +x /usr/local/bin/ruijie_general_python.sh /usr/local/bin/start_auth_loop.sh

ENTRYPOINT ["/usr/local/bin/start_auth_loop.sh"]

