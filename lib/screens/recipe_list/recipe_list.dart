import 'package:blenderapp/custom_icons_icons.dart';
import 'package:blenderapp/screens/recipe_builder/recipe_builder.dart';
import 'package:blenderapp/screens/recipe_detail/recipe_detail.dart';
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
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Color(0xFF2F3D46),
          expandedHeight: MediaQuery.of(context).size.height / 6,
          // floating: true,
          // pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('My Recipes'),
            centerTitle: true,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.blueAccent,
                size: 30,
              ),
              tooltip: 'Add new recipe',
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
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Recipes(index, _recipes, _isFavorited);
            },
            childCount: 15,
          ),
        ),
      ],
    );
  }
}

class Recipes extends StatefulWidget {
  final int index;
  var _recipes;
  var _isFavorited;
  Recipes(this.index, this._recipes, this._isFavorited);

  @override
  _RecipesState createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetail(widget._recipes[widget.index]),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: (widget._isFavorited[widget.index]
                  ? Icon(Icons.favorite, color: Colors.pinkAccent, size: 30)
                  : Icon(Icons.favorite_border, color: Colors.grey, size: 30)),
              onPressed: () => setState(() {
                widget._isFavorited[widget.index] =
                    !widget._isFavorited[widget.index];
              }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 28,
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    color: Color(0xFF2F3D46), //Colors.blueGrey[400],
                  ),
                  child: Stack(
                    children: [
                      Align(
                        child: Text("Title Here",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                            )),
                      ),
                      Positioned(
                        right: 7,
                        top: 3,
                        child: GestureDetector(
                          child: Text(
                            "Edit",
                            style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[400],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeBuilder(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width *
                      0.80, // Change 0.80 to a constant, used to calculate inside container widths
                  // also change 5 to a constant, just use the number of ingredients in a recipe
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.8 / 5,
                        color: Colors.red[200],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(CustomIcons.peach, size: 40),
                            Text(
                              "1 cup",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.8 / 5,
                        color: Colors.orange[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(CustomIcons.ice_cream, size: 40),
                            Text(
                              "3/4 cup",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.8 / 5,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(CustomIcons.milk, size: 40),
                            Text(
                              "2 cups",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.8 / 5,
                        color: Colors.yellow,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(CustomIcons.bananas, size: 40),
                            Text(
                              "1/2 cup",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width * 0.8 / 5,
                        color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(CustomIcons.strawberry, size: 40),
                            Text(
                              "1 cup",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    //   },
    // );

    // return ListView.builder(
    //   itemCount: _recipes.length,
    //   itemBuilder: (context, index) {
    //     return ListTile(
    //       leading: IconButton(
    //           icon: (_isFavorited[index]
    //               ? Icon(Icons.favorite, color: Colors.pinkAccent, size: 30)
    //               : Icon(Icons.favorite_border, color: Colors.grey, size: 30)),
    //           onPressed: () => setState(() {
    //                 _isFavorited[index] = !_isFavorited[index];
    //               })),
    //       title: Text(
    //         _recipes[index],
    //         style: TextStyle(color: Colors.white),
    //       ),
    //       subtitle: Text("subtext"),
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => RecipeDetail(_recipes[index])),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
