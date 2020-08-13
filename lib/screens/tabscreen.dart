import 'package:flutter/material.dart';
import 'package:memetemplate/screens/categories.dart';
import 'package:memetemplate/screens/wallpaper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Meme hub',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 5.0,
            actions: <Widget>[],
            bottom: TabBar(tabs: <Widget>[
              Tab(
                text: 'Memes',
              ),
              Tab(text: 'Categories'),
            ]),
          ),
          body: TabBarView(children: <Widget>[WallScreen(), Categories()]),
        ));
  }
}
