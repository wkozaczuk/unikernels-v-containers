FROM openjdk:8-alpine

WORKDIR /app

ADD ./target/restapi-1.0-SNAPSHOT-jar-with-dependencies.jar /app/app.jar

EXPOSE 80

CMD ["java","-jar","app.jar"]

