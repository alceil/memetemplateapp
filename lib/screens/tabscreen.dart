// //import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:memetemplate/screens/Memes.dart';
import 'package:memetemplate/screens/categories.dart';
import 'package:memetemplate/screens/categories1.dart';
import 'package:memetemplate/screens/wallpaper.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  launchurl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'could not launch url';
    }
  }

  String getintadid() {
    return 'ca-app-pub-8197704697256296/3861583802';
  }

  String appid() {
    return 'ca-app-pub-8197704697256296~8003992887';
  }

  bool _isInterstitialAdLoaded = false;

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
  // void initState() {
  //   super.initState();

  //   // FirebaseAdMob.instance.initialize(appId: appid());
  //   // // myBanner = buildBannerAd()..load();
  //   // myInterstitial = buildInterstitialAd()..load();
  // }

  @override
  void initState() {
    super.initState();
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

  // @override
  // void dispose() {
  //   // myBanner.dispose();
  //   // myInterstitial.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: SafeArea(
          child: Scaffold(
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image(
                              image: AssetImage('images/ic_launcher1.png')),
                        ),
                      )),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Templates'),
                    onTap: () {
                      //_showInterstitialAd();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WallScreen1()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.image_aspect_ratio),
                    title: Text('Categories'),
                    onTap: () {
                      //_showInterstitialAd();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categories1()));
                    },
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('More Options'),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Rate this App'),
                    onTap: () {
                      launchurl(
                          'https://play.google.com/store/apps/details?id=com.cgsteam.memetemplate');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share this App'),
                    onTap: () {
                      Share.share(
                          'https://play.google.com/store/apps/details?id=com.cgsteam.memetemplate');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: Text('Template Request'),
                    onTap: () {
                      launchurl(
                          'https://api.whatsapp.com/send?phone=916361569493');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.system_update),
                    title: Text('Template Submission'),
                    onTap: () {
                      launchurl(
                          'https://docs.google.com/forms/d/e/1FAIpQLSd7bTzJV-NOJwGKSowpmkX5KUoJ0bYJheDazyyZsAEvbdPlNQ/viewform?usp=sf_link');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.text_fields),
                    title: Text('Privacy Policy'),
                    onTap: () {
                      launchurl(
                          'https://sites.google.com/view/privacypolicy-kannadameme/home');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About'),
                    onTap: () {
                      showAboutDialog(
                          context: context,
                          applicationVersion: '1.1.1',
                          applicationIcon:
                              Image.asset('images/ic_launcher.png'),
                          applicationName: 'Kannada Meme Templates',
                          applicationLegalese:
                              'This App can be used by all audiences',
                          children: [
                            Text(
                                'A Meme Template App which has ready made template to be used by the Memers to make memes'),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Our Teams Instagram Handles'),
                            ListTile(
                              leading: Image(
                                image: AssetImage('images/insta.png'),
                              ),
                              title: Text('@troll_nanaganisiddu'),
                              onTap: () {
                                launchurl(
                                    'https://instagram.com/troll_nanaganisiddu?igshid=1ut1nnht6lo7l');
                              },
                            ),
                            ListTile(
                              leading:
                                  Image(image: AssetImage('images/insta.png')),
                              title: Text('@kannadagurujistudio'),
                              onTap: () => launchurl(
                                  'https://instagram.com/kannadagurujistudio?igshid=nf41pszdqxor'),
                            ),
                          ]);
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text(
                'Kannada Memes',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              elevation: 5.0,
              actions: <Widget>[],
              bottom: TabBar(tabs: <Widget>[
                Tab(
                  text: 'Templates',
                ),
                Tab(text: 'Categories'),
              ]),
            ),
            body: TabBarView(children: <Widget>[WallScreen(), Categories()]),
          ),
        ));
  }
}
