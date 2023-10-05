import 'package:hive/hive.dart';

class BlogList {
  List<Blogs>? _blogs;

  BlogList({List<Blogs>? blogs}) {
    if (blogs != null) {
      this._blogs = blogs;
    }
  }

  List<Blogs>? get blogs => _blogs;
  set blogs(List<Blogs>? blogs) => _blogs = blogs;

  BlogList.fromJson(Map<String, dynamic> json) {
    if (json['blogs'] != null) {
      _blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        _blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._blogs != null) {
      data['blogs'] = this._blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs extends HiveObject {
  @HiveField(0)
  String? _id;
  @HiveField(1)
  String? _imageUrl;
  @HiveField(2)
  String? _title;

  Blogs({String? id, String? imageUrl, String? title}) {
    if (id != null) {
      this._id = id;
    }
    if (imageUrl != null) {
      this._imageUrl = imageUrl;
    }
    if (title != null) {
      this._title = title;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get imageUrl => _imageUrl;
  set imageUrl(String? imageUrl) => _imageUrl = imageUrl;
  String? get title => _title;
  set title(String? title) => _title = title;

  Blogs.fromJson(Map<dynamic, dynamic> json) {
    _id = json['id'];
    _imageUrl = json['image_url'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['image_url'] = this._imageUrl;
    data['title'] = this._title;
    return data;
  }
}

class BlogsAdapter extends TypeAdapter<Blogs> {
  @override
  Blogs read(BinaryReader reader) {
    return Blogs.fromJson(reader.read());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, Blogs obj) {
    writer.write(obj.toJson());
  }
}
