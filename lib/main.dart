import 'dart:developer';

import 'package:acme_health_tracker_assignment/basewidget/base_widget.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/home_page.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import'package:firebase_analytics/firebase_analytics.dart';



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

     FirebaseAnalytics analytics=FirebaseAnalytics.instance;
     FirebaseAnalyticsObserver observer=FirebaseAnalyticsObserver(analytics: analytics);

     analytics.setUserId(id: 'QwkJSRRjFu9PWncnQxhb');
     

    return GetMaterialApp(
      navigatorObservers:<NavigatorObserver> [observer],
      
      getPages: [
        GetPage(title:"RecordsPage",name: '/allRecords/:index', page: (() => RecordsPage(indexClicked:int.parse(Get.parameters['index'].toString())))),
        GetPage(title:"HomePage",name: '/', page: (() => HomePage())),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BaseWidget(title: 'ACME Health',observer: observer,analytics: analytics,),
    );
  }
}
