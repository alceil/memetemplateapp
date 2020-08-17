import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:memetemplate/screens/fullscreen.dart';

class CatogoryView extends StatefulWidget {
  @override
  _CatogoryViewState createState() => _CatogoryViewState();
}

class _CatogoryViewState extends State<CatogoryView> {
  final String cat = '';
  // final CollectionReference collectionReference =
  //     Firestore.instance.collection('cat');
  List<DocumentSnapshot> wlist;
  StreamSubscription<QuerySnapshot> subscription;
  @override
  void initState() {
    super.initState();
    subscription =
        Firestore.instance.collection(cat).snapshots().listen((snaps) {
      setState(() {
        wlist = snaps.documents;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('kindi'),
        ),
        body: wlist != null
            ? StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: wlist.length,
                itemBuilder: (context, i) {
                  String imgpath = wlist[i].data['url'];
                  return Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenImagePage(imgpath)));
                      },
                      child: Hero(
                          tag: imgpath,
                          child: FadeInImage(
                            placeholder: AssetImage('images/'),
                            image: NetworkImage(imgpath),
                            fit: BoxFit.cover,
                          )),
                    ),
                  );
                },
                staggeredTileBuilder: (i) =>
                    StaggeredTile.count(2, i.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
