# mqtt

A new Flutter project.

## References:
* [Flutter: Create an MQTT app](https://www.youtube.com/watch?v=9d8s3zFTPCM)
* [mqtt_client](https://pub.dev/packages/mqtt_client)
* [provider](https://pub.dev/packages/provider)
  * `webview/pubspec.yaml`
  ```
  dependencies:
    flutter:
      sdk: flutter


    # The following adds the Cupertino Icons font to your application.
    # Use with the CupertinoIcons class for iOS style icons.
    cupertino_icons: ^1.0.2
    mqtt_client: ^9.6.8 # add it
    provider: ^6.0.3    # add it
    # ... SKIPPED ...
  ```

## MQTT
```
$ sudo apt-cache search mosquito
$ sudo apt-get install mosquitto
$ sudo apt-get install mosquitto-clients

# sub
$ mosquitto_sub - h 192.168.0.1 -t TOKEN

# pub
$ mosquitto_pub - h 192.168.0.1 -t TOKEN -m "Test"
```
