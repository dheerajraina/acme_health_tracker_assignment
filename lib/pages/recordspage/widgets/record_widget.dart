import 'dart:developer';

import 'package:acme_health_tracker_assignment/network/firebase_operations.dart';
import 'package:acme_health_tracker_assignment/pages/recordspage/records_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordWidget extends StatefulWidget {
  RecordWidget(
      {Key? key,
      required this.value,
      required this.createdOn,
      required this.trackerIndex,
      required this.index});
  int trackerIndex;
  String value;
  DateTime createdOn;
  int index;

  @override
  State<RecordWidget> createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget> {

  
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.height;
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          child: ListTile(
            onTap: () {
              log("${widget.trackerIndex},${widget.index}");
            },
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20, vertical: screenHeight / 50),
            title: Text(
              widget.value +
                  " ${widget.trackerIndex == 0 ? "Kgs" : widget.trackerIndex == 1 ? "mmHg" : "min"}",
              style: GoogleFonts.nanumGothic(),
            ),
            subtitle: Text("${widget.createdOn.toString().split(" ")[0]}"),
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        var value;
                        return SimpleDialog(
                          title: Text(
                            "Update Value",
                            style: GoogleFonts.nanumGothic(),
                          ),
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  controller: TextEditingController(text: widget.value),
                                  
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
                                child: Text("Update"),
                                onPressed: () {

                                  Get.find<RecordsPageController>().records[widget.trackerIndex][widget.index].value=value;
                                  Get.find<RecordsPageController>().records[widget.trackerIndex][widget.index].createdOn=DateTime.now();
                                  log("${Get.find<RecordsPageController>().records[widget.trackerIndex][widget.index].createdOn}");
                                  var id =Get.find<RecordsPageController>().records[widget.trackerIndex][widget.index].id;

                                  var data={
                                    'value':value,
                                    'createdOn':DateTime.now(),
                                  };
                                  FirebaseOperations().update(id , data);
                                 
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
                icon: Icon(Icons.edit)),
          ),
        ));
  }
}
