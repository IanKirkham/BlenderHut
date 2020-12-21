import 'package:blenderapp/widgets/canisterGraph.dart';
import 'package:flutter/material.dart';

class Fill extends StatefulWidget {
  @override
  _FillState createState() => _FillState();
}

class _FillState extends State<Fill> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CanisterGraph(),
    );
  }
}
