FROM jelastic/maven:3.8.6-openjdk-20.ea-b6 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jre11
COPY --from=build /target/noodlestop-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/noodlestop.war
EXPOSE 8080
CMD ["catalina.sh", "run"]