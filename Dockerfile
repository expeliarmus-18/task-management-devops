# Stage 1: Build the Spring Boot application
FROM eclipse-temurin:21-jdk AS build

WORKDIR /workspace

# Copy Maven Wrapper files and project configuration
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./

# Ensure the wrapper script can run on Linux
RUN chmod +x mvnw

# Download dependencies first to improve build caching
RUN ./mvnw -B dependency:go-offline

# Copy application source code
COPY src/ src/

# Package the application; tests were already checked separately
RUN ./mvnw -B clean package -DskipTests

# Stage 2: Run the application
FROM eclipse-temurin:21-jre

WORKDIR /app

# Run the application as a non-root user
RUN useradd --system --create-home --uid 10001 appuser

# Copy only the executable JAR from the build stage
COPY --from=build /workspace/target/task_management-0.0.1-SNAPSHOT.jar app.jar

USER appuser

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
