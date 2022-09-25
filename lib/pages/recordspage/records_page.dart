import 'dart:async';
import 'dart:developer';

import 'package:acme_health_tracker_assignment/network/firebase_operations.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page_controller.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/widgets/record_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordsPage extends StatefulWidget {
   RecordsPage({Key? key,required this.indexClicked});

  int indexClicked=0;

  final RecordsPageController _recordsPageController=Get.put(RecordsPageController());

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {

 
  final RecordsPageController _recordsPageController =Get.put(RecordsPageController());
   
   StreamController<List<dynamic>>? _streamController=new StreamController();

  @override
  void initState() {
    // TODO: implement initState
    _streamController=StreamController();
     super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
     var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    log("---- Data  =  ${_recordsPageController.weightRecords.value},index= ${widget.indexClicked}");
    var records=widget.indexClicked==0
                ?_recordsPageController.weightRecords.value
                :widget.indexClicked==1
                ?_recordsPageController.bloodPressureRecords.value
                :_recordsPageController.exerciseRecords.value;

    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Container(
        child:Builder(builder: (context){
          return records.length>0 
            ? ListView.builder(
              itemCount: records.length,
              itemBuilder: (context,index){
              return RecordWidget(value:records[index].value, createdOn: records[index].createdOn, index: widget.indexClicked);
            })
            :Center(child: Container(
              child: Text(
                "No Records Available",
                style: GoogleFonts.nanumGothic(fontSize: screenWidth/20,fontWeight: FontWeight.bold,),
                ),));

        }),
        )

        
    );
  }
}