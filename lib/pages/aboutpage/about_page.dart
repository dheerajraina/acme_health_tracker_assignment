import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:  "This is an Activity Tracking Application\n",
                 style: GoogleFonts.lato(fontSize: MediaQuery.of(context).size.width/20,fontWeight: FontWeight.bold,color: Colors.black),
              ),
              TextSpan(
                text:"in its earlier stages of development" ,
                style: GoogleFonts.lato(fontSize: MediaQuery.of(context).size.width/20,fontWeight: FontWeight.bold,color: Colors.black),
              )
            ],
            
          
          )
          ),
        ),
    );
  }
}