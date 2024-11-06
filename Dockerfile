# Use an official OpenJDK as a parent image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the target folder to the container's working directory
COPY target/user-service-1.0.0.jar /app/user-service.jar

# Expose port 8080 to the outside world
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "/app/user-service.jar"]

