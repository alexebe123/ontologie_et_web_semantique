import 'dart:developer';
import 'package:xml/xml.dart' as xml;

class ProfileModelTow {
  String id = "";
  String name = "";
  String lastname = "";
  int age = 0;

  ProfileModelTow.empty();

  ProfileModelTow.fromXml(xml.XmlElement xmlNode) {
    try {
      id = xmlNode.findAllElements("id").single.text;
    } catch (e) {
      log(e.toString());
    }
    try {
      name = xmlNode.findAllElements("name").single.text;
    } catch (e) {
      log(e.toString());
    }
    try {
      lastname = xmlNode.findAllElements("lastname").single.text;
    } catch (e) {
      log(e.toString());
    }
    try {
      age = int.parse(xmlNode.findAllElements("age").single.text);
    } catch (e) {
      log(e.toString());
    }
  }

  Map<String, dynamic> toXml() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['lastname'] = lastname;
    data['age'] = age;

    return data;
  }
}
