class Recipe {
  String title;
  List ingredients;
  List amounts;
  List units;
  String user;
  bool favorite;
  String id;

  Recipe({
    this.title,
    this.ingredients,
    this.amounts,
    this.units,
    this.user,
    this.favorite,
    this.id,
  });

  // Convert from json
  Recipe.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        ingredients = json['ingredients'],
        amounts = json['amounts'],
        units = json['units'],
        user = json['user'],
        favorite = json['favorite'],
        id = json['_id'];

  // Convert to json
  Map<String, dynamic> toJson() => {
        'title': title,
        'ingredients': ingredients,
        'amounts': amounts,
        'units': units,
        'user': user,
        'favorite': favorite,
        '_id': id,
      };
}
