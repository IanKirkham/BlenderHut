import 'package:flutter/material.dart';

import '../../custom_icons_icons.dart';

class IngredientTile extends StatelessWidget {
  final IconData iconData;
  final String ingredient;
  final Color color;
  final String amount;

  IngredientTile(this.iconData, this.ingredient, this.color, this.amount);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: this.color,
      child: ListTile(
        leading: Icon(this.iconData, size: 40),
        title: Text(
          "$ingredient",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        subtitle: Text("$amount"),
        trailing: Icon(Icons.remove_circle_outline),
      ),
    );
  }
}
