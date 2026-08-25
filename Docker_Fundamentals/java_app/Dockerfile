# Uses the Eclipse Temurin Java 21 image as the base environment for the Docker container.
FROM eclipse-temurin:21   

WORKDIR /app

COPY HelloWorld.java .

RUN javac HelloWorld.java

CMD ["java", "HelloWorld"]




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