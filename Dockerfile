FROM tomcat:9-jdk21

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/ecommerce-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080