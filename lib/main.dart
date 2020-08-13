import 'package:flutter/material.dart';
import 'package:memetemplate/screens/tabscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Isolate Demo';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primaryColor: Colors.white),
      home: Home(),
    );
  }
}
