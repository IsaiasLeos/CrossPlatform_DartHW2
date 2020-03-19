import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserLogin(title: 'Login Page'),
    );
  }
}

class UserLogin extends StatelessWidget {
  final String title;

  UserLogin({Key key, this.title}) : super(key: key);

  static TextEditingController emailEditingContrller = TextEditingController();
  static TextEditingController passEditingContrller = TextEditingController();

  var emailField = TextField(
    autofocus: false,
    obscureText: false,
    keyboardType: TextInputType.emailAddress,
    controller: emailEditingContrller,
    decoration: InputDecoration(
        labelText: "Username",
        hintText: "Username",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid))),
  );

  var passwordField = TextField(
    autofocus: false,
    obscureText: true,
    keyboardType: TextInputType.text,
    controller: passEditingContrller,
    decoration: InputDecoration(
        labelText: "Password",
        hintText: "Password",
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, style: BorderStyle.solid))),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 125,
                  ),
                ),
                emailField,
                SizedBox(
                  height: 30,
                ),
                passwordField,
                SizedBox(
                  height: 50,
                ),
                Material(
                  child: MaterialButton(
                    onPressed: () {
                      _navigateHome(context);
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    height: 50,
                    child: Text("LOGIN"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateHome(BuildContext context) async {
    final body =
        await getInfo(emailEditingContrller.text, passEditingContrller.text);
    User user =
        new User(emailEditingContrller.text, passEditingContrller.text, body);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                  user: user,
                )));
  }
}

class User {
  final String userName;
  final String password;
  final String body;

  User(this.userName, this.password, this.body);
}

class HomePage extends StatelessWidget {
  final User user;

  HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Text('${user.body}'),
      ),
    );
  }
}

dynamic getInfo(String name, String password) async {
  var url = 'http://www.cs.utep.edu/cheon/cs4381/grade/get.php?user=' +
      name +
      '&pin=' +
      password;
  var response = await http.get(url);
  return response.body;
}
