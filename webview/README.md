# webview

A new Flutter project.

## References:
* [webview_flutter](https://pub.dev/packages/webview_flutter)
  * `webview/pubspec.yaml`
  ```
  dependencies:
    flutter:
      sdk: flutter


    # The following adds the Cupertino Icons font to your application.
    # Use with the CupertinoIcons class for iOS style icons.
    cupertino_icons: ^1.0.2
    webview_flutter: ^3.0.4 # <-
  ```
  * `webview/android/app/build.gradle`
  ```
  android {
      defaultConfig {
          minSdkVersion 20
      }
  }
  ```
  * `webview/android/app/src/main/AndroidManifest.xml`
  ```
  <manifest xmlns:android="http://schemas.android.com/apk/res/android"
      package="com.example.webview">
     <application
          android:label="webview"
          android:name="${applicationName}"
          android:icon="@mipmap/ic_launcher"
          android:usesCleartextTraffic="true"> <!-- < -->
          <!-- ... SKIPPED ... -->
      </application>
  </manifest>
  ```
