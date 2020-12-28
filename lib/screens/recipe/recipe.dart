import 'package:flutter/material.dart';

class Recipe extends StatelessWidget {
  var _recipe;

  Recipe(this._recipe);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("This is a screen for: $_recipe"),
      ),
    );
  }
}
