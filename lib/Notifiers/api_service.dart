import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  late FirebaseFirestore firebaseFirestore;
  List<ProfileModel> listDBOne = [];
  List<ProfileModel> listDBTow = [];

  ApiService._internal() {
    firebaseFirestore = FirebaseFirestore.instance;
  }
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
      final data = await firebaseFirestore.collection("profile").get();
      list = data.docs.map<ProfileModel>((doc) {
        var map = doc.data();
        map["\$id"] = doc.id;
        return ProfileModel.fromJsonFire(map);
      }).toList();
    } catch (e) {
      log(e.toString());
    }
    listDBOne = list;
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
        await firebaseFirestore
            .collection("profile")
            .doc(list[i].id.toString())
            .set(list[i].toJson());
      }
    } catch (e) {
      log(e.toString());
    }
  }
/*

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
  */
}
