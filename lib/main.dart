import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter Demo',
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text('Welcome to Flutter'),
            ),
            body: FlutterPage()));
  }
}

class FlutterPage extends StatefulWidget {
  @override
  FlutterComponent createState() => new FlutterComponent();
}

class FlutterComponent extends State<FlutterPage> {
  static const String _channel = 'test_activity';
  static const platform = const MethodChannel(_channel);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, rowNumber) {
          return new Container(
            padding: EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Text('Flutter Component',
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                new SizedBox(height: 16.0,),
                new MaterialButton(
                    child: const Text('Open Screen'),
                    elevation: 5.0,
                    height: 48.0,
                    minWidth: 250.0,
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () {
                      print("button pressed");
                      _getNewActivity();
                    }),
              ],
            ),
          );
        });
  }

  _getNewActivity() async {
    try {
      await platform.invokeMethod('startNewActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}

