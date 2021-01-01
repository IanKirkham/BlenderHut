import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;
  final String value;

  TextFieldWidget({
    this.hintText,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
    this.labelText,
    this.value,
  });

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      textController.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      controller: textController,
      style: TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 18.0,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIconData,
          size: 18,
          color: Colors.lightBlueAccent,
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
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
          widget.suffixIconData,
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
