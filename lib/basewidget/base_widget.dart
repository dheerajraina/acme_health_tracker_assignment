import 'dart:developer';

import 'package:acme_health_tracker_assignment/pages/aboutpage/about_page.dart';
import 'package:acme_health_tracker_assignment/basewidget/base_widget_controller.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/home_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseWidget extends StatefulWidget {
   BaseWidget({Key? key, required this.title,required this.analytics,required this.observer}) ;

  final String title;
   final FirebaseAnalytics analytics;
   final FirebaseAnalyticsObserver observer;



  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  BaseWidgetController _baseWidgetController = Get.put(BaseWidgetController());


  

  @override
  void dispose() {
    // TODO: implement dispose
    _baseWidgetController.dispose();
    super.dispose();
  }

  static const  List<Widget>_pages=[HomePage(),AboutPage()];

  @override
  Widget build(BuildContext context) {

    widget.analytics.setCurrentScreen(screenName: "Home Page");

    
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: widget.title.split(" ")[0],
            style: GoogleFonts.coveredByYourGrace(
                color: Colors.black, fontSize: screenWidth / 18),
          ),
          TextSpan(
            text: " ",
            style: GoogleFonts.acme(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: widget.title.split(" ")[1],
            style: GoogleFonts.openSans(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth / 18),
          )
        ])),
      ),
      body: Obx((){
        return _pages.elementAt(_baseWidgetController.currentIndex.value);
      }),
      bottomNavigationBar:Obx((){
        return  BottomNavigationBar(
        currentIndex: _baseWidgetController.currentIndex.value,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.app), label: "About Us"),
        ],
        onTap: ((value) {
          log("${value}");

          widget.analytics.logEvent(name: "Bottom Nav Clicked $value");

          _baseWidgetController.currentIndex.value=value;


        } ),
      );
      }),
    ));
  }
}
