import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quotes/style/theme.dart' as Style;

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
    display();
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
      setState(() {
        title = "Welcome \n Back";
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    else{
      setState(() {
        title = "Welcome";
      });
      print("NO");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 55.0,
                        child: Image(
                          image: NetworkImage("https://image.flaticon.com/icons/png/128/84/84081.png"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Quotes",
                        style: GoogleFonts.portLligatSans(
                          textStyle: Theme.of(context).textTheme.display1,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      title,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}