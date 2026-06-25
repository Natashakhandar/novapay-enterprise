# Stage 1: Build Stage (Heavy SDK)
FROM maven:3.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime Stage (Distroless / Minimal)
FROM gcr.io/distroless/java17-debian11:nonroot
WORKDIR /app
# Copy only the compiled binary
COPY --from=builder /app/target/payments-api.jar ./app.jar

# Enforce non-root user (Security Best Practice)
USER 1000:1000

# Expose API and Actuator ports
EXPOSE 8080 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
