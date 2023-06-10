## `buildTypes` and `productFlavors`
- https://developer.android.com/build/build-variants

## Secrets
- https://developers.google.com/maps/documentation/android-sdk/secrets-gradle-plugin
- https://developer.android.com/training/articles/keystore.html
- 
  ```groovy
  def apikeyPropertiesFile = rootProject.file("apikey.properties")
  def apikeyProperties = new Properties()
  apikeyProperties.load(new FileInputStream(apikeyPropertiesFile))
   
  android {
  
    defaultConfig {
       
      // should correspond to key/value pairs inside the file   
      buildConfigField("String", "CONSUMER_KEY", apikeyProperties['CONSUMER_KEY'])
      buildConfigField("String", "CONSUMER_SECRET", apikeyProperties['CONSUMER_SECRET'])
    }
  } 
```
- `android/local.properties`
  - https://blog.mindorks.com/using-local-properties-file-to-avoid-api-keys-check-in-into-version-control-system/?utm_source=pocket_mylist