import 'package:flutter/material.dart';

class RecipeBuilder extends StatefulWidget {
  @override
  _RecipeBuilderState createState() => _RecipeBuilderState();
}

class _RecipeBuilderState extends State<RecipeBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Recipe"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a recipe title.',
                      labelText: 'Title',
                    ),
                    maxLength: 30,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFF2F3D46), //Colors.blueGrey[300],
                  ),
                  child: Center(
                    child: Text("Insert adding new ingredient stuff here"),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    // save to the database
                    Navigator.pop(context);
                  },
                  minWidth: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.height / 17,
                  color: Color(0xFF48C28C), //Colors.green,
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
