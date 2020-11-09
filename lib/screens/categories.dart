import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
// //import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:memetemplate/models/Category.dart';
import 'package:memetemplate/screens/catogoriesview.dart';
import 'package:memetemplate/services/networkhandler.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final networkHandler = Networkhandling();
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool loader = true;
  List<Category> searchresult = [];

  List imgurls = [];
  List<Category> catlist = [];

  String getintadid() {
    return 'ca-app-pub-8197704697256296/8387169056';
  }

  String appid() {
    return 'ca-app-pub-8197704697256296~8003992887';
  }

  String bannerid() {
    return 'ca-app-pub-3263954522700294/4117286019';
  }

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

  void getData() async {
    var res = await networkHandler.get("/memes/addMeme");

    setState(() {
      imgurls = res;
      catlist = imgurls.map((e) => Category.fromJson(e)).toList();
      loader = false;
    });
  }

  void showInterstitialAd() {
    myInterstitial..show();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // FirebaseAdMob.instance.initialize(appId: appid());
  //   // myBanner = buildBannerAd()..load();
  //   // myInterstitial = buildInterstitialAd()..load();
  //   getData();
  // }

  @override
  void dispose() {
    // myBanner.dispose();
    myInterstitial.dispose();
    super.dispose();
  }

  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
    FirebaseAdMob.instance.initialize(appId: appid());
    myInterstitial = buildInterstitialAd()..load();
    // FacebookAudienceNetwork.init();
    // _loadInterstitialAd();
    //showBannerAd();
  }

  void showRandomInterstitialAd() {
    Random r = new Random();
    bool value = r.nextBool();

    if (value == true) {
      myInterstitial..show();
    }
  }

  // void _loadInterstitialAd() {
  //   FacebookInterstitialAd.loadInterstitialAd(
  //     placementId:
  //         "IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617", //"IMG_16_9_APP_INSTALL#2312433698835503_2650502525028617" YOUR_PLACEMENT_ID
  //     listener: (result, value) {
  //       print(">> FAN > Interstitial Ad: $result --> $value");
  //       if (result == InterstitialAdResult.LOADED)
  //         _isInterstitialAdLoaded = true;

  //       /// Once an Interstitial Ad has been dismissed and becomes invalidated,
  //       /// load a fresh Ad by calling this function.
  //       if (result == InterstitialAdResult.DISMISSED &&
  //           value["invalidated"] == true) {
  //         _isInterstitialAdLoaded = false;
  //         // _loadInterstitialAd();
  //       }
  //     },
  //   );
  // }

  Widget _currentAd = SizedBox(
    width: 0.0,
    height: 0.0,
  );

  // _showInterstitialAd() {
  //   if (_isInterstitialAdLoaded == true)
  //     FacebookInterstitialAd.showInterstitialAd();
  //   else
  //     print("Interstial Ad not yet loaded!");
  // }

  // showBannerAd() {
  //   setState(() {
  //     _currentAd = FacebookBannerAd(
  //       placementId: "1219781665081235_1226333427759392", //testid
  //       bannerSize: BannerSize.STANDARD,
  //       listener: (result, value) {
  //         print("Banner Ad: $result -->  $value");
  //       },
  //     );
  //   });
  // }

  void searchOperation(String searchText) {
    setState(() {
      searchresult = catlist
          .where((r) =>
              (r.cname.toLowerCase().contains(searchText.trim().toLowerCase())))
          .toList();
    });
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
                            hintText: "search categories",
                            border: InputBorder.none),
                        onChanged: searchOperation,
                      )),
                      Container(child: Icon(Icons.search))
                    ],
                  ),
                ),
                Flexible(
                    child: searchresult.length != 0 ||
                            _controller.text.isNotEmpty
                        ? new ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchresult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  showRandomInterstitialAd();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CatogoryView(
                                                loc:
                                                    searchresult[index].catdata,
                                              )));
                                },
                                child: new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                searchresult[index].imgurl,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    'images/categoryph.jpeg'),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : new ListView.builder(
                            shrinkWrap: true,
                            itemCount: catlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  showRandomInterstitialAd();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CatogoryView(
                                                loc: catlist[index].catdata,
                                              )));
                                },
                                child: new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: <Widget>[
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: CachedNetworkImage(
                                            imageUrl: catlist[index].imgurl,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    'images/categoryph.jpeg'),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )),
              ],
            ));
  }
}

//  Flexible(
//           child: ListView.builder(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               itemCount: imgurls.length,
//               itemBuilder: (context, i) => InkWell(
//                     onTap: () {
//                      //_showInterstitialAd();
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CatogoryView(
//                                     loc: imgurls[i]['images'],
//                                   )));
//                     },
//                     child: CategoryTile(
//                         context: context,
//                         imgurl: imgurls[i]['imgUrl'].toString()),
//                   )),
//         )
