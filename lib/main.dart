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
                new MaterialButton(
                    child: const Text('Open new Activity'),
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
      await platform.invokeMethod('');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String _channel = 'increment';
  static const String _pong = 'pong';
  static const String _emptyMessage = '';
  static const BasicMessageChannel<String> platform =
      const BasicMessageChannel<String>(_channel, const StringCodec());

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    platform.setMessageHandler(_handlePlatformIncrement);
  }

  Future<String> _handlePlatformIncrement(String message) async {
    setState(() {
      _counter++;
    });
    return _emptyMessage;
  }

  void _sendFlutterIncrement() {
    platform.send(_pong);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Center(
                child: new Text(
                    'Platform button tapped $_counter time${ _counter == 1
                        ? ''
                        : 's' }.',
                    style: const TextStyle(fontSize: 17.0))),
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 15.0, left: 5.0),
            child: new Row(
              children: <Widget>[
                new Image.asset('assets/flutter-mark-square-64.png',
                    scale: 1.5),
                const Text('Flutter', style: const TextStyle(fontSize: 30.0)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendFlutterIncrement,
        child: const Icon(Icons.add),
      ),
    );
  }
}
