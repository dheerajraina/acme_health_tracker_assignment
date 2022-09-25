import 'dart:developer';



import 'package:acme_health_tracker_assignment/basewidget/base_widget.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const ACMEHealth());
}

class ACMEHealth extends StatelessWidget {
  const ACMEHealth({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
       ),
      home: const BaseWidget(title: 'ACME Health'),
      
    );
  }
}




