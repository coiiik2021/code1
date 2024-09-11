FROM maven:3-openjdk-17 AS build
WORKDIR /app

COPY . .
RUN mvn clean package -DskipTests

# Kiểm tra xem file WAR có được tạo ra không
RUN ls /app/target

# Run stage
FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=build /app/target/demoTest-1.0-SNAPSHOT.war demotest.war
EXPOSE 8080

ENTRYPOINT ["java","-jar","demotest.war"]
