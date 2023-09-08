FROM maven:3.8.6-openjdk-20.ea-b6 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:20-jdk
COPY --from=build /target/noodlestop-1.0-SNAPSHOT.war demo.war
EXPOSE 8080
ENTRYPOINT [ "java","-jar","demo.war" ]