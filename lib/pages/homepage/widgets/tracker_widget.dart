import 'dart:developer';

import 'package:acme_health_tracker_assignment/pages/homepage/controllers/tracker_widget_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackerWidgetBuilder extends StatefulWidget {
  TrackerWidgetBuilder({Key? key, required this.title, required this.index,this.intialValue=0});

  String title;
  int index;
  int intialValue ;

  @override
  State<TrackerWidgetBuilder> createState() => _TrackerWidgetBuilderState();
}

class _TrackerWidgetBuilderState extends State<TrackerWidgetBuilder> {


final TrackerWidgetController _trackerWidgetController=Get.put(TrackerWidgetController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          child: ListTile(
            onTap: () {
              log("${widget.index}");
              Get.toNamed("/allRecords/${widget.index}",);
            },
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20, vertical: screenHeight / 50),
            title: Text(
              widget.title,
              style: GoogleFonts.nanumGothic(),
            ),
            trailing: InkWell(
              onTap: () {
                log("Add ${widget.index}");
                showDialog(context: context, builder: ((context) {
                  return SimpleDialog(
                    
                    title: Text(
                      "Add New ${widget.title}",
                      style: GoogleFonts.nanumGothic(),
                      ),
                      children: [
                        Container(

                          margin: EdgeInsets.only(left: 10,right: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                          )),
                          SizedBox(height: 8,),
                          CupertinoButton(color: Colors.grey.shade300,child: Text("Add"), onPressed: (){

                          }),
                          SizedBox(height: 5,),
                          CupertinoButton(color: Colors.grey.shade300,child: Text("Cancel"), onPressed: (){Navigator.pop(context);}),
                          
                      ],
                      );

                }));
              },
              child: Container(
                  child: Center(child: Text("Add")),
                  width: screenWidth / 6,
                  height: screenHeight / 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 1,
                      ))),
            ),
            subtitle: widget.index==0
                      ?Text("${_trackerWidgetController.latestWeight.value} Kgs")
                      :widget.index==1
                      ?Text("${_trackerWidgetController.latestBP.value} mmHh")
                      :Text("${_trackerWidgetController.latestExercise.value} min"),
          ),
        ));
  }
}
