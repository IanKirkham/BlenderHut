import 'package:blenderapp/api_calls.dart';
import 'package:blenderapp/screens/login/customButtonWidget.dart';
import 'package:blenderapp/screens/login/customTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../app.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final userEmailTextController = TextEditingController();
  final userPasswordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userEmailTextController.text = "ian@gmail.com";
    userPasswordTextController.text = "123";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
              http.Response response = await loginUser(
                  userEmailTextController.text,
                  userPasswordTextController.text);

              if (response.statusCode == 200) {
                // Save user in shared preferences?
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        //App(widget.navBarGlobalKey),
                        App(),
                  ),
                );
              } else {
                // somehow make a widget to show loading and error messages
                print("${response.body}");
              }
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
              http.Response response = await registerUser(
                  userEmailTextController.text,
                  userPasswordTextController.text);

              if (response.statusCode == 200) {
                // Save user in shared preferences?
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        //App(widget.navBarGlobalKey),
                        App(),
                  ),
                );
              } else {
                // somehow make a widget to show loading and error messages
                print("${response.body}");
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
