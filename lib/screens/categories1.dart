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
    BannerAd myBanner;

  BannerAd buildBannerAd() {
    return BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myBanner..show();
          }
        });
  }
  InterstitialAd myInterstitial;
  InterstitialAd buildInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
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
                          imgurl:
                              snapshot.data.documents[i].data['url'].toString(),
                          cname: snapshot.data.documents[i].data['catname']),
                    ));
          }),
    );
  }
}
1