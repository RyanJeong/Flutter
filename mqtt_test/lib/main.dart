import 'dart:async';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_test/mqtt.dart';

const String host = "172.30.1.41";
const String identifierSub = "MSM_Sub";
const String topicSub = "f";
const String identifierPub = "MSM_Pub";
const String topicPub = "r";

Future<int> main() async {
  MQTT clientSub = MQTT(
    identifier: identifierSub,
    host: host,
    topic: topicSub
  );
  clientSub.initializeMQTTClient();

  MQTT clientPub = MQTT(
    identifier: identifierPub,
    host: host,
    topic: topicPub
  );
  clientPub.initializeMQTTClient();

  clientSub.connect();
  clientSub.getMQTTObject()!.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage?>>? c) {
    clientPub.publish("test1");
  });

  return 0;
}
