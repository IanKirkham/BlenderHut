import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
              child: Container(
                height: 400,
                width: double.infinity,
                color: Colors.cyanAccent[400],
                child: Center(
                    child: Text("Insert graph here",
                        style: TextStyle(fontSize: 30))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child:
                  Text("This is our home page", style: TextStyle(fontSize: 30)),
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.cyanAccent[400],
              child: Center(
                  child: Text("Insert graph here",
                      style: TextStyle(fontSize: 30))),
            ),
          ],
        ),
      ),
    );
  }
}
