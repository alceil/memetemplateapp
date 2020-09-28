class General {
  String imgurl;
  String memename;
  General({this.imgurl, this.memename});
  factory General.fromJson(Map<String, dynamic> json) {
    return General(
      imgurl: json['imgUrl'],
      memename: json['memename'],
    );
  }
}
