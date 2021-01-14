class Ingredient {
  String id;
  String name;
  int iconCode;
  int colorValue;
  var density;
  String type;

  Ingredient(
      {this.id,
      this.name,
      this.iconCode,
      this.colorValue,
      this.density,
      this.type});

  Ingredient.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    iconCode = json['icon_code'];
    colorValue = json['color_value'];
    density = json['density'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['icon_code'] = this.iconCode;
    data['color_value'] = this.colorValue;
    data['density'] = this.density;
    data['type'] = this.type;
    return data;
  }

  bool isEqual(Ingredient model) {
    return this?.id == model?.id;
  }

  @override
  String toString() => name;
}
