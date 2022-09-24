import 'package:acme_health_tracker_assignment/homepage/home_page.dart';
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
      home: const HomePage(title: 'ACME Health'),
    );
  }
}

