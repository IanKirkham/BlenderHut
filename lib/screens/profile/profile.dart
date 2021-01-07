import 'dart:convert';

import 'package:blenderapp/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This is our profile page', style: TextStyle(fontSize: 20)),
        MaterialButton(
          onPressed: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove('email');
            Navigator.of(context, rootNavigator: true).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          color: Colors.red,
          height: 30,
          child: Text("Logout"),
        ),
      ],
    );
  }
}
