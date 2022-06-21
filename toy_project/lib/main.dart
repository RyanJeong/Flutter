// Default
import 'package:flutter/material.dart';

// Webview
import 'package:webview_flutter/webview_flutter.dart';

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
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondRoute()),
                    );
                    setState(() {
                      print("setState()");
                      print(Globals.rasp);
                      print(Globals.app);
                      if (Globals.rasp != null &&
                          Globals.app != null) {
                        _isSetup = true;
                      } else {
                        _isSetup = false;
                      }
                      print(_isSetup);
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

class SecondRoute extends StatefulWidget {
  final CookieManager? cookieManager;
  const SecondRoute({Key? key, this.cookieManager}) : super(key: key);

  @override
  State<SecondRoute> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<SecondRoute> {
  late WebViewController _controller;

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
        initialUrl: Globals.webviewUrl;
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
        },
        onPageFinished: (String url) {
          if (url.contains("connect")) {
            ParseAndPop(url);
          }
        },
      ),
    );
  }

  void ParseAndPop(String url) async {
    Globals.rasp = await _controller.runJavascriptReturningResult(
        "document.getElementById('serial1').innerHTML");  // r
    Globals.app = await _controller.runJavascriptReturningResult(
        "document.getElementById('serial2').innerHTML");  // f

    Navigator.pop(context);
  }
}
