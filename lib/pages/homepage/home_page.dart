import 'dart:developer';

import 'package:acme_health_tracker_assignment/models/health_data_model.dart';
import 'package:acme_health_tracker_assignment/network/firebase_operations.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/controllers/tracker_widget_controller.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/widgets/tracker_widget.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page_controller.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
   
    
  }) ;



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TrackerWidgetController _trackerWidgetController =Get.put(TrackerWidgetController());

   FirebaseOperations _firebaseOperations =FirebaseOperations();
   RecordsPageController recordsPageController=Get.put(RecordsPageController());
   
  
  @override
  void initState() {
    // TODO: implement initState
    _firebaseOperations=FirebaseOperations();

    _firebaseOperations.fetchData();
    super.initState();
  } 
  

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
   
    
    
    
    return SafeArea(
        child: Scaffold(
      body:Obx((){
        

        return ListView.builder(
        
        itemCount: _trackerWidgetController.trackers.length,
        itemBuilder: (context,index){
          log("index");

          return TrackerWidgetBuilder(title: _trackerWidgetController.trackers[index], index: index,intialValue:index==0? _trackerWidgetController.latestWeight.value:index==1? _trackerWidgetController.latestBP.value:_trackerWidgetController.latestExercise.value ,);
        });
      }),
    ));
  }
}
