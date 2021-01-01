import 'package:blenderapp/custom_icons_icons.dart';
import 'package:blenderapp/screens/recipe_builder/recipe_builder.dart';
import 'package:blenderapp/screens/recipe_detail/recipe_detail.dart';
import 'package:blenderapp/screens/recipe_list/recipe_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeList extends StatefulWidget {
  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  var _recipes = List<String>.generate(15, (i) => "Recipe #$i");
  var _isFavorited = List<bool>.generate(15, (i) => false);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('My Recipes', style: Theme.of(context).textTheme.headline4),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(Icons.add, size: 35),
    //     onPressed: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => RecipeBuilder(),
    //         ),
    //       );
    //     },
    //   ),
    //   body: Recipes(),
    // );
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   backgroundColor: Color(0xFF2F3D46),
          //   expandedHeight: MediaQuery.of(context).size.height / 8,
          //   // floating: true,
          //   // pinned: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     title: Text('My Recipes'),
          //     centerTitle: true,
          //   ),
          //   actions: <Widget>[
          //     IconButton(
          //       icon: Icon(
          //         Icons.add,
          //         color: Colors.lightBlueAccent,
          //         size: 40,
          //       ),
          //       tooltip: 'Add new recipe',
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => RecipeBuilder(),
          //           ),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          SliverAppBar(
            snap: true,
            forceElevated: true,
            floating: true,
            title: Text(
              "My Recipes",
              style: TextStyle(fontSize: 35),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 40,
                  color: Colors.lightBlueAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeBuilder(),
                    ),
                  );
                },
              ),
            ],
            expandedHeight: 2 * kToolbarHeight,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16),
                      child: RaisedButton(
                          color: Colors.lightBlueAccent,
                          child: Text(
                            "Button One",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 16),
                      child: RaisedButton(
                          color: Colors.lightBlueAccent,
                          child: Text(
                            "Button Two",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return RecipeTile(index, _recipes, _isFavorited);
              },
              childCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}
