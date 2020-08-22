import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// , String imgurl,
Widget CategoryTile({String cname, String imgurl, BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image(image: NetworkImage(imgurl)),
        ),
      ],
    ),
  );
}
