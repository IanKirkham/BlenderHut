import 'package:flutter/material.dart';

class IngredientSection extends StatelessWidget {
  final IconData icon;
  final String amount;
  final Color color;
  final double width;
  final int ratio;

  IngredientSection({
    @required this.icon,
    @required this.amount,
    @required this.color,
    @required this.width,
    @required this.ratio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * this.width / this.ratio,
      color: this.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(this.icon, size: 40),
          Text(
            this.amount,
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
