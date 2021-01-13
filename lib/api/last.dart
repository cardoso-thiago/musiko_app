import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:musiko_app/model/login_model.dart';
import 'package:musiko_app/model/top_albums_model.dart';
import 'package:musiko_app/model/top_artists_model.dart';
import 'package:musiko_app/model/user_model.dart';

const secureBaseUrl = "https://ws.audioscrobbler.com/2.0/?format=json";
const baseUrl = "http://ws.audioscrobbler.com/2.0/?format=json";
const apiKey = "89aba74fcb8aa1bf3aaf692856cac999";
const apiSecret = "e3070df8348a7183fc836f80e7440332";
const mGetMobileSession = "auth.getMobileSession";
const mGetUserInfo = "user.getinfo";
const mGetTopAlbums = "user.getTopAlbums";
const mGetTopArtists = "user.getTopArtists";

class LastFmApi {
  static Future<LoginModel> login(var username, var password) async {
    Map<String, String> mapData = {
      'method': mGetMobileSession,
      'api_key': apiKey,
      'username': username,
      'password': password,
    };

    final response = await http.post(secureBaseUrl, body: _signBody(mapData));
    return LoginModel.fromJson(jsonDecode(response.body));
  }

  static Future<UserModel> getUserInfo(var username) async {
    final response = await http.get(secureBaseUrl + "&method=$mGetUserInfo&user=$username&api_key=$apiKey");
    return UserModel.fromJson(jsonDecode(response.body));
  }

  static Future<TopAlbumsModel> getTopAlbums(var username, var period) async {
    final response = await http.get(secureBaseUrl + "&method=$mGetTopAlbums&user=$username&period=$period&api_key=$apiKey&limit=18");
    return TopAlbumsModel.fromJson(jsonDecode(response.body));
  }

  static Future<TopArtistsModel> getTopArtists(var username, var period) async {
    final response = await http.get(secureBaseUrl + "&method=$mGetTopArtists&user=$username&period=$period&api_key=$apiKey&limit=18");
    return TopArtistsModel.fromJson(jsonDecode(response.body));
  }

  static Map<String, String> _signBody(Map<String, String> preBody) {
    final bodyKeys = List.of(preBody.keys)..sort();
    final signatureBuilder = StringBuffer();

    for (final key in bodyKeys) {
      signatureBuilder.write('$key${preBody[key]}');
    }

    signatureBuilder.write(apiSecret);

    final sigStr = signatureBuilder.toString();

    return {
      ...preBody,
      'api_sig': md5.convert(utf8.encode(sigStr)).toString(),
    };
  }
}
