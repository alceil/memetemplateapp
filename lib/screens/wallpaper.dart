import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:memetemplate/screens/fullscreen.dart';

class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => new _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  List<DocumentSnapshot> wallpapersList;
  StreamSubscription<QuerySnapshot> subscription;
  final CollectionReference collectionReference =
      Firestore.instance.collection("general");

  String getintadid() {
    return 'ca-app-pub-8197704697256296/3861583802';
  }

  String appid() {
    return 'ca-app-pub-8197704697256296~8003992887';
  }

  InterstitialAd myInterstitial;

  InterstitialAd buildInterstitialAd() {
    return InterstitialAd(
      adUnitId: getintadid(),
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          myInterstitial..load();
        } else if (event == MobileAdEvent.closed) {
          myInterstitial = buildInterstitialAd()..load();
        }
        print(event);
      },
    );
  }

  void showInterstitialAd() {
    myInterstitial..show();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: appid());
    myInterstitial = buildInterstitialAd()..load();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    FirebaseAdMob.instance.initialize(appId: appid());
    myInterstitial.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: wallpapersList != null
            ? new StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: wallpapersList.length,
                itemBuilder: (context, i) {
                  String imgPath = wallpapersList[i].data['url'];
                  return new Material(
                    elevation: 8.0,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(8.0)),
                    child: new InkWell(
                      onTap: () {
                        showInterstitialAd();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenImagePage(imgPath)));
                      },
                      child: new Hero(
                        tag: imgPath,
                        child: new FadeInImage(
                          image: new NetworkImage(imgPath),
                          fit: BoxFit.cover,
                          placeholder: new AssetImage("assets/wallfy.png"),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (i) =>
                    new StaggeredTile.count(2, i.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            : new Center(
                child: new CircularProgressIndicator(),
              ));
  }
}
