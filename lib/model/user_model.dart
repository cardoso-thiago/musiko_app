class UserModel {
  User _user;

  User get user => _user;

  UserModel({User user}) {
    _user = user;
  }

  UserModel.fromJson(dynamic json) {
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }
}

class User {
  String _playlists;
  String _playcount;
  String _gender;
  String _name;
  String _subscriber;
  String _url;
  String _country;
  List<Image> _image;
  Registered _registered;
  String _type;
  String _age;
  String _bootstrap;
  String _realname;

  String get playlists => _playlists;

  String get playcount => _playcount;

  String get gender => _gender;

  String get name => _name;

  String get subscriber => _subscriber;

  String get url => _url;

  String get country => _country;

  List<Image> get image => _image;

  Registered get registered => _registered;

  String get type => _type;

  String get age => _age;

  String get bootstrap => _bootstrap;

  String get realname => _realname;

  User(
      {String playlists,
      String playcount,
      String gender,
      String name,
      String subscriber,
      String url,
      String country,
      List<Image> image,
      Registered registered,
      String type,
      String age,
      String bootstrap,
      String realname}) {
    _playlists = playlists;
    _playcount = playcount;
    _gender = gender;
    _name = name;
    _subscriber = subscriber;
    _url = url;
    _country = country;
    _image = image;
    _registered = registered;
    _type = type;
    _age = age;
    _bootstrap = bootstrap;
    _realname = realname;
  }

  User.fromJson(dynamic json) {
    _playlists = json["playlists"];
    _playcount = json["playcount"];
    _gender = json["gender"];
    _name = json["name"];
    _subscriber = json["subscriber"];
    _url = json["url"];
    _country = json["country"];
    if (json["image"] != null) {
      _image = [];
      json["image"].forEach((v) {
        _image.add(Image.fromJson(v));
      });
    }
    _registered = json["registered"] != null ? Registered.fromJson(json["registered"]) : null;
    _type = json["type"];
    _age = json["age"];
    _bootstrap = json["bootstrap"];
    _realname = json["realname"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["playlists"] = _playlists;
    map["playcount"] = _playcount;
    map["gender"] = _gender;
    map["name"] = _name;
    map["subscriber"] = _subscriber;
    map["url"] = _url;
    map["country"] = _country;
    if (_image != null) {
      map["image"] = _image.map((v) => v.toJson()).toList();
    }
    if (_registered != null) {
      map["registered"] = _registered.toJson();
    }
    map["type"] = _type;
    map["age"] = _age;
    map["bootstrap"] = _bootstrap;
    map["realname"] = _realname;
    return map;
  }
}

class Registered {
  String _unixtime;
  int _text;

  String get unixtime => _unixtime;

  int get text => _text;

  Registered({String unixtime, int text}) {
    _unixtime = unixtime;
    _text = text;
  }

  Registered.fromJson(dynamic json) {
    _unixtime = json["unixtime"];
    _text = json["#text"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["unixtime"] = _unixtime;
    map["#text"] = _text;
    return map;
  }
}

class Image {
  String _size;
  String _text;

  String get size => _size;

  String get text => _text;

  Image({String size, String text}) {
    _size = size;
    _text = text;
  }

  Image.fromJson(dynamic json) {
    _size = json["size"];
    _text = json["#text"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["size"] = _size;
    map["#text"] = _text;
    return map;
  }
}
