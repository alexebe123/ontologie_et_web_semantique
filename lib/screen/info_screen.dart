import 'package:flutter/material.dart';
import 'package:ontologie_et_web_semantique/Notifiers/api_service.dart';
import 'package:ontologie_et_web_semantique/expaired/test_model.dart';
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
            SizedBox(
              height: 2.h,
            ),
            const Text("Data in DB 1"),
            (Provider.of<ApiService>(context, listen: false)
                    .listDBOne
                    .isNotEmpty)
                ? SizedBox(
                    height: 30.h,
                    width: 80.w,
                    child: ListView.separated(
                        itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey),
                              child: Row(children: [
                                Text(
                                  Provider.of<ApiService>(context,
                                          listen: false)
                                      .listDBOne[index]
                                      .id
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  Provider.of<ApiService>(context,
                                          listen: false)
                                      .listDBOne[index]
                                      .name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  Provider.of<ApiService>(context,
                                          listen: false)
                                      .listDBOne[index]
                                      .lastname,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  Provider.of<ApiService>(context,
                                          listen: false)
                                      .listDBOne[index]
                                      .age
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp),
                                ),
                              ]),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1.h,
                            ),
                        itemCount:
                            Provider.of<ApiService>(context, listen: false)
                                .listDBOne
                                .length))
                : Container(),
            SizedBox(
              height: 2.h,
            ),
            const Text("Data in DB 2"),
            (Provider.of<ApiService>(context, listen: false)
                    .listDBTow
                    .isNotEmpty)
                ? SizedBox(
                    height: 30.h,
                    width: 80.w,
                    child: ListView.separated(
                        itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5.w, vertical: 1.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  color: Colors.grey),
                              child: Row(children: [
                                Text(
                                    Provider.of<ApiService>(context,
                                            listen: false)
                                        .listDBTow[index]
                                        .id
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    )),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                    Provider.of<ApiService>(context,
                                            listen: false)
                                        .listDBTow[index]
                                        .name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    )),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                    Provider.of<ApiService>(context,
                                            listen: false)
                                        .listDBTow[index]
                                        .lastname,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    )),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                    Provider.of<ApiService>(context,
                                            listen: false)
                                        .listDBTow[index]
                                        .age
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                    )),
                              ]),
                            ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1.h,
                            ),
                        itemCount:
                            Provider.of<ApiService>(context, listen: false)
                                .listDBTow
                                .length))
                : Container(),
            SizedBox(
              height: 2,
            ),
            GestureDetector(
              onTap: () async {
                var listOne =
                    await Provider.of<ApiService>(context, listen: false)
                        .getDataDBOne();
                var listTow =
                    await Provider.of<ApiService>(context, listen: false)
                        .getDataDBTow();
                setState(() {});
                if (listTow.length > listOne.length) {
                  int index = 0;
                  if (listOne.isNotEmpty) {
                    index = listOne[listOne.length].id;
                    listTow = listTow.where((e) => e.id > index).toList();
                    await Provider.of<ApiService>(context, listen: false)
                        .updateDBOne(listTow);
                  } else {
                    await Provider.of<ApiService>(context, listen: false)
                        .updateDBOne(listTow);
                  }
                }
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
          ],
        ),
      )),
    );
  }
}
