import 'dart:convert';

import 'package:coba_mod6/Api/api.dart';
import 'package:coba_mod6/screen/login_regis/login-page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool securtyPass = true;
  String errorUser, errorPass;
  var _email = TextEditingController();
  var _nama = TextEditingController();
  var _pass = TextEditingController();
  var _passconfirm = TextEditingController();

  var _isLoading = false;

  void _registration() async {
    setState(() {
      _isLoading = true;
    });

    var regis = await Api().postRegis(
        apiUrl: 'auth/register',
        email: _email.text,
        name: _nama.text,
        pass: _pass.text,
        passconfirm: _passconfirm.text);
    var body = json.decode(regis.body);
    if (body['success']) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      setState(() {
        _isLoading = false;
      });
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('register belum berhasil'),
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
        errorText: errorUser,
        labelText: "Email",
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final nama = TextField(
      controller: _nama,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        errorText: errorUser,
        labelText: "User Name",
        hintText: 'User Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final password = TextField(
      controller: _pass,
      obscureText: securtyPass,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          errorText: errorPass,
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
    final passwordconfirm = TextField(
      controller: _passconfirm,
      obscureText: securtyPass,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
          errorText: errorPass,
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
    final login = FlatButton(
      child: Text(
        'Login',
        style: TextStyle(color: Colors.grey),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
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
            nama,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 8.0),
            passwordconfirm,
            SizedBox(height: 24.0),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.greenAccent[400],
                  child: Text(_isLoading ? 'Register...' : 'Register'),
                  onPressed: _isLoading ? null : _registration),
            ),
            login
          ],
        ),
      ),
    );
  }
}
