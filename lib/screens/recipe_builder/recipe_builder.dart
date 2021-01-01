import 'package:blenderapp/widgets/textFieldWidget.dart';
import 'package:flutter/material.dart';

import '../../custom_icons_icons.dart';
import 'ingredient_tile.dart';

class RecipeBuilder extends StatefulWidget {
  final String title;
  RecipeBuilder({this.title});

  @override
  _RecipeBuilderState createState() => _RecipeBuilderState();
}

class _RecipeBuilderState extends State<RecipeBuilder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
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
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
                child: TextFieldWidget(
                  labelText: "(Title)",
                  hintText: "Enter a recipe title",
                  obscureText: false,
                  value: widget.title,
                ),
              ),
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
                      children: myChildren(5),
                    ),
                    Container(
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: MaterialButton(
                  onPressed: () {
                    // save to the database?
                    Navigator.pop(context);
                  },
                  minWidth: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 17,
                  color: Color(0xFF48C28C), //Colors.green,
                  child: Text(
                    "Create Recipe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ListView myListView() {
  //   return ListView(
  //     // shrinkWrap: true,
  //     children: myChildren(5),
  //     // itemCount: 5,
  //     // itemBuilder: (BuildContext context, int index) {
  //     //   return IngredientTile(
  //     //       icons[index], ingredients[index], colors[index], amounts[index]);
  //     // },
  //   );
  // }

  List<IngredientTile> myChildren(iterations) {
    List<IngredientTile> list = [];

    for (int i = 0; i < iterations; i++) {
      list.add(IngredientTile(icons[i], ingredients[i], colors[i], amounts[i]));
    }

    return list;
  }

  // Mock Data
  final List<IconData> icons = [
    CustomIcons.peach,
    CustomIcons.ice_cream,
    CustomIcons.milk,
    CustomIcons.bananas,
    CustomIcons.strawberry,
  ];
  final List<String> ingredients = [
    "Peach",
    "Ice Cream",
    "Milk",
    "Banana",
    "Strawberry",
  ];
  final List<Color> colors = [
    Colors.red[200],
    Colors.orange[100],
    Colors.white,
    Color(0xffffe066),
    Color(0xfff25f5c),
  ];
  final List<String> amounts = [
    "1 cup",
    "3/4 cup",
    "2 cups",
    "1/2 cup",
    "1 cup",
  ];
}
