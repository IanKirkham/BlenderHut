import 'package:blenderapp/models/ingredient.dart';
import 'package:flutter/material.dart';

class IngredientSection extends StatelessWidget {
  // final IconData icon;
  // final String amount;
  // final Color color;
  // final double width;
  // final int ratio;

  final Ingredient ingredient;
  final double width;
  final int totalCount;
  final String amount;

  // IngredientSection({
  //   @required this.icon,
  //   @required this.amount,
  //   @required this.color,
  //   @required this.width,
  //   @required this.ratio,
  // });

  IngredientSection({
    @required this.ingredient,
    @required this.width,
    @required this.totalCount,
    @required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * width / totalCount,
      color: Color(ingredient.colorValue),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(IconData(ingredient.iconCode, fontFamily: 'CustomIcons'),
              size: 40),
          Text(
            amount,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
