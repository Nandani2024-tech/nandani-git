# Uses the Eclipse Temurin Java 21 image as the base environment for the Docker container.
FROM eclipse-temurin:21

WORKDIR /app

COPY JavaServer.java .

RUN javac JavaServer.java

EXPOSE 8080

CMD ["java", "JavaServer"]


# HelloWorld.java
#       ↓
# COPY into container
#       ↓
# RUN javac HelloWorld.java
#       ↓
# HelloWorld.class
#       ↓
# CMD → java HelloWorld
#       ↓
# Hello World from Java!

# Notice something important: we don't need to copy HelloWorld.class. Docker compiles the .java file inside the image using javac.