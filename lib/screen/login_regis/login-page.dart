import 'dart:convert';

import 'package:coba_mod6/Api/api.dart';
import 'package:coba_mod6/screen/home/home-page.dart';
import 'package:coba_mod6/screen/login_regis/register-page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool securtyPass = true;
  var _email = TextEditingController();
  var _pass = TextEditingController();
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var login = await Api().postLogin(
      apiUrl: 'auth/login',
      email: _email.text,
      pass: _pass.text,
    );

    var body = json.decode(login.body);
    if (body['access_token'] != null) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var name = body['user']['name'];
      localStorage.setString('username', name);
      localStorage.setString('token', body['access_token']);
      localStorage.setBool('login', true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        _isLoading = false;
      });
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text('login gagal')),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset(
            'assets/img/logo.png',
            color: Colors.greenAccent,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          "BUMI",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
    final email = TextField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextField(
      controller: _pass,
      obscureText: securtyPass,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          suffixIcon: IconButton(
              icon: Icon(securtyPass ? Icons.remove_red_eye : Icons.security),
              onPressed: () {
                setState(() {
                  securtyPass = !securtyPass;
                });
              })),
    );
    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Password',
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {},
    );
    final register = FlatButton(
      child: Text(
        'Register',
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
    );
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.greenAccent[400],
                  child: Text(_isLoading ? 'Login...' : 'Login'),
                  onPressed: _isLoading ? null : _login),
            ),
            forgotLabel,
            register
          ],
        ),
      ),
    );
  }
}
