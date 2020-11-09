import 'package:cached_network_image/cached_network_image.dart';
// //import 'package:facebook_audience_network/facebook_audience_network.dart';

import 'package:flutter/material.dart';
import 'package:memetemplate/screens/fullscreen.dart';

class CatogoryView extends StatefulWidget {
  List loc;
  CatogoryView({Key key, this.loc}) : super(key: key);
  @override
  _CatogoryViewState createState() => _CatogoryViewState(loc: this.loc);
}

class _CatogoryViewState extends State<CatogoryView> {
  List loc;
  List test;
  List searchresult = new List();
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  _CatogoryViewState({Key key, this.loc});
  Widget appBarTitle = new Text(
    "Meme",
    style: new TextStyle(color: Colors.black),
  );
  Icon icon = new Icon(
    Icons.search,
    color: Colors.black,
  );

  String getintadid() {
    return 'ca-app-pub-8197704697256296/3861583802';
  }

  String appid() {
    return 'ca-app-pub-8197704697256296~8003992887';
  }

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

  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    test = loc;
    // getData();
    // FacebookAudienceNetwork.init();
    // _loadInterstitialAd();
    //showBannerAd();
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
      searchresult = loc
          .where((r) => (r['memename']
              .toLowerCase()
              .contains(searchText.trim().toLowerCase())))
          .toList();
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   test = loc;
  //   print(loc);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(title: appBarTitle, actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: new IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (this.icon.icon == Icons.search) {
                  this.icon = new Icon(
                    Icons.close,
                    color: Colors.black,
                  );
                  this.appBarTitle = new TextField(
                    controller: _controller,
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search, color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.white)),
                    onChanged: searchOperation,
                  );
                } else {
                  setState(() {
                    this.icon = new Icon(
                      Icons.search,
                      color: Colors.black,
                    );
                    this.appBarTitle = new Text(
                      "Meme",
                      style: new TextStyle(color: Colors.black),
                    );
                    _controller.clear();
                  });
                }
              });
            },
          ),
        ),
      ]),
      body: searchresult.length != 0 || _controller.text.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0),
                itemCount: searchresult.length,
                itemBuilder: (context, i) {
                  return InkWell(
                      onTap: () {
                        //_showInterstitialAd();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreenImagePage(
                                    searchresult[i]['url'],
                                    searchresult[i]['memename'])));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: searchresult[i]['url'],
                          placeholder: (context, url) =>
                              Image.asset('images/memes.jpeg'),
                        ),
                      ));
                },
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.0,
                    mainAxisSpacing: 6.0),
                itemCount: test.length,
                itemBuilder: (context, i) {
                  return InkWell(
                      onTap: () {
                        //_showInterstitialAd();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullScreenImagePage(
                                    test[i]['url'], test[i]['memename'])));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: test[i]['url'],
                          placeholder: (context, url) =>
                              Image.asset('images/memes.jpeg'),
                        ),
                      ));
                },
              ),
            ),
    );
  }
}
