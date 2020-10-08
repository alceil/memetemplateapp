import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:memetemplate/models/Category.dart';
import 'package:memetemplate/screens/catogoriesview.dart';
import 'package:memetemplate/services/networkhandler.dart';

class Categories1 extends StatefulWidget {
  @override
  _Categories1State createState() => _Categories1State();
}

class _Categories1State extends State<Categories1> {
  final networkHandler = Networkhandling();
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool loader = true;

  List<Category> searchresult = [];

  List imgurls = [];
  List<Category> catlist = [];

  String getintadid() {
    return 'ca-app-pub-8197704697256296/3861583802';
  }

  String appid() {
    return 'ca-app-pub-8197704697256296~8003992887';
  }

  String bannerid() {
    return 'ca-app-pub-3263954522700294/4117286019';
  }

  BannerAd myBanner;

  BannerAd buildBannerAd() {
    return BannerAd(
        adUnitId: bannerid(),
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

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: appid());
    myBanner = buildBannerAd()..load();
    myInterstitial = buildInterstitialAd()..load();
    getData();
  }

  @override
  void dispose() {
    myBanner.dispose();
    myInterstitial.dispose();
    super.dispose();
  }

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
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            key: globalKey,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Templates'),
            ),
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
                    child: searchresult.length != 0 ||
                            _controller.text.isNotEmpty
                        ? new ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchresult.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  showInterstitialAd();
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
                                  showInterstitialAd();
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
