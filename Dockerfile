FROM openjdk:11
ADD ./target/DemoMavenProject-1.0-SNAPSHOT.jar billa.jar
ENTRYPOINT ["java", "-jar", "billa.jar"]
