import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:quotes/main.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/login_screen.dart';
import 'package:quotes/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  String name = "";
  String title = "";

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),getData);
  }
  display() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString("user")!=null){
      setState(() {
        title = "Welcome \n Back";
      });
    }
    else{
      setState(() {
        title = "Welcome";
      });
      print("NO");
    }
  }

  getData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString("user")!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image(
              image: AssetImage("images/Welcome-Screen-option2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [Color(0xfffbb448), Color(0xffe46b10)])
          //   ),
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     Expanded(
          //       flex: 2,
          //       child: Container(
          //         child: Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             CircleAvatar(
          //               backgroundColor: Colors.white,
          //               radius: 70.0,
          //               child: Image(
          //                 image: AssetImage("images/saidattavikas-foundation.png"),
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(top: 10.0),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Column(
          //         children: <Widget>[
          //           Text(
          //             title,
          //             softWrap: true,
          //             textAlign: TextAlign.center,
          //             style: GoogleFonts.portLligatSans(
          //               textStyle: Theme.of(context).textTheme.display1,
          //               fontSize: 30,
          //               fontWeight: FontWeight.w700,
          //               color: Colors.white,
          //             ),
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}