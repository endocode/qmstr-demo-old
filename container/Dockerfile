FROM ubuntu:19.04 as demobase

RUN apt-get update && apt-get install -y build-essential ccache apt-utils

# install runtime deps
COPY --from=qmstr/master_build /usr/local/bin/qmstr /usr/local/bin/qmstr
COPY --from=qmstr/master_build /usr/local/bin/qmstr-wrapper /usr/local/bin/qmstr-wrapper
COPY --from=qmstr/master_build /usr/local/bin/qmstrctl /usr/local/bin/qmstrctl

ENV GOPATH /go
ENV PATH ${GOPATH}/bin:/usr/lib/go-1.9/bin:$PATH

VOLUME /go/src

# java base projects deps
FROM openjdk:8 as javademobase

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y git maven

ARG QMSTR_BRANCH=master
ARG QMSTR_FORK=QMSTR
RUN git clone -b ${QMSTR_BRANCH} --single-branch https://github.com/${QMSTR_FORK}/qmstr.git /tmp/qmstr

WORKDIR /tmp/qmstr
RUN cd lib/java-qmstr && ./gradlew install
RUN cd modules/builders/qmstr-gradle-plugin && ./gradlew install
RUN cd modules/builders/qmstr-maven-plugin && mvn install

RUN rm -fr /tmp/qmstr

RUN mkdir -p /maven/conf
ENV M2_HOME /maven

ADD settings.xml /usr/share/maven/conf/settings.xml

RUN mv /root/.m2/repository /maven/repo

RUN chmod -R 777 /maven/repo
RUN ls -lR /maven/repo
