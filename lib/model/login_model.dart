class LoginModel {
  Session _session;

  Session get session => _session;

  LoginModel({Session session}) {
    _session = session;
  }

  LoginModel.fromJson(dynamic json) {
    _session = json["session"] != null ? Session.fromJson(json["session"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_session != null) {
      map["session"] = _session.toJson();
    }
    return map;
  }
}

class Session {
  int _subscriber;
  String _name;
  String _key;

  int get subscriber => _subscriber;

  String get name => _name;

  String get key => _key;

  Session({int subscriber, String name, String key}) {
    _subscriber = subscriber;
    _name = name;
    _key = key;
  }

  Session.fromJson(dynamic json) {
    _subscriber = json["subscriber"];
    _name = json["name"];
    _key = json["key"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["subscriber"] = _subscriber;
    map["name"] = _name;
    map["key"] = _key;
    return map;
  }
}
