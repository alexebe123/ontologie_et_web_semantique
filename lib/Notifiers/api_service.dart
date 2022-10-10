import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ontologie_et_web_semantique/model/profile_model.dart';
import 'package:ontologie_et_web_semantique/model/test_model.dart';

class ApiService extends ChangeNotifier {
  static ApiService? _instance;

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
}
