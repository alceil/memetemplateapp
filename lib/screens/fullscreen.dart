import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class FullScreenImagePage extends StatelessWidget {
  String imgPath;
  String filename;
  FullScreenImagePage(this.imgPath, this.filename);
  // String name= "$filename";

  final LinearGradient backgroundGradient = new LinearGradient(
      colors: [new Color(0x10000000), new Color(0x30000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
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
              height: 100,
            ),
            new Hero(
              tag: imgPath,
              child: new Image.network(imgPath),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                final status = await Permission.storage.request();

                if (status.isGranted) {
                  final externalDir = await getExternalStorageDirectory();

                  final id = await FlutterDownloader.enqueue(
                    url: imgPath,
                    savedDir: externalDir.path,
                    fileName: filename,
                    showNotification: true,
                    openFileFromNotification: true,
                  );
                } else {
                  print("Permission deined");
                }
              },
              child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(width: 5.0, color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue),
                child: Center(
                    child: Text(
                  'Download',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
