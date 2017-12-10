FROM alpine

LABEL com.mtenrero.jmeter.version="3.3.0"
LABEL vendor="mtenrero.com"
LABEL maintainer="Marcos Tenrero"

RUN apk --update add openjdk8-jre-base
RUN apk -- update add wget

RUN wget http://ftp.cixug.es/apache//jmeter/binaries/apache-jmeter-3.3.tgz
RUN tar zxvf apache-jmeter*.tgz
RUN apk del wget

COPY ./test /test
COPY jmeter_startpoint.sh /script/jmeter_startpoint.sh

RUN rm -f apache-jmeter*.tgz
RUN rm -fr /apache-jmeter*/docs

EXPOSE 7777
EXPOSE 1099
EXPOSE 4445

ENTRYPOINT [ "/bin/ash", "/script/jmeter_startpoint.sh" ]