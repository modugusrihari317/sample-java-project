##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/sample-java-project
WORKDIR /opt/sample-java-project
COPY . .
RUN mvn clean install    ## artifact -- .war

### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/sample-java-project/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
