import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;

  CustomTextFormField({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    @required this.obscureText,
    this.labelText,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      style: TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 18.0,
      ),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.red),
        ),
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Colors.lightBlueAccent,
        ),
        labelText: labelText,
        hintText: hintText,
        // filled: true,
        // fillColor: Colors.blueGrey[900],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: Colors.lightBlueAccent),
        ),
        suffixIcon: Icon(
          suffixIconData,
          size: 18,
          color: Colors.lightBlueAccent,
        ),
        labelStyle: TextStyle(
          color: Colors.lightBlueAccent,
        ),
        focusColor: Colors.lightBlueAccent,
      ),
    );
  }
}
