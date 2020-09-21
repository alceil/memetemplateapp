import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:memetemplate/screens/fullscreen.dart';

class CatogoryView extends StatefulWidget {
  List loc;
  CatogoryView({Key key, this.loc}) : super(key: key);
  @override
  _CatogoryViewState createState() => _CatogoryViewState(loc: this.loc);
}

class _CatogoryViewState extends State<CatogoryView> {
  List loc;
  _CatogoryViewState({Key key, this.loc});

  // @override
  // void initState() {
  //   super.initState();
  //   subscription =
  //       Firestore.instance.collection(loc).snapshots().listen((snaps) {
  //     setState(() {
  //       wlist = snaps.documents;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0),
          itemCount: loc.length,
          itemBuilder: (context, i) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImagePage(loc[i]['url'])));
                },
                child: Hero(
                  tag: loc[i],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: loc[i]['url'],
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
