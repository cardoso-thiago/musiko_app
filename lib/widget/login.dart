import 'package:flutter/material.dart';
import 'package:musiko_app/api/last.dart';
import 'package:musiko_app/widget/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Musiko Login',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(title: 'Musiko Login'),
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
  TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 16.0);
  final controllerUser = TextEditingController();
  final controllerPassword = TextEditingController();

  Future<Null> saveLogin(String key, user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("api_key", key);
    prefs.setString("user", user);
  }

  @override
  Widget build(BuildContext context) {
    final userField = TextField(
      obscureText: false,
      style: style,
      controller: controllerUser,
      autofillHints: [AutofillHints.username],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: controllerPassword,
      autofillHints: [AutofillHints.password],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        color: Colors.red,
        onPressed: () {
          //TODO tratar erro de login
          var loginModel = LastFmApi.login(controllerUser.text, controllerPassword.text);
          loginModel.then((loginModel) {
            saveLogin(loginModel.session.key, loginModel.session.name);
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
          });
        },
        child: Text("Login", textAlign: TextAlign.center, style: style.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    @override
    void dispose() {
      controllerUser.dispose();
      controllerPassword.dispose();
      super.dispose();
    }

    return AutofillGroup(
      child: Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 155.0,
                    child: Image.asset(
                      "assets/images/last-fm.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 45.0),
                  userField,
                  SizedBox(height: 25.0),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButton,
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
