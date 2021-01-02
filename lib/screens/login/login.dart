import 'package:blenderapp/widgets/buttonWidget.dart';
import 'package:blenderapp/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app.dart';

class Login extends StatefulWidget {
  final GlobalKey navBarGlobalKey;
  Login(this.navBarGlobalKey);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text(
                    "BlenderHut",
                    style: GoogleFonts.anton(
                      fontSize: 75,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFieldWidget(
                        labelText: 'Email',
                        obscureText: false,
                        prefixIconData: Icons.mail_outline,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TextFieldWidget(
                            labelText: 'Password',
                            obscureText: true,
                            prefixIconData: Icons.lock_outline,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ButtonWidget(
                        title: 'Login',
                        hasBorder: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonWidget(
                        title: 'Sign Up',
                        hasBorder: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        child: Text("Magic Button"),
                        height: MediaQuery.of(context).size.height / 15,
                        minWidth: MediaQuery.of(context).size.width / 3,
                        color: Colors.green,
                        onPressed: () {
                          // add validation and checking with the api
                          // if successful:
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  App(widget.navBarGlobalKey),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
