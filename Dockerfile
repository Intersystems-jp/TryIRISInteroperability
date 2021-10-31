ARG IMAGE=container.intersystems.com/intersystems/irishealth-community:2021.1.0.215.3
FROM $IMAGE

USER root

# jdbc related 
RUN apt-get update && DEBUAB_FRONTEND=noninteractive apt-get -y install openjdk-8-jre \
 && apt clean

WORKDIR /opt/app

RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/app

USER ${ISC_PACKAGE_MGRUSER}

COPY src src
COPY iris.script /tmp/iris.script

# run iris and initial 
RUN iris start IRIS \
    && iris session IRIS < /tmp/iris.script \
    && iris stop IRIS quietly