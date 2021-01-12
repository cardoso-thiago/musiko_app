import 'package:flutter/material.dart';
import 'package:musiko_app/api/last.dart';
import 'package:musiko_app/model/top_albums_model.dart' as tam;
import 'package:musiko_app/model/user_model.dart' as um;
import 'package:musiko_app/widget/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musiko',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Musiko'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentSelectedValue;
  var periods = ["overall", "12month", "6month", "3month", "1month", "7day"];

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<Null> checkLogin() async {
    String _apiKey = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _apiKey = prefs.getString("api_key");
    if (_apiKey == "" || _apiKey == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => new Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: futureBuild(),
    );
  }

  futureBuild() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: FutureBuilder(
              future: getUserInfo(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.red, Colors.redAccent])),
                          child: Container(
                            width: double.infinity,
                            height: 350.0,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      snapshot.data.user.image[3].text,
                                    ),
                                    radius: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    snapshot.data.user.name,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Card(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.white,
                                    elevation: 5.0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Scrobbles",
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontSize: 22.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  snapshot.data.user.playcount,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.redAccent,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: FutureBuilder<tam.TopAlbumsModel>(
              future: getTopAlbums(currentSelectedValue),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      DropdownButton<String>(
                        hint: Text("Select"),
                        value: currentSelectedValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.black,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            currentSelectedValue = newValue;
                          });
                        },
                        items: periods.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 9,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(snapshot.data.topalbums.album[index].image.last.text);
                          }),
                    ]),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<um.UserModel> getUserInfo() async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.get("user");
    return LastFmApi.getUserInfo(user);
  }

  Future<tam.TopAlbumsModel> getTopAlbums(String currentSelectedValue) async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.get("user");
    return LastFmApi.getTopAlbums(user, currentSelectedValue);
  }
}
