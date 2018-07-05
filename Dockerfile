FROM alpine

LABEL com.mtenrero.jmeter.version="3.3"
LABEL vendor="mtenrero.com"
LABEL maintainer="Marcos Tenrero"

RUN apk --update add openjdk8-jre-base
RUN apk --update add wget

RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-3.3.tgz
RUN tar zxvf apache-jmeter*.tgz
RUN apk del wget

RUN wget https://github.com/delirius325/jmeter-elasticsearch-backend-listener/releases/download/2.3.1/jmeter.backendlistener.elasticsearch-2.3.1.jar
RUN cp jmeter.backendlistener.elasticsearch-2.3.1.jar /apache-jmeter-3.3/lib/ext/jmeter.backendlistener.elasticsearch-2.3.1.jar

COPY tools/jmeter_startpoint.sh /script/jmeter_startpoint.sh

RUN rm -f apache-jmeter*.tgz
RUN rm -fr /apache-jmeter*/docs

ENTRYPOINT [ "/bin/ash", "/script/jmeter_startpoint.sh" ]
