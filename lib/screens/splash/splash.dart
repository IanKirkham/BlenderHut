import 'dart:async';

import 'package:blenderapp/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app.dart';

String finalEmail;

class SplashScreen extends StatefulWidget {
  //final GlobalKey navBarGlobalKey;
  //SplashScreen(this.navBarGlobalKey);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkForAuthentication().whenComplete(() async {
      Timer(Duration(seconds: 1),
          () => finalEmail == null ? _navigateToLogin() : _navigateToHome());
    });
  }

  Future _checkForAuthentication() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (BuildContext context) => App(), //App(widget.navBarGlobalKey),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(
        builder: (BuildContext context) =>
            Login(), //Login(widget.navBarGlobalKey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "BlenderHut",
              style: GoogleFonts.anton(
                fontSize: 75,
              ),
              //textAlign: TextAlign.center,
            ),
            SpinKitDualRing(
              color: Colors.white,
              size: MediaQuery.of(context).size.width / 4,
            ),
          ],
        ),
      ),
    );
  }
}
