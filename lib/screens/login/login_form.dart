import 'dart:convert';

import 'package:blenderapp/api_calls.dart';
import 'package:blenderapp/screens/login/customButtonWidget.dart';
import 'package:blenderapp/screens/login/customTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../app.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userEmailTextController = TextEditingController();
  final userPasswordTextController = TextEditingController();
  bool isLoading;

  @override
  void initState() {
    super.initState();
    userEmailTextController.text = "ian@gmail.com";
    userPasswordTextController.text = "123";
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Opacity(
              opacity: isLoading ? 1.0 : 0.0,
              child: CircularProgressIndicator()),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            labelText: 'Email',
            obscureText: false,
            prefixIconData: Icons.mail_outline,
            validator: (value) {
              if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value)) {
                return 'Please enter a vaild email';
              }
              return null;
            },
            controller: userEmailTextController,
          ),
          SizedBox(
            height: 10,
          ),
          CustomTextFormField(
            labelText: 'Password',
            obscureText: true,
            prefixIconData: Icons.lock_outline,
            validator: (value) {
              if (value.isEmpty) {
                return "Enter a valid password";
              }
              return null;
            },
            controller: userPasswordTextController,
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Forgot password?",
              style: TextStyle(
                color: Colors.lightBlueAccent,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomButtonWidget(
            title: 'Login',
            hasBorder: false,
            formKey: _formKey,
            onPressed: () async {
              setState(() => isLoading = true);
              http.Response response = await loginUser(
                  userEmailTextController.text,
                  userPasswordTextController.text);

              Map<String, dynamic> json = jsonDecode(response.body);

              if (response.statusCode == 200) {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString('user', json["_id"]);
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (BuildContext context) => App(),
                  ),
                );
              } else {
                final snackbar = SnackBar(
                  content: Text("${json["message"]}"),
                  backgroundColor: Colors.red[400],
                );
                Scaffold.of(context).showSnackBar(snackbar);
              }
              setState(() => isLoading = false);
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustomButtonWidget(
            title: 'Sign Up',
            hasBorder: true,
            formKey: _formKey,
            onPressed: () async {
              setState(() => isLoading = true);
              http.Response response = await registerUser(
                  userEmailTextController.text,
                  userPasswordTextController.text);

              Map<String, dynamic> json = jsonDecode(response.body);

              if (response.statusCode == 200) {
                final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                sharedPreferences.setString('user', json["_id"]);
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (BuildContext context) => App(),
                  ),
                );
              } else {
                final snackbar = SnackBar(
                  content: Text("${json["message"]}"),
                  backgroundColor: Colors.red[400],
                );
                Scaffold.of(context).showSnackBar(snackbar);
              }
              setState(() => isLoading = false);
            },
          ),
        ],
      ),
    );
  }
}
