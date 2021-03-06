import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';
import 'package:quotes/screens/about_screen.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/search_screen.dart';
import 'package:quotes/style/theme.dart' as Style;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  Future<bool> _onwillPop() {
    setState(() {
      genre = "TodaysQuote";
      ind = 0;
    });
    setQuote();
    Navigator.of(context).pop(true);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  launchMailto() async {
    final mailtoLink = Mailto(
      to: ['to@example.com'],
    );
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.084,
          child: Scaffold(
            backgroundColor: Color(0xFFF3EFDE),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0.1086 * height),
              child: AppBar(
                title: Padding(
                    padding: EdgeInsets.only(
                      left: 0.100 * width,
                      top: 0.018 * height,
                    ),
                    child: Image(
                      image: AssetImage('images/vikasrunwalquotes.png'),
                    )),
                backgroundColor: Style.Colors.primary,
                elevation: 0.0067*height,
                leading: Padding(
                  padding: EdgeInsets.only(
                    top: 0.0235 * height,
                  ),
                  child: IconButton(
                      icon: Icon(EvaIcons.arrowBack),
                      onPressed: () {
                        setState(() {
                          genre = "TodaysQuote";
                          ind = 0;
                        });
                        setQuote();
                        Navigator.of(context).pop(true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }),
                ),
              ),
            ),
            body: InteractiveViewer(
              child: WillPopScope(
                onWillPop: _onwillPop,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 0.0203*height, bottom: 0.0163*height, right: 0.0277*width, left: 0.0277*width),
                        child: Text(
                          "Contact Us",
                          style: GoogleFonts.libreBaskerville(
                              fontSize: 0.0555*width,
                              fontWeight: FontWeight.w500,
                              color: Style.Colors.primary),
                        ),
                      ),
                      SizedBox(
                        height: 0.0108 * height,
                      ),
                      Container(
                        width: width,
                        height: height / 3,
                        child: Image(
                          image: AssetImage("images/contact-page-photo.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 0.0067 * height,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Image(
                              image: AssetImage(
                                  "images/saidattavikas-foundation.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 0.0408 * height,
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Color(0xffFBF8E9),
                            ),
                              child: Text(
                            "Sai Datta Vikas Meditation & \nCharitable Trust",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.libreBaskerville(
                                fontSize: 0.04722*width,
                                fontWeight: FontWeight.w500,
                                color: Style.Colors.primary),
                          )),
                        ],
                      ),
                      SizedBox(height: 0.0339*height,),
                      Column(
                        children: [
                          Text("Address",style: TextStyle(fontFamily: "Lexend",fontSize: 0.044*width,fontWeight: FontWeight.bold),),
                          SizedBox(height: 0.0135*height,),
                          Text("410/1, Lane No. 5B, South Main Road,\nNext to Iris Hotel, Koregoan Park,\nPune 411001",textAlign:TextAlign.center,style: TextStyle(fontFamily: "Lexend",fontSize: 14,fontWeight: FontWeight.w400),),
                          SizedBox(height: 0.0203*height,),
                          Container(width: width,height: 0.0020*height,decoration: BoxDecoration(color: Colors.black26),),
                        ],
                      ),
                      SizedBox(height: 0.0339*height,),
                      Column(
                        children: [
                          Text("Email",style: TextStyle(fontFamily: "Lexend",fontSize: 0.044*width,fontWeight: FontWeight.bold),),
                          SizedBox(height: 0.0135*height,),
                          InkWell(
                              child: Text(
                                "Saidattavikas@hotmail.com",
                                style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 0.0434 * width,
                                  color: Style.Colors.primary,
                                ),
                              ),
                              onTap: () {
                                launchMailto();
                              }),
                          SizedBox(height: 0.0203*height,),
                          Container(width: width,height: 0.0020*height,decoration: BoxDecoration(color: Colors.black26),),
                        ],
                      ),
                      SizedBox(height: 0.0339*height,),
                      Column(
                        children: [
                          Text("Call",style: TextStyle(fontFamily: "Lexend",fontSize: 0.0444*width,fontWeight: FontWeight.bold),),
                          SizedBox(height: 0.0203*height,),
                          InkWell(
                              child: Text(
                                "+91 9823020329",
                                style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 0.0434 * width,
                                  color: Style.Colors.primary,
                                ),
                              ),
                              onTap: () async{
                                await launch("tel://9823020329");
                              }),
                          SizedBox(height: 0.0040*height,),
                          InkWell(
                              child: Text(
                                "+91 9890000707",
                                style: TextStyle(
                                  fontFamily: "Lexend",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 0.0434 * width,
                                  color: Style.Colors.primary,
                                ),
                              ),
                              onTap: () async{
                                await launch("tel://9890000707");
                              }),
                          SizedBox(height: 0.0203*height,),
                          Container(width: width,height: 0.0020*height,decoration: BoxDecoration(color: Colors.black26),),
                        ],
                      ),
                      SizedBox(height: 0.0339*height,),
                      Column(
                        children: [
                          Text("Follow Us",style: TextStyle(fontFamily: "Lexend",fontSize: 0.044*width,fontWeight: FontWeight.bold),),
                          SizedBox(height: 0.0271*height,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  child: Image(image: AssetImage("images/facebook-icon.png"),),
                                  onTap: () async{
                                    await launch("https://www.facebook.com/");
                                  }),
                              SizedBox(width: 0.0083*width,),
                              InkWell(
                                  child: Image(image: AssetImage("images/instagram-icon.png"),),
                                  onTap: () async{
                                    await launch("https://www.instagram.com/");
                                  }),
                            ],
                          ),
                          SizedBox(height: 0.0203*height,),
                          Container(width: width,height: 0.0020*height,decoration: BoxDecoration(color: Colors.black26),),
                        ],
                      ),
                      SizedBox(height: 0.0135*height,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Material(
            child: Container(
              width: width,
              height: 0.074*height,
              decoration: BoxDecoration(
                color: Style.Colors.secondary,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0067*height),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0.02166*width),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                        },
                        child: Row(
                          children: [
                            Image(image: AssetImage("images/about-icon.png"),width: 0.0694*width,),
                            SizedBox(width: 0.0085*width,),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0027*height),
                              child: Text("ABOUT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 0.0295*width),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.01266*width),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Contact()));
                        },
                        child: Row(
                          children: [
                            Image(image: AssetImage("images/call-icon.png"),width: 0.0684*width,),
                            SizedBox(width: 0.0085*width,),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0027*height),
                              child: Text("CONTACT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 0.0295*width),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            genre = "TodaysQuote";
                            ind = 0;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },
                        child: Row(
                          children: [
                            Icon(Icons.home,color: Colors.white,size: 0.0684*width,),
                            SizedBox(width: 0.0085*width,),
                            Padding(
                              padding: EdgeInsets.only(top: 0.0027*height),
                              child: Text("HOME",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 0.0295*width)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 0.02166*width),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            genre = "KeywordQuote";
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 0.0222*width),
                          child: Row(
                            children: [
                              Icon(EvaIcons.search,color: Colors.white,size: 0.0684*width,),
                              SizedBox(width: 0.0085*width,),
                              Padding(
                                padding: EdgeInsets.only(top: 0.0027*height),
                                child: Text("SEARCH",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize:  0.0295*width),),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
