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
    webview_flutter: ^3.0.4 # add it
  ```
  * Android
    * `webview/android/app/build.gradle`
    ```
    android {
        defaultConfig {
            minSdkVersion 20  // fix it
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
            android:usesCleartextTraffic="true"> <!-- add it(http support) -->
            <!-- ... SKIPPED ... -->
        </application>
    </manifest>
    ```
  * iOS
    * `webview/ios/Runner/Info.plist`
      ```
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>io.flutter.embedded_views_preview</key>  <!-- add it -->
        <string>YES</string>                          <!-- add it -->
        <key>NSAllowsArbitraryLoads</key>             <!-- add it(http support) -->
        <true/>                                       <!-- add it(http support) -->
        <key>NSAllowsArbitraryLoadsInWebContent</key> <!-- add it(http support) -->
        <true/>                                       <!-- add it(http support) -->
        <!-- ... SKIPPED ... -->
      </dict>
      </plist>
      ```
