FROM maven:3.5-jdk-8 AS builder

WORKDIR /opt/hello_world

COPY pom.xml .
RUN mvn install

COPY . .
RUN mvn package

FROM openjdk:8-jre-alpine3.7
WORKDIR /usr/src/myapp
COPY --from=builder /opt/hello_world/target .

RUN addgroup -S java && adduser -S -g java appuser
USER appuser

CMD ["java", "-jar", "hello-world-app-0.1.0.jar"]