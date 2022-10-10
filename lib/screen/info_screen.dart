import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ontologie_et_web_semantique/Notifiers/api_service.dart';
import 'package:ontologie_et_web_semantique/model/profile_model.dart';
import 'package:ontologie_et_web_semantique/model/test_model.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});
  static const String routeName = "info_screen";
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  Test test = Test.empty();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            GestureDetector(
              onTap: () async {
                /*   ProfileModel x =
                    await Provider.of<ApiService>(context, listen: false)
                        .getProfile();
                log(x.age.toString());*/
                await Provider.of<ApiService>(context, listen: false)
                    .createTest(test);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  color: Colors.grey,
                ),
                child: const Text("Get Profile Data"),
              ),
            ),
            TextField(
              onChanged: (value) {
                test.name = value;
              },
            ),
          ],
        ),
      )),
    );
  }
}
