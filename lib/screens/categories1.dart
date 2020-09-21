import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:memetemplate/screens/catogoriesview.dart';
import 'package:memetemplate/screens/widgets/widgets.dart';

class Categories1 extends StatefulWidget {
  @override
  _Categories1State createState() => _Categories1State();
}

class _Categories1State extends State<Categories1> {
  final CollectionReference ref = Firestore.instance.collection('categories');
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
  }

  @override
  void dispose() {
    myInterstitial.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, i) => InkWell(
                      onTap: () {
                        showInterstitialAd();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CatogoryView(
                                      loc: snapshot
                                          .data.documents[i].data['catname'],
                                    )));
                      },
                      child: CategoryTile(
                          context: context,
                          imgurl: snapshot.data.documents[i].data['url']
                              .toString()),
                    ));
          }),
    );
  }
}
