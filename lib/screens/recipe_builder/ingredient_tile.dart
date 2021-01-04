import 'package:flutter/material.dart';

class IngredientTile extends StatelessWidget {
  final IconData iconData;
  final String ingredient;
  final Color color;
  final String amount;

  IngredientTile(this.iconData, this.ingredient, this.color, this.amount);

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
          // trailing: Icon(Icons.remove_circle_outline),
        ),
      ),
    );
  }
}
