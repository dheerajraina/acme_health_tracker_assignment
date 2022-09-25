import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class RecordWidget extends StatefulWidget {
  RecordWidget({Key? key,required this.value,required this.createdOn,required this.index}) ;
  int index;
  String value;
  DateTime createdOn;
 

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
              log("${widget.index}");
              
            },
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenWidth / 20, vertical: screenHeight / 50),
            title: Text(
              widget.value+" ${widget.index==0?"Kgs":widget.index==1?"mmHg":"min"}",
              style: GoogleFonts.nanumGothic(),
            ),
           
          ),
        ));
  }
}