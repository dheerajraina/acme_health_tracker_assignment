import 'dart:developer';

import 'package:acme_health_tracker_assignment/network/firebase_operations.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/controllers/tracker_widget_controller.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/home_page.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackerWidgetBuilder extends StatefulWidget {
  TrackerWidgetBuilder(
      {Key? key,
      required this.title,
      required this.index,
      this.intialValue = "0"});

  String title;
  int index;
  String intialValue;

  @override
  State<TrackerWidgetBuilder> createState() => _TrackerWidgetBuilderState();
}

class _TrackerWidgetBuilderState extends State<TrackerWidgetBuilder> {
  final TrackerWidgetController _trackerWidgetController =
      Get.put(TrackerWidgetController());

  final FirebaseOperations _firebaseOperations=new FirebaseOperations();


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return 
    // Obx((){return
     Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          child: ListTile(
            onTap: () {
              log("${widget.index}");
              Get.toNamed(
                "/allRecords/${widget.index}",
              );
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
                showDialog(
                    context: context,
                    builder: ((context) {
                      var value;
                      return SimpleDialog(
                        title: Text(
                          "Add New ${widget.title}",
                          style: GoogleFonts.nanumGothic(),
                        ),
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                onChanged: (val){
                                  value=val;
                                },
                                keyboardType: TextInputType.number,
                              )),
                          SizedBox(
                            height: 8,
                          ),
                          CupertinoButton(
                              color: Colors.grey.shade300,
                              child: Text("Add"),
                              onPressed: () {
                                var data ={
                                  "type":widget.index==0?"weight":widget.index==1?"blood_pressure":"exercise",
                                  "value":value,
                                  "createdOn":DateTime.now(),
                                };
                                widget.index==0?_trackerWidgetController.latestWeight.value=value:_trackerWidgetController.latestBP.value=value;
                               var response= _firebaseOperations.storeData(data);
                               log("Response = $response");
                               
                                _firebaseOperations.fetchData();
                                
                                 Navigator.pop(context);

                                
                                

                              }),
                          SizedBox(
                            height: 5,
                          ),
                          CupertinoButton(
                              color: Colors.grey.shade300,
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
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
            subtitle: widget.index == 0
                ? Text(" Kgs")
                : widget.index == 1
                    ? Text(" mmHh")
                    : Text(
                        " minutes"),
          ),
        ));
    // });
  }
}
