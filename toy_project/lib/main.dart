// Default
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

// Webview
import 'package:webview_flutter/webview_flutter.dart';

// html and http
import 'package:html/parser.dart';
import 'package:http/http.dart';

// MQTT
import 'package:provider/provider.dart';
import 'package:toy_project/widgets/mqttView.dart';
import 'package:toy_project/mqtt/state/MQTTAppState.dart';

// globals
import 'package:toy_project/globals.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatefulWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  _FirstRoute createState() => _FirstRoute();
}

class _FirstRoute extends State<FirstRoute> {
  bool _isSetup = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MSM Project'),
      ),
      body: Container(
        child: Column(
            children: <Widget>[
              Container(
                height: 500,
                child: ChangeNotifierProvider<MQTTAppState>(
                  create: (_) => MQTTAppState(),
                  /// child: MQTTView(),
                  child: Visibility(
                    child: MQTTView(),
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _isSetup,
                  ),
                ),
              ),
              Container(
                height: 50,
                child: RaisedButton(
                  child: const Text('WiFi Setup'),
                  onPressed: () async {
                    /// this.setState(() {
                    ///   Globals.isSetup = !Globals.isSetup;
                    /// });
                    /// print(Globals.isSetup);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondRoute()),
                    );
                    setState(() {
                      _isSetup = Globals.isSetup;
                    });
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}

//   child: RaisedButton(
//     child: const Text('WiFi Setup'),
//     onPressed: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const SecondRoute()),
//       );
//     },
//   ),
// ),

class SecondRoute extends StatefulWidget {
  final CookieManager? cookieManager;
  const SecondRoute({Key? key, this.cookieManager}) : super(key: key);

  @override
  State<SecondRoute> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<SecondRoute> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('WiFi Setup'),
      ),
      body: WebView(
        initialUrl: 'http://10.0.0.1',
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) {
          print("onPageFinished: " + url);
          if (url.contains("connect")) {
            print("onPageFinished, contains connect");
            ParseAndPop(url);
          }
        },
      ),
    );
  }

  void ParseAndPop(String url) async {
    print(url);
    Response response = await get(Uri.parse(url));
    print(response.statusCode);
    var doc = parse(response.body);
    print(doc.body);
    var serial1 = doc.getElementById('serial1');
    print(serial1?.innerHtml);
    var serial2 = doc.getElementById('serial2');
    print(serial2?.innerHtml);
    print(Globals.isSetup);
    Globals.isSetup = true;
    print(Globals.isSetup);
    Navigator.pop(context);
    // if (response.statusCode == 200) {
    //   var doc = parse(response.body);
    //   var serial1 = doc.getElementById('serial1');
    //   print(serial1?.innerHtml);
    //   var serial2 = doc.getElementById('serial2');
    //   print(serial2?.innerHtml);
    //   isActive = true;
    //   Navigator.pop(context);
    // } else {
    //   print('error ${response.statusCode}');
    // }
  }
}
