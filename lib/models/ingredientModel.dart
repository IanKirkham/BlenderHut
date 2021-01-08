class IngredientModel {
  String id;
  String name;
  int iconCode;
  int colorValue;

  IngredientModel({this.id, this.name, this.iconCode, this.colorValue});

  IngredientModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    iconCode = json['icon_code'];
    colorValue = json['color_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['icon_code'] = this.iconCode;
    data['color_value'] = this.colorValue;
    return data;
  }
}
