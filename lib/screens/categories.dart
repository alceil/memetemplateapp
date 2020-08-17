import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:memetemplate/screens/catogoriesview.dart';
import 'package:memetemplate/screens/widgets/widgets.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final CollectionReference ref = Firestore.instance.collection('categories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, i) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CatogoryView(
                                      loc: snapshot
                                          .data.documents[i].data['catname'],
                                    )));
                      },
                      child: CategoryTile(
                          context: context,
                          imgurl:
                              snapshot.data.documents[i].data['url'].toString(),
                          cname: snapshot.data.documents[i].data['catname']),
                    ));
          }),
    );
  }
}
