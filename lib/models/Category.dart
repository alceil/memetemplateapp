class Category {
  String cname;
  String imgurl;
  Category({this.cname, this.imgurl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      cname: json['catname'],
      imgurl: json['imgUrl'],
    );
  }
}
