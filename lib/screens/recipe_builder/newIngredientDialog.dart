import 'package:blenderapp/models/ingredient.dart';
import 'package:blenderapp/screens/recipe_builder/ingredient_tile.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../apiService.dart';

class NewIngredientDialog extends StatefulWidget {
  final List<dynamic> optAmountList;
  final List<int> optPickerList;
  final Ingredient optIngredient;

  NewIngredientDialog(
      {this.optAmountList, this.optPickerList, this.optIngredient});

  @override
  _NewIngredientDialogState createState() => _NewIngredientDialogState();
}

class _NewIngredientDialogState extends State<NewIngredientDialog> {
  List<dynamic> _amountList;
  List<int> _pickerIndex;
  Ingredient currentIngredient;

  List<Ingredient> ingredientList;

  @override
  void initState() {
    super.initState();
    widget.optAmountList != null
        ? _amountList = widget.optAmountList
        : _amountList = null;
    widget.optPickerList != null
        ? _pickerIndex = widget.optPickerList
        : _pickerIndex = null;
    widget.optIngredient != null
        ? currentIngredient = widget.optIngredient
        : currentIngredient = null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF2F3D46),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: Text(
                "Add New Ingredient",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              margin: EdgeInsets.all(12),
              child: DropdownSearch<Ingredient>(
                mode: Mode.DIALOG,
                showSelectedItem: true,
                autoFocusSearchBox: true,
                onFind: (filter) => getIngredientList(null),
                onChanged: (newIngredient) {
                  setState(() {
                    currentIngredient = newIngredient;
                    //currentIngredient = newValue;
                  });
                },
                compareFn: (Ingredient i, Ingredient s) => i.isEqual(s),
                //itemAsString: (Ingredient i) => i.ingredientAsString(),
                showSearchBox: true,
                //autoFocusSearchBox: true,
                popupBackgroundColor: Color(0xFF2F3D46),
                popupTitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child:
                          Text("Ingredients", style: TextStyle(fontSize: 28))),
                ),
                popupShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                popupItemBuilder: (context, item, isSelected) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: !isSelected
                        ? null
                        : BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                    child: ListTile(
                      selected: isSelected,
                      title: Text(item.name),
                      leading: Icon(
                          IconData(item.iconCode, fontFamily: 'CustomIcons'),
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                          size: 32),
                    ),
                  );
                },
                dropdownBuilder: (context, selectedItem, itemAsString) {
                  if (currentIngredient == null) {
                    return Text("Select Ingredient",
                        style: TextStyle(color: Colors.black, fontSize: 20));
                  }
                  return Text(selectedItem.name,
                      style: TextStyle(color: Colors.black));
                },
                dropdownSearchDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: currentIngredient == null
                      ? null
                      : Icon(
                          IconData(currentIngredient.iconCode,
                              fontFamily: 'CustomIcons'),
                          size: 32),
                  filled: true,
                  fillColor: currentIngredient == null
                      ? Colors.lightBlue[100]
                      : Color(currentIngredient.colorValue),
                ),
                emptyBuilder: (context, string) {
                  return Container(
                    //color: Colors.blue,
                    child: Center(
                      child: Text(
                        "No Results",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
            _amountList == null
                ? Container(
                    height: MediaQuery.of(context).size.height / 10,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(12),
                    child: RaisedButton(
                      color: Colors.lightBlue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Select Amount",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        showAmountPicker(context, _pickerIndex);
                      },
                    ),
                  )
                : GestureDetector(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Colors.lightBlue,
                      ),
                      child: Center(
                        child: Text(
                          formatAmountText(),
                        ),
                      ),
                    ),
                    onTap: () {
                      showAmountPicker(context, _pickerIndex);
                    },
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, null);
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
                      : () => Navigator.pop(
                            context,
                            IngredientTile(
                              ingredient: currentIngredient,
                              amount: int.parse(_amountList[0]),
                              unit: _amountList[1],
                            ),
                          ),
                  disabledColor: Colors.grey,
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

    // if (_amountList[0] == "0" && _amountList[1] != "0") {
    //   finalString = _amountList[1] + " " + _amountList[2];
    // } else if (_amountList[0] != "0" && _amountList[1] == "0") {
    //   if (_amountList[0] == "1") {
    //     finalString = _amountList[0] + " " + _amountList[2];
    //   } else {
    //     finalString = _amountList[0] + " " + _amountList[2] + "s";
    //   }
    // } else {
    //   finalString = _amountList[0] +
    //       " and " +
    //       _amountList[1] +
    //       " " +
    //       _amountList[2] +
    //       "s";
    // }
    finalString = _amountList[0] + " " + _amountList[1];

    return finalString;
  }

  void showAmountPicker(BuildContext context, selectedList) {
    Picker(
      backgroundColor: Color(0xFF2F3D46),
      selecteds: selectedList,
      adapter: PickerDataAdapter<String>(
        pickerdata: [
          //List<int>.generate(501, (i) => i),
          //["0", "1/4", "1/2", "3/4"],
          List<int>.generate(1001, (i) => i),
          [
            "grams",
            // "Cup",
            // "Tablespoon",
            // "Ounce",
            // "Mililiter",
          ]
        ],
        isArray: true,
      ),
      headerDecoration: BoxDecoration(
        color: Colors.lightBlueAccent,
      ),
      textScaleFactor: 1.8,
      textStyle: TextStyle(color: Colors.white),
      confirmTextStyle: TextStyle(color: Colors.greenAccent, fontSize: 18),
      cancelTextStyle: TextStyle(color: Colors.redAccent, fontSize: 18),
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

        if (currList[0] == "0") {
          if (_amountList != null) {
            setState(() {
              _amountList = null;
            });
          }
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
