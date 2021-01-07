import 'package:blenderapp/custom_icons_icons.dart';
import 'package:blenderapp/screens/recipe_builder/recipe_builder.dart';
import 'package:blenderapp/screens/recipe_detail/recipe_detail.dart';
import 'package:blenderapp/screens/recipe_list/ingredient_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeTile extends StatefulWidget {
  final int index;
  final _recipes;
  final _isFavorited;
  RecipeTile(this.index, this._recipes, this._isFavorited);

  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  static const MAX_TILE_WIDTH = 0.9;

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: 10,
    //   itemBuilder: (context, index) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => RecipeDetail(widget._recipes[widget.index]),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 24,
              width: MediaQuery.of(context).size.width * 0.90,
              padding: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                color: Color(0xFF2F3D46), //Colors.blueGrey[400],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: (widget._isFavorited[widget.index]
                        ? Icon(Icons.favorite, color: Colors.pinkAccent)
                        : Icon(Icons.favorite_border, color: Colors.grey)),
                    onPressed: () => setState(() {
                      widget._isFavorited[widget.index] =
                          !widget._isFavorited[widget.index];
                    }),
                  ),
                  Align(
                    child: Text("Title Here", style: GoogleFonts.montserrat()),
                  ),
                  GestureDetector(
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
                        CupertinoPageRoute(
                          builder: (context) =>
                              RecipeBuilder(title: "Recipe ${widget.index}"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width * MAX_TILE_WIDTH,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  IngredientSection(
                    icon: CustomIcons.peach,
                    amount: "1 cup",
                    color: Colors.red[200],
                    width: MAX_TILE_WIDTH,
                    ratio: 5,
                  ),
                  IngredientSection(
                    icon: CustomIcons.ice_cream,
                    amount: "3/4 cup",
                    color: Colors.orange[100],
                    width: MAX_TILE_WIDTH,
                    ratio: 5,
                  ),
                  IngredientSection(
                    icon: CustomIcons.milk,
                    amount: "2 cups",
                    color: Colors.white,
                    width: MAX_TILE_WIDTH,
                    ratio: 5,
                  ),
                  IngredientSection(
                    icon: CustomIcons.banana,
                    amount: "1/2 cup",
                    color: Color(0xffffe066),
                    width: MAX_TILE_WIDTH,
                    ratio: 5,
                  ),
                  IngredientSection(
                    icon: CustomIcons.strawberry,
                    amount: "1 cup",
                    color: Color(0xfff25f5c),
                    width: MAX_TILE_WIDTH,
                    ratio: 5,
                  ),
                ],
              ),
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
