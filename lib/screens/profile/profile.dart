import 'package:blenderapp/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Text('This is our profile page', style: TextStyle(fontSize: 20)),
    // );
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.star_border, size: 40),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 28,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.blueGrey[400],
                ),
                child: Center(
                  child: Text("Title Here"),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 8,
                width: MediaQuery.of(context).size.width *
                    0.80, // Change 0.80 to a constant, used to calculate inside container widths
                // also change 5 to a constant, just use the number of ingredients in a recipe
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.8 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CustomIcons.peach, size: 40),
                          Text(
                            "1 cup",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      color: Colors.red[200],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.8 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CustomIcons.ice_cream, size: 40),
                          Text(
                            "3/4 cup",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      color: Colors.orange[100],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.8 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CustomIcons.milk, size: 40),
                          Text(
                            "2 cups",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      color: Colors.white,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.8 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CustomIcons.bananas, size: 40),
                          Text(
                            "1/2 cup",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      color: Colors.yellow,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width * 0.8 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CustomIcons.strawberry, size: 40),
                          Text(
                            "1 cup",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
