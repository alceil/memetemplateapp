import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';

import 'package:flutter/material.dart';
import 'package:memetemplate/models/general.dart';
import 'package:memetemplate/screens/fullscreen.dart';
import 'package:memetemplate/services/networkhandler.dart';

class WallScreen extends StatefulWidget {
  @override
  _WallScreenState createState() => new _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  final networkHandler = Networkhandling();
  List<General> searchresult = [];
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  List imgurls = [];
  List<General> catlist = [];
  bool loader = true;
  // final List<General> _fav = [];
  bool alreadysaved = false;

  void getData() async {
    var res = await networkHandler.get("/memes/genMeme");
    setState(() {
      imgurls = res;
      catlist = imgurls.map((e) => General.fromJson(e)).toList();
      loader = false;
    });
  }

  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
    FacebookAudienceNetwork.init();
    _loadInterstitialAd();
    //showBannerAd();
  }

  void _loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId:
          "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617", //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED)
          _isInterstitialAdLoaded = true;

        /// Once an Interstitial Ad has been dismissed and becomes invalidated,
        /// load a fresh Ad by calling this function.
        if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          _isInterstitialAdLoaded = false;
          _loadInterstitialAd();
        }
      },
    );
  }

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  _showInterstitialAd() {
    if (_isInterstitialAdLoaded == true)
      FacebookInterstitialAd.showInterstitialAd();
    else
      print("Interstial Ad not yet loaded!");
  }

  showBannerAd() {
    setState(() {
      _currentAd = FacebookBannerAd(
        placementId:
            "IMG_16_9_APP_INSTALL#2312433698835503_2964944860251047", //testid
        bannerSize: BannerSize.STANDARD,
        listener: (result, value) {
          print("Banner Ad: $result -->  $value");
        },
      );
    });
  }

  Widget _buildgrid(General gen) {
    // this.alreadysaved = _fav.contains(gen);
    return InkWell(
        onTap: () {
          _showInterstitialAd();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImagePage(gen.imgurl, gen.memename)));
        },
        child: Hero(
          tag: gen.imgurl,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: gen.imgurl,
                  placeholder: (context, url) =>
                      Image.asset('images/memes.jpeg'),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 140,
              //   child: IconButton(
              //     icon: Icon(
              //       alreadysaved ? Icons.favorite : Icons.favorite_border,
              //       color: Colors.pink,
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         if (alreadysaved) {
              //           _fav.remove(gen);
              //           print(_fav);
              //         } else {
              //           _fav.add(gen);
              //           print(_fav);
              //         }
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ));
  }

  Widget _buildsearchgrid(General gen) {
    // this.alreadysaved = _fav.contains(gen);
    return InkWell(
        onTap: () {
          _showInterstitialAd();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImagePage(gen.imgurl, gen.memename)));
        },
        child: Hero(
          tag: gen.imgurl,
          child: Stack(
            children: [
              // IconButton(
              //   icon: Icon(
              //     this.alreadysaved ? Icons.favorite : Icons.favorite_border,
              //     color: Colors.pink,
              //   ),
              //   onPressed: () {
              //     if (alreadysaved) {
              //       _fav.remove(gen);
              //     } else {
              //       _fav.add(gen);
              //     }
              //   },
              // ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: gen.imgurl,
                  placeholder: (context, url) =>
                      Image.asset('images/memes.jpeg'),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   left: 140,
              //   child: IconButton(
              //     icon: Icon(
              //       this.alreadysaved ? Icons.favorite : Icons.favorite_border,
              //       color: alreadysaved ? Colors.pink : null,
              //     ),
              //     onPressed: () {
              //       setState(() {
              //         if (alreadysaved) {
              //           _fav.remove(gen);
              //           print(_fav);
              //         } else {
              //           _fav.add(gen);
              //           print(_fav);
              //         }
              //       });
              //     },
              //   ),
              // ),
            ],
          ),
        ));
  }

  // String getintadid() {
  //   return 'ca-app-pub-8197704697256296/3861583802';
  // }

  // String appid() {
  //   return 'ca-app-pub-8197704697256296~8003992887';
  // }

  // String bannerid() {
  //   return 'ca-app-pub-3263954522700294/4117286019';
  // }

  // BannerAd myBanner;

  // BannerAd buildBannerAd() {
  //   return BannerAd(
  //       adUnitId: bannerid(),
  //       size: AdSize.banner,
  //       listener: (MobileAdEvent event) {
  //         if (event == MobileAdEvent.loaded) {
  //           myBanner..show();
  //         }
  //       });
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
  // void dispose() {
  //   FirebaseAdMob.instance.initialize(appId: appid());
  //   myBanner.dispose();
  //   myInterstitial.dispose();
  //   super.dispose();
  // }

  void searchOperation(String searchText) {
    setState(() {
      searchresult = catlist
          .where((r) => (r.memename
              .toLowerCase()
              .contains(searchText.trim().toLowerCase())))
          .toList();
    });
    print(searchresult[0].memename);
  }

  @override
  Widget build(BuildContext context) {
    return loader
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            key: globalKey,
            body: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
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
                        controller: _controller,
                        decoration: InputDecoration(
                            hintText: "search wallpapers",
                            border: InputBorder.none),
                        onChanged: searchOperation,
                      )),
                      Container(child: Icon(Icons.search))
                    ],
                  ),
                ),
                Flexible(
                  child: searchresult.length != 0 || _controller.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 6.0,
                                    mainAxisSpacing: 6.0),
                            itemCount: searchresult.length,
                            itemBuilder: (context, i) {
                              return _buildsearchgrid(searchresult[i]);
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 6.0,
                                    mainAxisSpacing: 6.0),
                            itemCount: catlist.length,
                            itemBuilder: (context, i) {
                              return _buildgrid(catlist[i]);
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
// InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => FullScreenImagePage(
//                                           catlist[i].imgurl)));
//                             },
//                             child: Hero(
//                               tag: catlist[i].imgurl,
//                               child: Stack(
//                                 children: [
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(16),
//                                     child: CachedNetworkImage(
//                                       imageUrl: catlist[i].imgurl,
//                                       placeholder: (context, url) =>
//                                           CircularProgressIndicator(),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 0,
//                                     left: 140,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         alreadysaved
//                                             ? Icons.favorite
//                                             : Icons.favorite_border,
//                                         color:
//                                             alreadysaved ? Colors.pink : null,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           this.alreadysaved = true;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                             );
//  InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => FullScreenImagePage(
//                                           searchresult[i].imgurl)));
//                             },
//                             child: Hero(
//                               tag: searchresult[i].imgurl,
//                               child: Stack(
//                                 children: [
//                                   IconButton(
//                                     icon: Icon(
//                                       alreadysaved
//                                           ? Icons.favorite
//                                           : Icons.favorite_border,
//                                       color: alreadysaved ? Colors.pink : null,
//                                     ),
//                                     onPressed: () {},
//                                   ),
//                                   ClipRRect(
//                                     borderRadius: BorderRadius.circular(16),
//                                     child: CachedNetworkImage(
//                                       imageUrl: searchresult[i].imgurl,
//                                       placeholder: (context, url) =>
//                                           CircularProgressIndicator(),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 0,
//                                     left: 140,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         alreadysaved
//                                             ? Icons.favorite
//                                             : Icons.favorite_border,
//                                         color:
//                                             alreadysaved ? Colors.pink : null,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           this.alreadysaved = true;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ));
