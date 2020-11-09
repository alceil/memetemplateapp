import 'dart:ffi';
import 'dart:io';
// //import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class FullScreenImagePage extends StatefulWidget {
  String imgPath;
  String filename;

  FullScreenImagePage(this.imgPath, this.filename);

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  final LinearGradient backgroundGradient = new LinearGradient(
      colors: [new Color(0x10000000), new Color(0x30000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  bool downloading = false;
  String loc;
  var progressString = "";
  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
    // FacebookAudienceNetwork.init();
    //// _loadInterstitialAd();
    // showBannerAd();
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
  // void initState() {
  //   super.initState();
  //   if (!mounted) return null;
  //   permit();
  // }

  void permit() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      createFolder();
    } else {
      print("Permission deined");
    }
  }

  Future<void> createFolder() async {
    Directory baseDir = await getExternalStorageDirectory(); //only for Android
    // Directory baseDir = await getApplicationDocumentsDirectory(); //works for both iOS and Android
    String dirToBeCreated = "DCIM/cgsteam";

    String finalDir = baseDir.path
            .replaceAll("Android/data/com.cgsteam.memetemplate/files", '') +
        dirToBeCreated;
    print(finalDir);
    var dir = Directory(finalDir);
    bool dirExists = await dir.exists();
    if (!dirExists) {
      dir.create(
          recursive: true); //pass recursive as true if directory is recursive
    }
    //Now you can use this directory for saving file, etc.
    //In case you are using external storage, make sure you have storage permissio
  }

  // Future<File> saveFile(String url, title) async {
  //   var file = await DefaultCacheManager()
  //       .getSingleFile(url); // File _file = File(file.path);
  //   File _file = File(file.path);
  //   var basenam = basename(_file.path);
  //   var ext = basenam.split(".")[1];
  //   final filePath =
  //       '${(await getExternalStorageDirectory()).path.replaceAll("Android/data/com.cgsteam.memetemplate/files", '')}cgsteam/$title[refoxwall.com].$ext';
  //   print(filePath);
  //   return File(filePath)
  //     ..createSync(recursive: true)
  //     ..writeAsBytes(file.readAsBytesSync());
  // }

  Future<File> saveFile(String url, title) async {
    var file = await DefaultCacheManager()
        .getSingleFile(url); // File _file = File(file.path);
    File _file = File(file.path);
    var basenam = basename(_file.path);
    // var ext = basenam.split(".")[1];
    loc =
        '${(await getExternalStorageDirectory()).path.replaceAll("Android/data/com.cgsteam.memetemplate/files", '')}cgsteam/$title.jpg';
    print(loc);
    return File(loc)
      ..createSync(recursive: true)
      ..writeAsBytes(file.readAsBytesSync());
  }

  Future<void> downloadFile(String imgUrl, String filename) async {
    Dio dio = Dio();
    try {
      // var dir = await getExternalStorageDirectory();
      loc =
          "${(await getExternalStorageDirectory()).path.replaceAll("Android/data/com.cgsteam.memetemplate/files", '')}Download/$filename.jpg";
      await dio.download(imgUrl, loc, onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");

        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });

      print(loc);
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });

    Fluttertoast.showToast(
        msg: "Check your Download,folder",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  Future<void> imagedownload(BuildContext context,String url) async
  {
      var imageid = await ImageDownloader.downloadImage(
                              url);
Scaffold.of(context).showSnackBar(
  SnackBar(
    content: Text('Download completed'),
    action: SnackBarAction(label: 'Open', onPressed: () async
    {
  var path = await ImageDownloader.findPath(imageid);
  ImageDownloader.open(path);
    }
     )
    ,
)
);
  }


  Future<Null> saveAndShare(String imgpath,String imgfilename) async {
    // setState(() {
    //   isBtn2 = true;
    // });
    // final RenderBox box = context.findRenderObject();
    if (Platform.isAndroid) {
      var url = 'https://www.winklix.com/blog/wp-content/uploads/2020/01/6t1pv3xcd.png';
      var response = await get(imgpath);
      final documentDirectory = (await getExternalStorageDirectory()).path;
      File imgFile = new File('$documentDirectory/$imgfilename.png');
      imgFile.writeAsBytesSync(response.bodyBytes);

      Share.shareFiles(['$documentDirectory/$imgfilename.png'],
          subject: 'URL conversion + Share',
          text: 'Download our app https://play.google.com/store/apps/details?id=com.cgsteam.memetemplate',
          // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
          );
    } else {
      Share.share('Hey! Checkout the Share Files repo',
          subject: 'URL conversion + Share',
          // sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
          );
    }
    // setState(() {
    //   isBtn2 = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: Builder(
        builder: (BuildContext context)
        {
          return downloading? Center(
                child: Container(
                  height: height,
                  width: width,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Downloading File: $progressString",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                decoration: new BoxDecoration(gradient: backgroundGradient),
                child: new Column(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new AppBar(
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                          leading: new IconButton(
                            icon: new Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    new Image.network(
                      widget.imgPath,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: height / 2,
                          width: width,
                          color: Colors.black,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () async {
                            final status = await Permission.storage.request();

                            if (status.isGranted) {
                              // await createFolder();
                              // downloadFile(widget.imgPath, widget.filename);
                              // var imageid = await ImageDownloader.downloadImage(
                              //   widget.imgPath

                              // );
                              // imagedownload(context, widget.imgPath);
                           var imageid = await ImageDownloader.downloadImage(
                                widget.imgPath);
                                

Scaffold.of(context).showSnackBar(
  SnackBar(
    content: Text('Download completed'),
    action: SnackBarAction(label: 'Open', onPressed: () async
    {
  var path = await ImageDownloader.findPath(imageid);
  ImageDownloader.open(path);
    }
     )
    ,
)
);

                              //
                              // saveFile(widget.imgPath, widget.filename);

                              // Fluttertoast.showToast(
                              //     msg: "Downloaded to $loc",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     backgroundColor: Colors.green,
                              //     textColor: Colors.white);
                              // print("Download completed");
                              // String filename = widget.filename + ".jpg";
                              // String loc =
                              //     "${(await getExternalStorageDirectory()).path.replaceAll("Android/data/com.cgsteam.memetemplate/files", '')}DCIM";
                              // final id = await FlutterDownloader.enqueue(
                              //   url: widget.imgPath,
                              //   savedDir: loc,
                              //   fileName: filename,
                              //   showNotification: true,
                              //   openFileFromNotification: true,
                              // );
                            } else {
                              print("Permission deined");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue),
                            child: Center(
                                child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  'Download',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                )
                              ],
                            )),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final status = await Permission.storage.request();

                            if (status.isGranted) {
                              // await createFolder();
                              // downloadFile(widget.imgPath, widget.filename);
                              saveAndShare(widget.imgPath,widget.filename);

                              //
                              // saveFile(widget.imgPath, widget.filename);

                              // Fluttertoast.showToast(
                              //     msg: "Downloaded to $loc",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     backgroundColor: Colors.green,
                              //     textColor: Colors.white);
                              // print("Download completed");
                              // String filename = widget.filename + ".jpg";
                              // String loc =
                              //     "${(await getExternalStorageDirectory()).path.replaceAll("Android/data/com.cgsteam.memetemplate/files", '')}DCIM";
                              // final id = await FlutterDownloader.enqueue(
                              //   url: widget.imgPath,
                              //   savedDir: loc,
                              //   fileName: filename,
                              //   showNotification: true,
                              //   openFileFromNotification: true,
                              // );
                            } else {
                              print("Permission deined");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue),
                            child: Center(
                                child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  'Share',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.share,
                                  color: Colors.white,
                                )
                              ],
                            )),
                          ),
                        ),

                      ],
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment(0, 1.0),
                        child: _currentAd,
                      ),
                      fit: FlexFit.tight,
                      flex: 3,
                    )
                  ],
                ),
              );

        },
             
      ),
    );
  }
}
