import 'package:flutter/material.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is our recipes page', style: TextStyle(fontSize: 20)),
    );
  }
}
