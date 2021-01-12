class TopAlbumsModel {
  Topalbums topalbums;

  TopAlbumsModel({this.topalbums});

  factory TopAlbumsModel.fromJson(Map<String, dynamic> json) {
    return TopAlbumsModel(
      topalbums: json['topalbums'] != null ? Topalbums.fromJson(json['topalbums']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topalbums != null) {
      data['topalbums'] = this.topalbums.toJson();
    }
    return data;
  }
}

class Topalbums {
  AttrX attr;
  List<Album> album;

  Topalbums({this.attr, this.album});

  factory Topalbums.fromJson(Map<String, dynamic> json) {
    return Topalbums(
      attr: json['@attr'] != null ? AttrX.fromJson(json['@attr']) : null,
      album: json['album'] != null ? (json['album'] as List).map((i) => Album.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attr != null) {
      data['@attr'] = this.attr.toJson();
    }
    if (this.album != null) {
      data['album'] = this.album.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Album {
  Attr attr;
  Artist artist;
  List<Image> image;
  String mbid;
  String name;
  String playcount;
  String url;

  Album({this.attr, this.artist, this.image, this.mbid, this.name, this.playcount, this.url});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      attr: json['@attr'] != null ? Attr.fromJson(json['@attr']) : null,
      artist: json['artist'] != null ? Artist.fromJson(json['artist']) : null,
      image: json['image'] != null ? (json['image'] as List).map((i) => Image.fromJson(i)).toList() : null,
      mbid: json['mbid'],
      name: json['name'],
      playcount: json['playcount'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mbid'] = this.mbid;
    data['name'] = this.name;
    data['playcount'] = this.playcount;
    data['url'] = this.url;
    if (this.attr != null) {
      data['@attr'] = this.attr.toJson();
    }
    if (this.artist != null) {
      data['artist'] = this.artist.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artist {
  String mbid;
  String name;
  String url;

  Artist({this.mbid, this.name, this.url});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      mbid: json['mbid'],
      name: json['name'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mbid'] = this.mbid;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class Image {
  String text;
  String size;

  Image({this.text, this.size});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      text: json['#text'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['#text'] = this.text;
    data['size'] = this.size;
    return data;
  }
}

class Attr {
  String rank;

  Attr({this.rank});

  factory Attr.fromJson(Map<String, dynamic> json) {
    return Attr(
      rank: json['rank'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rank'] = this.rank;
    return data;
  }
}

class AttrX {
  String page;
  String perPage;
  String total;
  String totalPages;
  String user;

  AttrX({this.page, this.perPage, this.total, this.totalPages, this.user});

  factory AttrX.fromJson(Map<String, dynamic> json) {
    return AttrX(
      page: json['page'],
      perPage: json['perPage'],
      total: json['total'],
      totalPages: json['totalPages'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['total'] = this.total;
    data['totalPages'] = this.totalPages;
    data['user'] = this.user;
    return data;
  }
}
