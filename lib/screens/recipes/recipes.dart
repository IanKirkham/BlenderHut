import 'package:blenderapp/screens/recipe-builder/recipe-builder.dart';
import 'package:blenderapp/screens/recipe/recipe.dart';
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
  var _recipes = List<String>.generate(100, (i) => "Recipe #$i");
  var _isFavorited = List<bool>.generate(100, (i) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: IconButton(
              icon: (_isFavorited[index]
                  ? Icon(Icons.star, color: Colors.orange, size: 30)
                  : Icon(Icons.star_border, color: Colors.grey, size: 30)),
              onPressed: () => setState(() {
                    _isFavorited[index] = !_isFavorited[index];
                  })),
          title: Text(
            _recipes[index],
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text("subtext"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Recipe(_recipes[index])),
            );
          },
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
