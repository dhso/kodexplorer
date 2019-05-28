FROM alpine:20190228

LABEL MAINTAINER="dhso <dhso@163.com>"

# 配置glibc
ENV GLIBC_VERSION=2.29-r0
ENV RRSHAREWEB_SRC_URL=http://appdown.rrys.tv/rrshareweb_centos7.tar.gz

RUN apk update \
	&& apk --no-cache add wget libstdc++ tzdata \
	&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo 'Asia/Shanghai' >  /etc/timezone \
	&& wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
	&& wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
	&& wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk \
 	&& apk --no-cache add glibc-${GLIBC_VERSION}.apk \
	&& apk --no-cache add glibc-bin-${GLIBC_VERSION}.apk \
	&& mkdir -p /rrshare \
	&& mkdir -p /opt/work/store \
	&& wget -q ${RRSHAREWEB_SRC_URL} -O /rrshare/rrshareweb.tar.gz \
	&& tar zxvf /rrshare/rrshareweb.tar.gz -C /rrshare/ \
	&& rm -rf /rrshare/rrshareweb.tar.gz \
	&& apk del wget tzdata \
	&& rm -rf /glibc-${GLIBC_VERSION}.apk \
	&& rm -rf /glibc-bin-${GLIBC_VERSION}.apk

WORKDIR /
VOLUME ["/opt/work/store"]
EXPOSE 3001

CMD ["sh", "-c", "/rrshare/rrshareweb/rrshareweb"]