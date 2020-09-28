class Category {
  String cname;
  String imgurl;
  List catdata;
  Category({this.cname, this.imgurl, this.catdata});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        cname: json['catname'],
        imgurl: json['imgUrl'],
        catdata: json['images']);
  }
}
