import 'package:flutter/material.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  var recipes = List<String>.generate(100, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            '${recipes[index]}',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
