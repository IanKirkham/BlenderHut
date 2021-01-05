import 'package:flutter/cupertino.dart';

class RecipeModel {
  String title;
  List<String> ingredients;
  List<double> amounts;
  List<String> units;
  String username;
  bool favorite;
  int id;

  RecipeModel({
    @required this.title,
    @required this.ingredients,
    @required this.amounts,
    @required this.units,
    @required this.username,
    @required this.favorite,
    @required this.id,
  });

  // Convert from json
  RecipeModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        ingredients = json['ingredients'],
        amounts = json['amounts'],
        units = json['units'],
        username = json['username'],
        favorite = json['favorite'],
        id = json['id'];

  // Convert to json
  Map<String, dynamic> toJson() => {
        'title': title,
        'ingredients': ingredients,
        'amounts': amounts,
        'units': units,
        'username': username,
        'favorite': favorite,
        'id': id,
      };
}
