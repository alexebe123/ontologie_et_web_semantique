import 'dart:developer';

class ProfileModel {
  int id = 0;
  String name = "";
  String lastname = "";
  int age = 0;

  ProfileModel(
      {required this.age,
      required this.id,
      required this.lastname,
      required this.name});
  ProfileModel.empty();

  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) {
    return ProfileModel(
        id: int.parse(json["id"]),
        name: json['name'],
        age: int.parse(json["age"]),
        lastname: json["lastname"]);
  }

  ProfileModel.fromJsonFire(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    try {
      data['id'] = id.toString();
    } catch (e) {
      log(e.toString());
    }
    try {
      data['name'] = name;
    } catch (e) {
      log(e.toString());
    }
    try {
      data['lastname'] = lastname;
    } catch (e) {
      log(e.toString());
    }
    try {
      data['age'] = age.toString();
    } catch (e) {
      log(e.toString());
    }
    return data;
  }
}
