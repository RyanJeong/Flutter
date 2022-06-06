import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WebView(
      initialUrl: 'https://www.naver.com', // http://10.0.0.1
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}
