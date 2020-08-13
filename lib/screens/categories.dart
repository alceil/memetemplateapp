import 'package:flutter/material.dart';
import 'package:memetemplate/screens/widgets/widgets.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> tname = ['french', '99', 'comedy'];
  List<String> timg = ['img1', 'img2', 'img3'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          itemCount: tname.length,
          itemBuilder: (context, i) =>
              CategoryTile(context: context, imgurl: timg[i], cname: tname[i])),
    );
  }
}

// Column(
//           children: <Widget>[
//             CategoryTile(context: context),
//           ],
//         ),
