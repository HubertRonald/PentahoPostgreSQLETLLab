FROM ubuntu:18.04

ENV PENTAHO_SERVER /opt/pentaho-server
ARG relative_path

RUN apt update
RUN apt install wget unzip -y
WORKDIR /tmp
COPY ./${relative_path}/install-java.sh .
# COPY ./${relative_path}/jdk-8-linux-x64.tar.gz .
# COPY ./${relative_path}/pentaho-server-ce.zip .
COPY ./${relative_path}/pivot4j-pentaho-1.0-plugin.zip.1 ./pivot4j-pentaho-1.0-plugin.zip
COPY ./${relative_path}/datafor.zip.1 ./datafor.zip
COPY ./${relative_path}/jsf-api-1.1_02.jar .
COPY ./${relative_path}/ImportHandlerMimeTypeDefinitions.xml .
COPY ./${relative_path}/importExport.xml .

RUN wget https://github.com/frekele/oracle-java/releases/download/8u201-b09/jdk-8u201-linux-x64.tar.gz -O jdk-8-linux-x64.tar.gz
RUN wget https://privatefilesbucket-community-edition.s3.us-west-2.amazonaws.com/9.4.0.0-343/ce/server/pentaho-server-ce-9.4.0.0-343.zip -O pentaho-server-ce.zip

RUN ./install-java.sh -f jdk-8-linux-x64.tar.gz
RUN unzip /tmp/pentaho-server-ce.zip -d /opt
RUN unzip /tmp/pivot4j-pentaho-1.0-plugin.zip -d ${PENTAHO_SERVER}/pentaho-solutions/system
RUN unzip /tmp/datafor.zip -d ${PENTAHO_SERVER}/pentaho-solutions/system
RUN mv /tmp/jsf-api-1.1_02.jar ${PENTAHO_SERVER}/tomcat/webapps/pentaho/WEB-INF/lib
RUN cp /tmp/ImportHandlerMimeTypeDefinitions.xml ${PENTAHO_SERVER}/pentaho-solutions/system
RUN cp /tmp/importExport.xml ${PENTAHO_SERVER}/pentaho-solutions/system

RUN sed -i -e "s|requestParameterAuthenticationEnabled=false|requestParameterAuthenticationEnabled=true|g" ${PENTAHO_SERVER}/pentaho-solutions/system/security.properties

#Eliminar Drivers BigData (probado solo en versión 9)
#RUN rm ${PENTAHO_SERVER}/pentaho-solutions/ADDITIONAL-FILES/drivers/*.kar
#RUN rm ${PENTAHO_SERVER}/pentaho-solutions/system/kettle/plugins/pentaho-big-data-plugin/*.zip

#Inhabilitar el prompt inicial por las actualizaciones
RUN rm ${PENTAHO_SERVER}/promptuser.sh
#Inhabilitar el modo demon de Tomcat
RUN sed -i -e 's/\(exec ".*"\) start/\1 run/' ${PENTAHO_SERVER}/tomcat/bin/startup.sh

RUN rm /tmp/pentaho-server-ce.zip
RUN rm /tmp/jdk-8-linux-x64.tar.gz
RUN rm /tmp/install-java.sh
RUN rm /tmp/pivot4j-pentaho-1.0-plugin.zip
RUN rm /tmp/datafor.zip
RUN rm /tmp/*.xml

RUN chmod +x ${PENTAHO_SERVER}/*.sh
RUN chmod +x ${PENTAHO_SERVER}/tomcat/bin/*.sh

RUN PATH="${PENTAHO_SERVER}:$PATH"
RUN export PATH

EXPOSE 8080

ENTRYPOINT ["/opt/pentaho-server/start-pentaho.sh"]
