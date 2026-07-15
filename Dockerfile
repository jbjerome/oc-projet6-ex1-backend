# syntax=docker/dockerfile:1

# ---- Stage 1 : compilation + packaging via Gradle ----
FROM eclipse-temurin:21-jdk AS build
WORKDIR /workspace

COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
RUN chmod +x ./gradlew

COPY src ./src

RUN ./gradlew --no-daemon clean bootWar

# ---- Stage 2 : exécution ----
FROM eclipse-temurin:21-jre AS runtime
WORKDIR /app

COPY --from=build /workspace/build/libs/*.war app.war

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.war"]
