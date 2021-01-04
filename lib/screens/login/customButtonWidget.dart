import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final GlobalKey<FormState> formKey;
  final Function onPressed;

  CustomButtonWidget({
    this.title,
    this.hasBorder,
    this.formKey,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (formKey.currentState.validate()) {
          onPressed();
        }
      },
      child: Material(
        borderRadius: BorderRadius.circular(5),
        child: Ink(
          decoration: BoxDecoration(
            color: hasBorder ? Colors.white : Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(5),
            border: hasBorder
                ? Border.all(
                    color: Colors.lightBlueAccent,
                    width: 1.0,
                  )
                : Border.fromBorderSide(BorderSide.none),
          ),
          child: InkWell(
            child: Container(
              height: 60,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: hasBorder ? Colors.lightBlueAccent : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
