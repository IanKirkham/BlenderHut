import 'package:blenderapp/widgets/textFieldWidget.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../custom_icons_icons.dart';
import 'ingredient_tile.dart';

class RecipeBuilder extends StatelessWidget {
  final String title;
  RecipeBuilder({this.title});

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
                  value: title,
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
                      children: myChildren(5),
                    ),
                    GestureDetector(
                      onTap: () => _dialogPopup(context).then((success) {
                        if (success) {
                          print("Success");
                          final snackbar = SnackBar(
                            content: Text("Successfully Added Ingredient"),
                            backgroundColor: Color(0xFF48C28C),
                          );
                          _scaffoldKey.currentState.showSnackBar(snackbar);
                        } else {
                          print("Failure");
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
                        "Delete Recipe",
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
                        "Create Recipe",
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
          child: MyCustomDialog(),
        );
      },
    );
    return success == null ? false : success;
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
      list.add(IngredientTile(
          icons[i], ingredients[i], colors[i], amounts[i], units[i]));
    }

    return list;
  }

  // Mock Data
  final List<IconData> icons = [
    CustomIcons.peach,
    CustomIcons.ice_cream,
    CustomIcons.milk,
    CustomIcons.banana,
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
    "1",
    "3/4",
    "2",
    "1/2",
    "1",
  ];
  final List<String> units = [
    "cup",
    "cup",
    "cups",
    "cup",
    "cup",
  ];
}

class MyCustomDialog extends StatefulWidget {
  @override
  _MyCustomDialogState createState() => _MyCustomDialogState();
}

class _MyCustomDialogState extends State<MyCustomDialog> {
  //String unitDropDownValue = 'Cup';
  //int _currentValue = 1;
  List<dynamic> _amountList;
  List<int> _pickerIndex;
  String currentIngredient;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF2F3D46),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // TextField(
            //   controller: editingController,
            //   decoration: InputDecoration(
            //       labelText: "Ingredient",
            //       hintText: "Search",
            //       prefixIcon: Icon(Icons.search),
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.all(
            //               Radius.circular(5.0)))),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFieldWidget(
            //     obscureText: false,
            //     hintText: "Search",
            //     labelText: "Ingredient",
            //     prefixIconData: Icons.search,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                showSelectedItem: true,
                items: [
                  "Brazil",
                  "Italia",
                  "Tunisia",
                  'Canada',
                  "Brazil",
                  "Italia",
                  "Tunisia",
                  "Brazil",
                  "Italia",
                  "Tunisia"
                ],
                label: "Menu mode",
                onChanged: (newValue) {
                  setState(() {
                    currentIngredient = newValue;
                  });
                },
                showSearchBox: true,
                autoFocusSearchBox: true,
                popupBackgroundColor: Colors.green,
                popupTitle: Center(child: Text("Ingredients")),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                popupItemBuilder: (context, item, isSelected) {
                  if (isSelected) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Text(
                        item,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  } else {
                    return Text(
                      item,
                      style: TextStyle(color: Colors.black),
                    );
                  }
                },
                dropdownSearchDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  prefixIcon: Icon(Icons.ac_unit),
                  filled: true,
                  fillColor: Colors.pink,
                ),
                emptyBuilder: (context, string) {
                  return Container(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        "No Results",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _amountList == null
                    ? RaisedButton(
                        color: Colors.lightBlue[100],
                        child: Text("Select Amount"),
                        onPressed: () {
                          showAmountPicker(context, _pickerIndex);
                        },
                      )
                    : GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Colors.grey,
                          ),
                          child: Text(
                            formatAmountText(),
                          ),
                        ),
                        onTap: () {
                          showAmountPicker(context, _pickerIndex);
                        },
                      ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  color: Colors.red[400], //Colors.green,
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: currentIngredient == null || _amountList == null
                      ? null
                      : () => Navigator.pop(context, true),
                  disabledColor: Colors.grey,
                  // onPressed: () {
                  //   Navigator.pop(context, true);
                  // },
                  color: Color(0xFF48C28C), //Colors.green,
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String formatAmountText() {
    String finalString = "";

    if (_amountList[0] == "0" && _amountList[1] != "0") {
      finalString = _amountList[1] + " " + _amountList[2];
    } else if (_amountList[0] != "0" && _amountList[1] == "0") {
      if (_amountList[0] == "1") {
        finalString = _amountList[0] + " " + _amountList[2];
      } else {
        finalString = _amountList[0] + " " + _amountList[2] + "s";
      }
    } else {
      finalString = _amountList[0] +
          " and " +
          _amountList[1] +
          " " +
          _amountList[2] +
          "s";
    }
    return finalString;
  }

  void showAmountPicker(BuildContext context, selectedList) {
    Picker(
      backgroundColor: Color(0xFF2F3D46),
      selecteds: selectedList,
      adapter: PickerDataAdapter<String>(
        pickerdata: [
          List<int>.generate(26, (i) => i),
          ["0", "1/4", "1/2", "3/4"],
          [
            "Cup",
            "Tablespoon",
            "Ounce",
            "Gram",
            "Milimeter",
          ]
        ],
        isArray: true,
      ),
      headerDecoration: BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
      textScaleFactor: 1.5,
      textStyle: TextStyle(color: Colors.white),
      confirmTextStyle: TextStyle(color: Colors.greenAccent),
      cancelTextStyle: TextStyle(color: Colors.redAccent),
      title: new Text(
        "Ingredients",
        style: TextStyle(color: Colors.white),
      ),
      height: MediaQuery.of(context).size.height / 3,
      onConfirm: (Picker picker, List value) {
        //print(value.toString());
        //print(picker.getSelectedValues());

        if (picker == null) {
          return;
        }

        var currList = picker.getSelectedValues();

        if (currList[0] == "0" && currList[1] == "0") {
          // do not do anything if values are 0. In the future, change this to error message
        } else {
          setState(() {
            _pickerIndex = value;
            _amountList = picker.getSelectedValues();
          });
        }
      },
      onCancel: () {
        print("Picker was canceled");
      },
    ).showModal(context);
  }
}
