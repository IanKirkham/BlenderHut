import 'dart:math';

import 'package:blenderapp/models/recipe.dart';
import 'package:blenderapp/screens/recipe_detail/recipe_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customBlenderWidget.dart';

class FavoriteWidget extends StatelessWidget {
  final Recipe recipe;
  FavoriteWidget({this.recipe});

  final Random source = new Random();

  @override
  Widget build(BuildContext context) {
    double rand = source.nextDouble();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                RecipeDetail(recipe.id), //_recipes[widget.index]),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Color(0xFF2F3D46),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.45,
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/images/blender_graphic.png'),
                    decoration: BoxDecoration(
                      //color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  CustomBlenderWidget(value: rand),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: MediaQuery.of(context).size.width * 0.45,
                    child: Center(
                      child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.all(Radius.circular(5)),
                        //   color: Colors.purple,
                        // ),
                        padding: EdgeInsets.all(5),
                        child: Text(
                          (rand * 100).toStringAsFixed(0) + "%",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                recipe.title,
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
