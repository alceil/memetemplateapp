import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:memetemplate/screens/fullscreen.dart';
import 'package:memetemplate/services/networkhandler.dart';

class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => new _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  final networkHandler = Networkhandling();
  // List<DocumentSnapshot> wallpapersList;
  List<String> kindi = [
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_1585668593523.jpg?alt=media&token=8d43c80a-672c-48f4-9f83-fba12f13b348',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_1585668614177.jpg?alt=media&token=d720a2cd-d255-4d84-a436-2a32fbebac7a',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_Plus_1595537994910.jpg?alt=media&token=df43cca1-c341-41dd-b037-38018db86092',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_Plus_1595536466687.jpg?alt=media&token=aec07574-3237-4c79-b616-897460bd2dea',
    'https://firebasestorage.googleapis.com/v0/b/memetemplate-3a61b.appspot.com/o/PhotoGrid_Plus_1595536436947.jpg?alt=media&token=96d1d1e0-3c05-4972-9cf3-dc99edc3ee3d'
  ];

  List imgurls = [];

  // StreamSubscription<QuerySnapshot> subscription;
  // final CollectionReference collectionReference =
  //     Firestore.instance.collection("wallpapers");

  // String getintadid() {
  //   return 'ca-app-pub-8197704697256296/3861583802';
  // }
  void getData() async {
    var res = await networkHandler.get("/memes/genMeme");
    print(res);
    setState(() {
      imgurls = res;
    });
  }

  // String appid() {
  //   return 'ca-app-pub-8197704697256296~8003992887';
  // }

  // InterstitialAd myInterstitial;

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
  //   // subscription = collectionReference.snapshots().listen((datasnapshot) {
  //   //   setState(() {
  //   //     wallpapersList = datasnapshot.documents;
  //   //   });
  //   // });
  // }

  // @override
  // void dispose() {
  //   subscription?.cancel();
  //   // FirebaseAdMob.instance.initialize(appId: appid());
  //   // myInterstitial.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(appId: appid());
    // myInterstitial = buildInterstitialAd()..load();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xfff5f8fd),
              borderRadius: BorderRadius.circular(30),
            ),
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: "search wallpapers", border: InputBorder.none),
                )),
                Container(child: Icon(Icons.search))
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0),
                itemCount: imgurls.length,
                itemBuilder: (context, i) {
                  return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenImagePage(imgurls[i]['imgUrl'])));
                      },
                      child: Hero(
                        tag: imgurls[i]['imgUrl'],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: imgurls[i]['imgUrl'],
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                          ),
                        ),
                      ));
                },
              ),
            ),
          ),
        ],
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
