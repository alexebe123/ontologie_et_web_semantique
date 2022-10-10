import 'dart:developer';

class ProfileModel {
  String id = "";
  String name = "";
  String lastname = "";
  int age = 0;

  ProfileModel.empty();

  ProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json["id"];
    } catch (e) {
      log(e.toString());
    }
    try {
      lastname = json["lastname"];
    } catch (e) {
      log(e.toString());
    }
    try {
      name = json["name"];
    } catch (e) {
      log(e.toString());
    }
    try {
      age = int.parse(json["age"]);
    } catch (e) {
      log(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['lastname'] = lastname;
    data['age'] = age;

    return data;
  }
}
