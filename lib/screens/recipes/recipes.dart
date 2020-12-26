import 'package:blenderapp/screens/recipe-builder/recipe-builder.dart';
import 'package:flutter/material.dart';

class Recipes extends StatefulWidget {
  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes', style: Theme.of(context).textTheme.headline4),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 35),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeBuilder()),
          );
        },
      ),
      body: RecipeList(),
    );
  }
}

class RecipeList extends StatelessWidget {
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
