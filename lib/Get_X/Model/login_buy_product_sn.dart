






class SNProducttwo {
  String? id;
  String? sn;
  String? title;

  SNProducttwo({
    this.id,
    this.sn,
    this.title,
  });
  factory SNProducttwo.fromJson(Map<String, dynamic> json) {
    return SNProducttwo(
      id: json['id'],
      sn: json['sn'],
      title: json['title'],
    );
  }
}


