import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

void main() async {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

Future<String> send(String host, String pw, String sdk) async {
  String url = 'http://192.168.0.' + host + ':80/post';
  print(url);
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'ContentType': 'application/json; charset=UTF-8',
    },
    body: <String, String> {
      'password': pw,
      'sdk_key': sdk
    },
  );
  print("Status code: " + response.statusCode.toString());
  print("Content length: " + response.contentLength.toString());
  print("Reason phrase: " + response.reasonPhrase.toString());
  print(response.body);

  return response.body;
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  TextEditingController hostController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController sdkController = TextEditingController();
  TextEditingController debugController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HTTP Test')
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  color: Color(0xffeeeeee),
                  padding: EdgeInsets.all(10.0),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100.0,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: SizedBox(
                          height: 90.0,
                          child: new TextField(
                            maxLines: 100,
                            controller: debugController,
                            readOnly: true,
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Debugging area',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: hostController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '192.168.0.host',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: sdkController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'SDK Key',
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    String res = await send(
                          hostController.text,
                          passwordController.text,
                          sdkController.text).whenComplete(() => null);
                    debugController.text = res;
                  },
                ),
              ],
            )
        )
    );
  }
}