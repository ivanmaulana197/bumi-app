import 'package:coba_mod6/screen/home/home-page.dart';
import 'package:coba_mod6/screen/login_regis/login-page.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loader extends StatefulWidget {
  Loader({Key key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  SharedPreferences sharedPreferences;
  bool login;

  @override
  void initState() {
    validationLoggined();
    super.initState();
  }

  void validationLoggined() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      login = (sharedPreferences.getBool('login'));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => (login == true ? HomePage() : LoginPage()),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset("assets/lottie/rocket.json"),
            ),
            Padding(padding: EdgeInsets.only(top: 200)),
            SizedBox(
              height: 75,
              width: 75,
              child: Lottie.asset("assets/lottie/loading.json"),
            )
          ],
        ),
      ),
    );
  }
}
