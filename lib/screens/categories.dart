import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:memetemplate/models/Category.dart';
import 'package:memetemplate/screens/catogoriesview.dart';
import 'package:memetemplate/screens/widgets/widgets.dart';
import 'package:memetemplate/services/networkhandler.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final networkHandler = Networkhandling();
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;
  String _searchText = "";
  List searchresult = new List();

  List imgurls = [];
  List<Category> catlist = [];

  _CategoriesState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  // String getintadid() {
  //   return 'ca-app-pub-8197704697256296/3861583802';
  // }

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

  void getData() async {
    var res = await networkHandler.get("/memes/addMeme");

    setState(() {
      imgurls = res;
      catlist = imgurls.map((e) => Category.fromJson(e)).toList();
    });
  }

  // void showInterstitialAd() {
  //   myInterstitial..show();
  // }

  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance.initialize(appId: appid());
    // myInterstitial = buildInterstitialAd()..load();
    _isSearching = false;
    getData();
  }

  // @override
  // void dispose() {
  //   myInterstitial.dispose();

  //   super.dispose();
  // }
  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < catlist.length; i++) {
        String data = catlist[i].cname.toString();
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(catlist[i]);
          print(searchresult[0].catname);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
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
                    ? new ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchresult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: catlist[index].imgurl,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                    )),
                              ],
                            ),
                          );
                        },
                      )
                    : new ListView.builder(
                        shrinkWrap: true,
                        itemCount: catlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      imageUrl: catlist[index].imgurl,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                    )),
                              ],
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
//                       // showInterstitialAd();
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
