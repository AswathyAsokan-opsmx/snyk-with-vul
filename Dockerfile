FROM maven:3.8.5-openjdk-11 AS builder

# Set the working directory
WORKDIR /app

# Copy the entire project
COPY . .

# Build the project and package it
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK runtime for the final image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the default application port (adjust if necessary)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
