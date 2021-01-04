import 'package:blenderapp/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app.dart';

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
    _checkForAuthentication().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToLogin();
      }
    });
  }

  Future<bool> _checkForAuthentication() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});
    return false; // In the future, this will check shared preferences to see if a user is logged in or not.
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
            SpinKitFoldingCube(
              color: Colors.white,
              size: MediaQuery.of(context).size.width / 4,
            ),
          ],
        ),
      ),
    );
  }
}
