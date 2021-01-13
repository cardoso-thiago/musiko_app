import 'package:flutter/material.dart';
import 'package:musiko_app/api/last.dart';
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
  var currentSelectedPeriodValue = "overall";
  var periods = ["overall", "12month", "6month", "3month", "1month", "7day"];
  var currentSelectedTypeValue = "albums";
  var types = ["albums", "artists"];
  var currentSelectedGridSizeValue = 9;
  var gridSizes = [9, 12, 15, 18];

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
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: FutureBuilder<List<String>>(
              future: getTopList(currentSelectedTypeValue, currentSelectedPeriodValue),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton<String>(
                            hint: Text("albums"),
                            value: currentSelectedTypeValue,
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
                                currentSelectedTypeValue = newValue;
                              });
                            },
                            items: types.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          DropdownButton<String>(
                            hint: Text("overall"),
                            value: currentSelectedPeriodValue,
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
                                currentSelectedPeriodValue = newValue;
                              });
                            },
                            items: periods.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          DropdownButton<int>(
                            hint: Text("9"),
                            value: currentSelectedGridSizeValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconEnabledColor: Colors.black,
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (int newValue) {
                              setState(() {
                                currentSelectedGridSizeValue = newValue;
                              });
                            },
                            items: gridSizes.map<DropdownMenuItem<int>>((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(value.toString()),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: currentSelectedGridSizeValue,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(snapshot.data[index]);
                          }),
                    ]),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
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

  Future<List<String>> getTopList(String type, String period) async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.get("user");
    if (type == "albums") {
      var albums = await LastFmApi.getTopAlbums(user, period);
      return albums.topalbums.album.map((item) => item.image.last.text).toList();
    }
    var artists = await LastFmApi.getTopArtists(user, period);
    return artists.topartists.artist
        .map((item) => "https://tse2.mm.bing.net/th?q=${item.name} Band&w=500&h=500&c=7&rs=1&p=0&dpr=3&pid=1.7&mkt=en-IN&adlt=on")
        .toList();
  }
}
