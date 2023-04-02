
## Auto Reload

Add `developmentOnly("org.springframework.boot:spring-boot-devtools")` to gradle dependencies

## Debugging

Pass `agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000` as JVM arguments.

In Gradle, you can run `gradle bootRun -Dagentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000`

Update the build.gradle file to ensure Gradle passes command line arguments to the JVM:

```
bootRun {
   systemProperties = System.properties
}
```