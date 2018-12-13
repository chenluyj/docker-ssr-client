FROM alpine

MAINTAINER storezhang "storezhang@gmail.com"

ENV SSR_DATA="/ssr-data"

EXPOSE 1082

VOLUME ${SSR_DATA}
WORKDIR ${SSR_DATA}

ADD ./polipo/polipo /usr/bin/polipo
ADD ./polipo/config ${SSR_DATA}/polipo/config
ADD ./shadowsocks/config.json ${SSR_DATA}/shadowsocks/config.json
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN set -x \
    && echo -e "https://mirrors.ustc.edu.cn/alpine/latest-stable/main\nhttps://mirrors.ustc.edu.cn/alpine/latest-stable/community" > /etc/apk/repositories \
    && apk update \
    && apk --no-cache add su-exec python supervisor libsodium\
    && chmod 777 /usr/bin/polipo \
    && adduser -S -h ${SSR_DATA} ssr \
    && chown -R ssr "${SSR_DATA}" \
    && chmod -R 777 "${SSR_DATA}"

COPY ./shadowsocks /opt/shadowsocks

ENTRYPOINT ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
