Extract JAR

- Rename it to `.zip`
- `unzip file.zip -d extracted`

---

- https://medium.com/rahasak/reverse-engineering-obfuscated-android-apk-67da84b259e4

We can reverse engineering android APK and extract the source code. For that we need to use three tools apktool, dex2jar and jd-gui. apktool can be used to extract and access to the resource files from APK. des2jar is a tool to convert Dalvik byte code(e.g classes.dex) to JVM byte code(e.g .JAR file). jd-gui is a Java decompiler which can use to extract source code from .jar file. To revers engineer APK file first we need convert the APK file into .jar file by using dex2jar. Then the .jar file can be decompile via jd-gui. Finally the resource files in the APK can be extracted via the apktool. Following are the main steps.

---

- https://infosecwriteups.com/how-to-use-ghidra-to-reverse-engineer-mobile-application-c2c89dc5b9aa