import 'package:blenderapp/api_calls.dart';
import 'package:blenderapp/models/recipe.dart';
import 'package:blenderapp/screens/recipe_builder/recipe_builder.dart';
import 'package:blenderapp/screens/recipe_list/recipe_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () {
          return;
        },
        child: CustomScrollView(
          slivers: [
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
                      CupertinoPageRoute(
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
            FutureBuilder<List<Recipe>>(
              future: getRecipesHelper(),
              builder: (context, snapshot) {
                var childCount = 0;
                if (snapshot.connectionState != ConnectionState.done ||
                    snapshot.hasData == null) {
                  childCount = 1;
                } else {
                  childCount = snapshot.data.length;
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData == null) {
                        return Container();
                      }
                      return Container(
                        child: RecipeTile(snapshot.data[index]),
                      );
                    },
                    childCount: childCount,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Recipe>> getRecipesHelper() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String user = sharedPreferences.getString('user');
    return getRecipes(user);
  }
}
