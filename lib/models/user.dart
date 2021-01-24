import 'containerData.dart';

class User {
  String username;
  List containers;
  String id;

  User({this.username, this.containers});

  // Convert from json
  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        containers = json['containers'],
        id = json['_id'];

  // Convert to json
  Map<String, dynamic> toJson() => {
        'username': username,
        'containers': containers,
        '_id': id,
      };
}
