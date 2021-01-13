class TopArtistsModel {
  Topartists topartists;

  TopArtistsModel({this.topartists});

  factory TopArtistsModel.fromJson(Map<String, dynamic> json) {
    return TopArtistsModel(
      topartists: json['topartists'] != null ? Topartists.fromJson(json['topartists']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topartists != null) {
      data['topartists'] = this.topartists.toJson();
    }
    return data;
  }
}

class Topartists {
  AttrX attr;
  List<Artist> artist;

  Topartists({this.attr, this.artist});

  factory Topartists.fromJson(Map<String, dynamic> json) {
    return Topartists(
      attr: json['@attr'] != null ? AttrX.fromJson(json['@attr']) : null,
      artist: json['artist'] != null ? (json['artist'] as List).map((i) => Artist.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attr != null) {
      data['@attr'] = this.attr.toJson();
    }
    if (this.artist != null) {
      data['artist'] = this.artist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artist {
  Attr attr;
  List<Image> image;
  String mbid;
  String name;
  String playcount;
  String streamable;
  String url;

  Artist({this.attr, this.image, this.mbid, this.name, this.playcount, this.streamable, this.url});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      attr: json['@attr'] != null ? Attr.fromJson(json['@attr']) : null,
      image: json['image'] != null ? (json['image'] as List).map((i) => Image.fromJson(i)).toList() : null,
      mbid: json['mbid'],
      name: json['name'],
      playcount: json['playcount'],
      streamable: json['streamable'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mbid'] = this.mbid;
    data['name'] = this.name;
    data['playcount'] = this.playcount;
    data['streamable'] = this.streamable;
    data['url'] = this.url;
    if (this.attr != null) {
      data['@attr'] = this.attr.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
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
