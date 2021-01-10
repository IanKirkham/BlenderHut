import 'package:blenderapp/models/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientTile extends StatelessWidget {
  // final IconData iconData;
  // final String ingredient;
  // final Color color;
  final Ingredient ingredient;
  final String amount;
  final String unit;

  // IngredientTile(
  //     {this.iconData, this.ingredient, this.color, this.amount, this.unit});

  IngredientTile({this.ingredient, this.amount, this.unit});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey("id"),
      direction: DismissDirection.endToStart,
      //onDismissed: (direction) {},
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, size: 40, color: Colors.white),
                Text("Remove"),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(15),
        color: Color(ingredient.colorValue),
        child: ListTile(
          leading: Icon(
              IconData(ingredient.iconCode, fontFamily: 'CustomIcons'),
              size: 40),
          title: Text(
            "${ingredient.name}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          subtitle: Text("$amount $unit"),
          // trailing: Icon(Icons.remove_circle_outline),
        ),
      ),
    );
  }
}
