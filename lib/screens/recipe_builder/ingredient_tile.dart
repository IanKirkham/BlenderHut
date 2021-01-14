import 'package:blenderapp/models/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientTile extends StatelessWidget {
  // final IconData iconData;
  // final String ingredient;
  // final Color color;
  final Ingredient ingredient;
  final int amount;
  final String unit;
  //final Function removeIngredient;

  // IngredientTile(
  //     {this.iconData, this.ingredient, this.color, this.amount, this.unit});

  IngredientTile({
    this.ingredient,
    this.amount,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Color(ingredient.colorValue),
      child: ListTile(
        leading: Icon(IconData(ingredient.iconCode, fontFamily: 'CustomIcons'),
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
    );
  }
}
