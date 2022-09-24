import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: widget.title.split(" ")[0],
            style: GoogleFonts.coveredByYourGrace(
                color: Colors.black, fontSize: screenWidth / 18),
          ),
          TextSpan(
            text: " ",
            style: GoogleFonts.acme(
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: widget.title.split(" ")[1],
            style: GoogleFonts.openSans(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: screenWidth / 18),
          )
        ])),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.app), label: "About Us"),
      ],
      onTap: ((value) => log("${value}")),
      ),
    ));
  }
}
