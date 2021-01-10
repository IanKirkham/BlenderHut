import 'package:blenderapp/models/ingredient.dart';
import 'package:blenderapp/models/recipe.dart';
import 'package:blenderapp/screens/recipe_builder/newIngredientDialog.dart';
import 'package:blenderapp/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';
import 'ingredient_tile.dart';

class RecipeBuilder extends StatelessWidget {
  // final String title;
  // RecipeBuilder({this.title});

  final Recipe recipe;
  RecipeBuilder({this.recipe});

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
                child: TextFieldWidget(
                  labelText: "(Title)",
                  hintText: "Enter a recipe title",
                  obscureText: false,
                  value: recipe != null ? recipe.title : null,
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
                    recipe != null
                        ? Column(
                            children: popuplateIngredients(),
                          )
                        : SizedBox.shrink(),
                    GestureDetector(
                      onTap: () => _dialogPopup(context).then((success) {
                        if (success) {
                          print("Pushed added ingredient");

                          // add logic for adding to the list

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
                        // save to the database?
                        Navigator.pop(context);
                      },
                      // minWidth: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 17,
                      color: Colors.red, //Colors.green,
                      child: Text(
                        recipe != null ? "Delete Recipe" : "Discard Changes",
                        style: TextStyle(
                          color: Colors.white,
                          // fontSize: 24,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        // save to the database?
                        Navigator.pop(context);
                      },
                      //minWidth: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 17,
                      color: Color(0xFF48C28C), //Colors.green,
                      child: Text(
                        recipe != null ? "Save Changes" : "Create Recipe",
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

  Future<bool> _dialogPopup(context) async {
    bool success = await showDialog<bool>(
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
    return success == null ? false : success;
  }

  List<IngredientTile> popuplateIngredients() {
    List<IngredientTile> list = [];
    int count = recipe.ingredients.length;
    for (int i = 0; i < count; i++) {
      // list.add(IngredientTile(
      //     icons[i], ingredients[i], colors[i], amounts[i], units[i]));
      list.add(IngredientTile(
        ingredient: Ingredient.fromJson(recipe.ingredients[i]),
        amount: recipe.amounts[i],
        unit: recipe.units[i],
      ));
    }
    return list;
  }

  // Mock Data
  // final List<IconData> icons = [
  //   CustomIcons.peach,
  //   CustomIcons.ice_cream,
  //   CustomIcons.milk,
  //   CustomIcons.banana,
  //   CustomIcons.strawberry,
  // ];
  // final List<String> ingredients = [
  //   "Peach",
  //   "Ice Cream",
  //   "Milk",
  //   "Banana",
  //   "Strawberry",
  // ];
  // final List<Color> colors = [
  //   Colors.red[200],
  //   Colors.orange[100],
  //   Colors.white,
  //   Color(0xffffe066),
  //   Color(0xfff25f5c),
  // ];
  // final List<String> amounts = [
  //   "1",
  //   "3/4",
  //   "2",
  //   "1/2",
  //   "1",
  // ];
  // final List<String> units = [
  //   "cup",
  //   "cup",
  //   "cups",
  //   "cup",
  //   "cup",
  // ];
}
