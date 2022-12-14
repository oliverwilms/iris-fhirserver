ARG IMAGE=intersystemsdc/irishealth-community:latest
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN mkdir -p /opt/irisapp/fhir-input
RUN chown -R ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp

USER ${ISC_PACKAGE_MGRUSER}

COPY  src src
COPY data/fhir fhirdata
COPY data/recordmap/delimited delimited
COPY iris.script /tmp/iris.script
COPY fhirUI /usr/irissys/csp/user/fhirUI
COPY interop/src interop/src
COPY sds.xml sds.xml
COPY %ZSTART.mac .

# run iris and initial 
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
	&& iris stop iris quietly
