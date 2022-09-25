import 'dart:developer';

import 'package:acme_health_tracker_assignment/homepage/controllers/tracker_widget_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackerWidgetBuilder extends StatefulWidget {
  TrackerWidgetBuilder({Key? key, required this.title,required this.index});

  String title;
  int index;
  

  @override
  State<TrackerWidgetBuilder> createState() => _TrackerWidgetBuilderState();
}

class _TrackerWidgetBuilderState extends State<TrackerWidgetBuilder> {

  
  
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;


    

    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        
        child: Container(
          child: ListTile(
            onTap: (){
              log("${widget.index}");

            },
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20, vertical: screenHeight / 50),
            title: Text(widget.title,style: GoogleFonts.nanumGothic(),),
            trailing:InkWell(
              onTap: (){
                log("Add ${widget.index}");
              },
              child: Container(
                child: Center(child: Text("Add")),
                width: screenWidth/6,
                height: screenHeight/25,
                decoration: BoxDecoration(
                  
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1,)
            
              )),
            ) ,
          ),
        ));
  }
}
