import 'dart:developer';

import 'package:acme_health_tracker_assignment/basewidget/base_widget.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';



Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ACMEHealth());
}

class ACMEHealth extends StatelessWidget {
  const ACMEHealth({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/allRecords/:index', page: (() => RecordsPage(indexClicked:int.parse(Get.parameters['index'].toString())))),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const BaseWidget(title: 'ACME Health'),
    );
  }
}
