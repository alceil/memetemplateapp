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
  List<String> kindi = [
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_1585668593523.jpg?alt=media&token=8d43c80a-672c-48f4-9f83-fba12f13b348',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_1585668614177.jpg?alt=media&token=d720a2cd-d255-4d84-a436-2a32fbebac7a',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_Plus_1595537994910.jpg?alt=media&token=df43cca1-c341-41dd-b037-38018db86092',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_Plus_1595536466687.jpg?alt=media&token=aec07574-3237-4c79-b616-897460bd2dea',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_Plus_1595536436947.jpg?alt=media&token=96d1d1e0-3c05-4972-9cf3-dc99edc3ee3d'
  ];
  StreamSubscription<QuerySnapshot> subscription;
  final CollectionReference collectionReference =
      Firestore.instance.collection("wallpapers");

  // String getintadid() {
  //   return 'ca-app-pub-8197704697256296/3861583802';
  // }

  // String appid() {
  //   return 'ca-app-pub-8197704697256296~8003992887';
  // }

  InterstitialAd myInterstitial;

  // InterstitialAd buildInterstitialAd() {
  //   return InterstitialAd(
  //     adUnitId: getintadid(),
  //     listener: (MobileAdEvent event) {
  //       if (event == MobileAdEvent.failedToLoad) {
  //         myInterstitial..load();
  //       } else if (event == MobileAdEvent.closed) {
  //         myInterstitial = buildInterstitialAd()..load();
  //       }
  //       print(event);
  //     },
  //   );
  // }

  // void showInterstitialAd() {
  //   myInterstitial..show();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // FirebaseAdMob.instance.initialize(appId: appid());
  //   // myInterstitial = buildInterstitialAd()..load();
  //   subscription = collectionReference.snapshots().listen((datasnapshot) {
  //     setState(() {
  //       wallpapersList = datasnapshot.documents;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   // FirebaseAdMob.instance.initialize(appId: appid());
  //   // myInterstitial.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 6.0, mainAxisSpacing: 6.0),
          itemCount: kindi.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImagePage(kindi[index])));
                },
                child: Hero(
                  tag: kindi[index],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      imageUrl: 'https://picsum.photos/250?image=9',
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}

// GridView.count(
//       crossAxisCount: 2,
//       childAspectRatio: 0.6,
//       crossAxisSpacing: 6.0,
//       children: kindi
//           .map((e) => Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Image.network(
//                 e,
//                 height: 200,
//                 width: 200,
//               )))
//           .toList(),
//     )

//  wallpapersList != null
//             ? new StaggeredGridView.countBuilder(
//                 padding: const EdgeInsets.all(8.0),
//                 crossAxisCount: 4,
//                 itemCount: wallpapersList.length,
//                 itemBuilder: (context, i) {
//                   String imgPath = wallpapersList[i].data['url'];
//                   return new Material(
//                     elevation: 8.0,
//                     borderRadius:
//                         new BorderRadius.all(new Radius.circular(8.0)),
//                     child: new InkWell(
//                       onTap: () {
//                         showInterstitialAd();
//                         Navigator.push(
//                             context,
//                             new MaterialPageRoute(
//                                 builder: (context) =>
//                                     FullScreenImagePage(imgPath)));
//                       },
//                       child: new Hero(
//                         tag: imgPath,
//                         child: new FadeInImage(
//                           image: new NetworkImage(imgPath),
//                           fit: BoxFit.cover,
//                           placeholder: new AssetImage("assets/wallfy.png"),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 staggeredTileBuilder: (i) =>
//                     new StaggeredTile.count(2, i.isEven ? 2 : 3),
//                 mainAxisSpacing: 8.0,
//                 crossAxisSpacing: 8.0,
//               )
//             : new Center(
//                 child: new CircularProgressIndicator(),
//               ));
