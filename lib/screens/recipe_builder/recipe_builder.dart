import 'package:blenderapp/apiService.dart';
import 'package:blenderapp/models/ingredient.dart';
import 'package:blenderapp/models/recipe.dart';
import 'package:blenderapp/screens/recipe_builder/newIngredientDialog.dart';
import 'package:blenderapp/widgets/customTextFormField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'ingredient_tile.dart';

class RecipeBuilder extends StatefulWidget {
  final Recipe recipe;
  RecipeBuilder({this.recipe});

  @override
  _RecipeBuilderState createState() => _RecipeBuilderState();
}

class _RecipeBuilderState extends State<RecipeBuilder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final titleTextController = TextEditingController();
  List<IngredientTile> ingredientTiles;

  @override
  void initState() {
    super.initState();
    widget.recipe != null
        ? ingredientTiles = popuplateIngredients()
        : ingredientTiles = new List<IngredientTile>();
    widget.recipe != null
        ? titleTextController.text = widget.recipe.title
        : titleTextController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("New Recipe"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: CustomTextFormField(
                  obscureText: false,
                  labelText: "Title",
                  controller: titleTextController,
                ),
              ),
              Text(
                "Swipe right to remove an ingredient",
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                        color: Colors.lightBlueAccent,
                      ),
                      child: Center(
                        child: Text(
                          "Ingredients",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    Column(
                      children: ingredientTiles.map((tile) {
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          dragStartBehavior: DragStartBehavior.down,
                          onDismissed: (direction) =>
                              ingredientTiles.remove(tile),
                          background: Container(
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete,
                                        size: 40, color: Colors.white),
                                    Text("Remove"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          child: tile,
                        );
                      }).toList(), //popuplateIngredients(),
                    ),
                    GestureDetector(
                      onTap: () => _dialogPopup(context).then((data) {
                        if (data != null) {
                          print("Pushed added ingredient");
                          // add logic for adding to the list
                          setState(() {
                            ingredientTiles.add(data);
                          });

                          final snackbar = SnackBar(
                            content: Text("Successfully Added Ingredient"),
                            backgroundColor: Color(0xFF48C28C),
                          );
                          _scaffoldKey.currentState.showSnackBar(snackbar);
                        } else {
                          print("Canceled adding ingredient");
                        }
                      }),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 8.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                          color: Color(0xFF2F3D46),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 50,
                                color: Colors.white,
                              ),
                              Text(
                                "Add New Ingredient",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                                widget.recipe == null
                                    ? 'Are you sure you want to discard recipe?'
                                    : 'Are you sure you want to delete recipe?',
                                style: TextStyle(color: Colors.black)),
                            actions: [
                              RaisedButton(
                                  child: Text('Cancel'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false)),
                              RaisedButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  if (widget.recipe != null) {
                                    deleteRecipe(widget.recipe.id).then(
                                        (value) =>
                                            Navigator.of(context).pop(true));
                                  }
                                  //Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          ),
                        ).then((shouldPop) =>
                            shouldPop ? Navigator.pop(context) : null);
                      },
                      // minWidth: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 17,
                      color: Colors.red[400], //Colors.green,
                      child: Text(
                        widget.recipe != null
                            ? "Delete Recipe"
                            : "Discard Recipe",
                        style: TextStyle(
                          color: Colors.white,
                          // fontSize: 24,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        if (titleTextController.text == "") {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text("Recipe must have a title"),
                          ));
                        } else if (ingredientTiles.length < 1) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                "Recipe must contain at least one ingredient"),
                          ));
                        } else {
                          // print(ingredientTiles.length);
                          if (widget.recipe == null) {
                            // create new recipe in the database
                            List<String> idList = ingredientTiles
                                .map((tile) => tile.ingredient.id)
                                .toList();
                            List<int> amountList = ingredientTiles
                                .map((tile) => tile.amount)
                                .toList();
                            List<String> unitList = ingredientTiles
                                .map((tile) => tile.unit)
                                .toList();
                            Recipe newRecipe = Recipe(
                              title: titleTextController.text,
                              ingredients: idList,
                              amounts: amountList,
                              units: unitList,
                            );
                            createRecipe(newRecipe)
                                .then((value) => Navigator.pop(context));
                          } else {
                            // modify existing recipe in the database
                            List<String> idList = ingredientTiles
                                .map((tile) => tile.ingredient.id)
                                .toList();
                            List<int> amountList = ingredientTiles
                                .map((tile) => tile.amount)
                                .toList();
                            List<String> unitList = ingredientTiles
                                .map((tile) => tile.unit)
                                .toList();
                            widget.recipe.title = titleTextController.text;
                            widget.recipe.ingredients = idList;
                            widget.recipe.amounts = amountList;
                            widget.recipe.units = unitList;
                            updateRecipe(widget.recipe)
                                .then((value) => Navigator.pop(context));
                          }
                          //Navigator.pop(context);
                        }
                      },
                      height: MediaQuery.of(context).size.height / 17,
                      color: Color(0xFF48C28C), //Colors.green,
                      child: Text(
                        widget.recipe != null
                            ? "Save Changes"
                            : "Create Recipe",
                        style: TextStyle(
                          color: Colors.white,
                          // fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<IngredientTile> _dialogPopup(context) async {
    IngredientTile data = await showDialog<IngredientTile>(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: NewIngredientDialog(),
        );
      },
    );
    return data;
  }

  List<IngredientTile> popuplateIngredients() {
    List<IngredientTile> list = [];
    int count = widget.recipe.ingredients.length;
    for (int i = 0; i < count; i++) {
      list.add(IngredientTile(
        ingredient: Ingredient.fromJson(widget.recipe.ingredients[i]),
        amount: widget.recipe.amounts[i],
        unit: widget.recipe.units[i],
      ));
    }
    return list;
  }
}
