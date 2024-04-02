FROM librenms/librenms:latest

# FOR check_rbl
RUN apk add perl-dev
RUN apk add perl-app-cpanminus
RUN apk add alpine-sdk
RUN cpanm Monitoring::Plugin

RUN apk add perl-capture-tiny
RUN apk add perl-net-domain-tld --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community/
RUN apk add perl-data-validate-domain --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/
RUN apk add perl-data-validate-ip --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/
RUN apk add perl-net-dns
RUN apk add perl-net-ip
RUN apk add perl-readonly

WORKDIR /tmp
RUN wget https://github.com/matteocorti/check_rbl/releases/download/v1.7.3/check_rbl-1.7.3.tar.gz
RUN tar -zxf check_rbl-1.7.3.tar.gz

WORKDIR /tmp/check_rbl-1.7.3
RUN perl Makefile.PL INSTALLSCRIPT=/data/monitoring-plugins INSTALLSITESCRIPT=/data/monitoring-plugins
RUN make
RUN make install
RUN rm -rf /tmp/ckeck_rbl*

# FOR check_ssl_validity
RUN apk add perl-crypt-x509
RUN apk add perl-date-format
RUN apk add perl-lwp-protocol-https
RUN apk add perl-text-glob

WORKDIR /opt/librenms
