FROM librenms/librenms:latest

RUN "apk add perl-dev"
RUN "apk add perl-app-cpanminus"
RUN "apk add alpine-sdk"
RUN "cpanm Monitoring::Plugin"
