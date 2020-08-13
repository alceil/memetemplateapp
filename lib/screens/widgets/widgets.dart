import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// , String imgurl,
Widget CategoryTile({String cname, BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            color: Colors.red,
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Text(
            cname,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        )
      ],
    ),
  );
}
