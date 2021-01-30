import 'ingredient.dart';

class ContainerData {
  Ingredient ingredient;
  int percentFull;
  String label;
  String containerType;
  String id;

  ContainerData({
    this.ingredient,
    this.percentFull,
    this.label,
    this.containerType,
    this.id,
  });

  // Convert from json
  ContainerData.fromJson(Map<String, dynamic> json)
      : ingredient = json['ingredient'] != null
            ? Ingredient.fromJson(json['ingredient'])
            : null,
        percentFull = json['percent_full'],
        label = json['label'],
        containerType = json['container_type'],
        id = json['_id'];

  // Convert to json
  Map<String, dynamic> toJson() => {
        'ingredient': ingredient,
        'percent_full': percentFull,
        'label': label,
        'container_type': containerType,
        '_id': id,
      };
}
