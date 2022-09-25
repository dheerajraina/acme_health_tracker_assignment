import 'dart:developer';
import 'package:acme_health_tracker_assignment/homepage/controllers/tracker_widget_controller.dart';
import 'package:acme_health_tracker_assignment/homepage/widgets/tracker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TrackerWidgetController _trackerWidgetController =Get.put(TrackerWidgetController());

  @override
  void dispose() {
    _trackerWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body:ListView.builder(
        itemCount: _trackerWidgetController.trackers.length,
        itemBuilder: (context,index){
          return TrackerWidgetBuilder(title: _trackerWidgetController.trackers[index], index: index);
        })
    ));
  }
}
