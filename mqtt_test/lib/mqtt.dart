import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTT {
  MqttServerClient? _client;
  final String _host;
  final String _identifier;
  final String _topic;

  MQTT(
      { required String host,
        required String identifier,
        required String topic }) :
        _identifier = identifier,
        _host = host,
        _topic = topic;

  void initializeMQTTClient() {
    _client = MqttServerClient(_host, _identifier);

    _client!.port = 1883;
    _client!.keepAlivePeriod = 20;
    _client!.secure = false;
    _client!.logging(on: true);

    _client!.onConnected = onConnected;
    _client!.onSubscribed = onSubscribed;
    _client!.onDisconnected = onDisconnected;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(_identifier)
        .withWillTopic(
        'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    _client!.connectionMessage = connMess;
  }

  Future<void> connect() async {
    assert(_client != null);
    try {
      print('MQTT::connect(): '
          'Trying to connect ...');
      await _client!.connect();
    } on Exception catch (e) {
      print('MQTT::connect(): '
          'Exception - $e');
      disconnect();
    }
  }

  bool isConnect() {
    return _client!.connectionStatus!.state == MqttConnectionState.connected;
  }

  void disconnect() {
    _client!.disconnect();
  }

  Future<void> publish(String message) async {
    await connect();
    print('MQTT::publish():'
        'try to publish, topic: $_topic, msg: $message');
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _client!.publishMessage(_topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void onSubscribed(String topic) {
    print('MQTT::onSubscribed(): '
        'Subscription confirmed for topic $topic');
  }

  void onDisconnected() {
    if (_client!.connectionStatus!.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('MQTT::onDisconnected(): '
          'Disconnection callback is solicited, this is correct');
    } else {
      print('MQTT::onDisconnected(): '
          'Disconnection callback is unsolicited or none,'
          'this is incorrect - exiting');
      exit(-1);
    }
  }

  void onConnected() {
    print('MQTT::onConnected()');
    _client!.subscribe(_topic, MqttQos.atLeastOnce);
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      // ignore: avoid_as
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;

      // final MqttPublishMessage recMess = c![0].payload;
      final String pt =
      MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print('MQTT::onConnected(): '
          'Change notification:: topic is <${c[0].topic}>, '
          'payload is <-- $pt -->');
      print('');
    });
  }
}