## Signature versions

- android/app/build.gradle
  - ```
    android {
      signingConfigs {
        release {
          enableV1Signing = false
          enableV2Signing = false
          enableV3Signing = true
        }
      }
    }
    ```
- android/app/build.gradle
  - ```
    buildscript {
      ext {
        minSdkVersion = (set according to the minimum API level that supports the signatures enabled above)
      }
    }
    ```