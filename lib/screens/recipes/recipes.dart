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

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  var _recipes = List<String>.generate(100, (i) => "Item $i");
  var _favButton = List<Icon>.generate(
      100, (i) => Icon(Icons.star_border, color: Colors.grey));

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: _favButton[index],
          title: Text(
            _recipes[index],
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text("subtext"),
          onTap: () {},
        );
        // return Row(
        //   children: [
        //     MaterialButton(
        //       onPressed: () {
        //         setState(() {
        //           _favButton = Icon(Icons.star, color: Colors.yellow);
        //         });
        //       },
        //       child: _favButton,
        //     ),
        //     Text(
        //       '${recipes[index]}',
        //       style: TextStyle(color: Colors.white),
        //     ),
        //   ],
        // );
      },
    );
  }
}
