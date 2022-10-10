import 'dart:developer';

class Test {
  String name = "";

  Test.empty();

  Test.fromJson(Map<String, dynamic> json) {
    try {
      name = json["name"];
    } catch (e) {
      log(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['name'] = name;

    return data;
  }
}
