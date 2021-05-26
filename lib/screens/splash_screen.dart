import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quotes/main.dart';
import 'package:quotes/screens/home_screen.dart';
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
        ],
      ),
    );
  }
}