FROM tomcat:9.0-jdk11-openjdk
COPY target/nameregistration.war /usr/local/tomcat/webapps/nameregistration.war
