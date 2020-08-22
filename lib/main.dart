import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:memetemplate/screens/tabscreen.dart';
import 'package:memetemplate/screens/wallpaper.dart';

// void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Kannada Meme Templates';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(primaryColor: Colors.white),
      home: Home(),
    );
  }
}
