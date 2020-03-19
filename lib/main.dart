import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


var body;

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
      home: UserLogin(),
    );
  }
}

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() {
    return _UserLoginState();
  }
}

class _UserLoginState extends State<UserLogin> {

  TextEditingController emailEditingContrller = TextEditingController();
  TextEditingController passEditingContrller = TextEditingController();

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
                    height: 200,
                  ),
                ),
                TextField(
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
                          borderSide:
                          BorderSide(width: 1, style: BorderStyle.solid))),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
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
                          borderSide:
                          BorderSide(width: 1, style: BorderStyle.solid))),
                ),
                SizedBox(
                  height: 50,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  child: MaterialButton(
                    onPressed: () =>
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SecondScreen(
                                    emailEditingContrller.text,
                                    passEditingContrller.text)),
                      )
                    },
                    textColor: Colors.white,
                    color: Colors.blue,
                    height: 50,
                    child: Text("LOGIN"),
                  ),
                )
              ],
            ),
          ),
        ),
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

class SecondScreen extends StatelessWidget {
  String user, pass;

  SecondScreen(String user, String pass) {
    this.user = user;
    this.pass = pass;
  }

  Future<void> alertDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Not in stock'),
          content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Grades'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(getInfo(this.user, this.pass).toString()),
            SizedBox(height: 100),
            RaisedButton(
              child: Text('Go Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
