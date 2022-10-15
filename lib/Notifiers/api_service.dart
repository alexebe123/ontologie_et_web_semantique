import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ontologie_et_web_semantique/expaired/pofile_model_tow.dart';
import 'package:ontologie_et_web_semantique/model/product_model.dart';
import 'package:ontologie_et_web_semantique/model/profile_model.dart';
import 'package:ontologie_et_web_semantique/expaired/test_model.dart';
import 'package:xml/xml.dart' as xml;

class ApiService extends ChangeNotifier {
  static ApiService? _instance;
  List<ProfileModel> listDBOne = [];
  List<ProfileModel> listDBTow = [];

  ApiService._internal();
  static ApiService get instance {
    _instance ??= ApiService._internal();
    return _instance!;
  }

  Future getProfile() async {
    try {
      var url = "http://10.0.2.2/dashboard/web/getProfile.php";
      var y = Uri.parse(url);
      var x = await http.get(y);
      final response = x;
      // ProfileModel list = ProfileModel.fromJson(json.decode(response.body[0][0]));

      //  profileModel = EmployeeDataSource(_employees);

      /*  if (response.statusCode == 200) {
        return list
            .map((spacecraft) => ProfileModel.fromJson(spacecraft))
            .toList();
      }
      */
      return ProfileModel.fromJson(json.decode(response.body));
    } catch (e) {
      log(e.toString());
    }
  }

  Future createTest(Test test) async {
    try {
      String url = "http://10.0.2.2/dashboard/web/create_data.php";
      await http.post(Uri.parse(url), body: test.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  Future getProfileXmlData() async {
    try {
      var url = "http://10.0.2.2/dashboard/web/get_xml_data.php";
      var y = Uri.parse(url);
      var x = await http.get(y);
      final response = x;
      // ProfileModel list = ProfileModel.fromJson(json.decode(response.body[0][0]));

      //  profileModel = EmployeeDataSource(_employees);

      /*  if (response.statusCode == 200) {
        return list
            .map((spacecraft) => ProfileModel.fromJson(spacecraft))
            .toList();
      }
      */
      return ProfileModelTow.fromXml(json.decode(response.body));
    } catch (e) {
      log(e.toString());
    }
  }

  List<ProfileModel> profileFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<ProfileModel>.from(
        data.map((item) => ProfileModel.fromJson(item)));
  }

  Future<List<ProfileModel>> getDataDBOne() async {
    List<ProfileModel> list = [];
    try {
      final response = await http
          .get(Uri.parse("http://10.0.2.2/dashboard/web/getProfileDBOne.php"));
      if (response.statusCode == 200) {
        list = profileFromJson(response.body);
        log(list.length.toString());
        listDBOne = list;
        return list;
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return list;
  }

  Future<List<ProfileModel>> getDataDBTow() async {
    List<ProfileModel> list = [];
    try {
      final response = await http
          .get(Uri.parse("http://10.0.2.2/dashboard/web/getProfileDBTow.php"));
      if (response.statusCode == 200) {
        list = profileFromJson(response.body);
        log(list.length.toString());
        listDBTow = list;
        return list;
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return list;
  }

  Future updateDBOne(List<ProfileModel> list) async {
    try {
      for (int i = 0; i < list.length; i++) {
        String url = "http://10.0.2.2/dashboard/web/updateDBOne.php";
        final res = await http.post(Uri.parse(url), body: list[i].toJson());
        if (res.statusCode == 200) {
          log(res.body.toString());
        } else {
          log("Error");
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
