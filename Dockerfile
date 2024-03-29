ARG ALPINE_VERSION='edge'
ARG BIND_VERSION='=9.18.4-r2'

FROM alpine:${ALPINE_VERSION}
LABEL org.opencontainers.image.authors="ddgorczynski@gmail.com"
ARG BIND_VERSION

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
        bind${BIND_VERSION} \
        supervisor && \
    rm -rf /var/cache/apk/*

ADD ./conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD ./conf/named.conf /etc/bind/

EXPOSE 53/udp 53/tcp 953/tcp

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
HEALTHCHECK --timeout=10s CMD dig @127.0.0.1 ns.localhost

