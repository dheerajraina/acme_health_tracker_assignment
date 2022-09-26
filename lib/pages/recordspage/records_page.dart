import 'dart:async';
import 'dart:developer';

import 'package:acme_health_tracker_assignment/network/firebase_operations.dart';
import 'package:acme_health_tracker_assignment/pages/homepage/controllers/tracker_widget_controller.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page_controller.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/widgets/record_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordsPage extends StatefulWidget {
  RecordsPage({
    Key? key,
    required this.indexClicked,
  });

  int indexClicked = 0;

  final RecordsPageController _recordsPageController =
      Get.put(RecordsPageController());

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  final RecordsPageController _recordsPageController =
      Get.put(RecordsPageController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseOperations()
        .analytics
        .setCurrentScreen(screenName: "Records Page => ${widget.indexClicked}");
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    log("---- Data  =  ${_recordsPageController.records[widget.indexClicked]},index= ${widget.indexClicked}");
    // var records = widget.indexClicked == 0
    //     ? _recordsPageController.weightRecords.value
    //     : widget.indexClicked == 1
    //         ? _recordsPageController.bloodPressureRecords.value
    //         : _recordsPageController.exerciseRecords.value;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "${widget.indexClicked == 0 ? "Weight" : widget.indexClicked == 1 ? "Blood Pressure" : "Exercise"}",
            style: GoogleFonts.lato(),
          ),
          actions: [
            InkWell(
              onTap: () {
                log("Add ${widget.indexClicked}");
                showDialog(
                    context: context,
                    builder: ((context) {
                      var value;
                      return SimpleDialog(
                        title: Text(
                          "Add New ${Get.find<TrackerWidgetController>().trackers[widget.indexClicked]}",
                          style: GoogleFonts.nanumGothic(),
                        ),
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                onChanged: (val) {
                                  value = val;
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
                                var data = {
                                  "type": widget.indexClicked == 0
                                      ? "weight"
                                      : widget.indexClicked == 1
                                          ? "blood_pressure"
                                          : "exercise",
                                  "value": value,
                                  "createdOn": DateTime.now(),
                                };
                                // widget.indexClicked == 0
                                //     ? Get.find<TrackerWidgetController>()
                                //         .latestWeight
                                //         .value = value
                                //     : Get.find<TrackerWidgetController>()
                                //         .latestBP
                                //         .value = value;
                                var response =
                                    FirebaseOperations().storeData(data);
                                log("Response = $response");

                                FirebaseOperations().fetchData();

                                Future.delayed(Duration(seconds: 2), () {
                                  setState(() {});
                                  Navigator.pop(context);
                                });
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
              child: Padding(
                padding: EdgeInsets.only(right: screenWidth / 20),
                child: Center(child: Text("Add")),
              ),
            )
          ],
        ),
        body: Container(
          child: Builder(builder: (context) {
            return _recordsPageController
                    .records[widget.indexClicked].isNotEmpty
                ? ListView.builder(
                    itemCount: _recordsPageController
                        .records[widget.indexClicked].length,
                    itemBuilder: (context, index) {
                      var records =
                          _recordsPageController.records[widget.indexClicked];
                      return RecordWidget(
                        value: records[index].value,
                        createdOn: records[index].createdOn,
                        trackerIndex: widget.indexClicked,
                        index: index,
                      );
                    })
                : Center(
                    child: Container(
                    child: Text(
                      "No Records Available",
                      style: GoogleFonts.nanumGothic(
                        fontSize: screenWidth / 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ));
          }),
        ));
  }
}
