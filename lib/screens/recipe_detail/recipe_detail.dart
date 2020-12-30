import 'package:flutter/material.dart';

class RecipeDetail extends StatelessWidget {
  final _index;

  RecipeDetail(this._index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("This is a screen for: $_index"),
      ),
    );
  }
}
