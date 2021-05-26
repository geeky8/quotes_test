import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/screens/contact_screen.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/search_screen.dart';
import 'package:quotes/style/theme.dart' as Style;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}


class _AboutState extends State<About> {

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


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height/1.084,
          child: Scaffold(
            backgroundColor: Color(0xFFF3EFDE),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(0.1086*height),
                child: AppBar(
                  title: Padding(padding:EdgeInsets.only(left:0.100*width,top: 0.018*height,),child: Image(image: AssetImage('images/vikasrunwalquotes.png'),)),
                  backgroundColor: Style.Colors.primary,
                  elevation: 0.0067*height,
                  leading: Padding(
                    padding: EdgeInsets.only(top: 0.0235*height,),
                    child: IconButton(
                      icon: Icon(EvaIcons.arrowBack),
                      onPressed: (){
                        setState(() {
                          genre = "TodaysQuote";
                          ind = 0;
                        });
                        setQuote();
                        Navigator.of(context).pop(true);
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      }
                    ),
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
                        padding: EdgeInsets.only(top: 0.0203*height,bottom: 0.0203*height,right: 0.0277*width,left: 0.0555*width),
                        child: Text("Sai Datta Vikas Foundation",style: GoogleFonts.libreBaskerville(fontSize: 0.0555*width,fontWeight:FontWeight.w500,color: Style.Colors.primary),),
                      ),
                      SizedBox(height: 0.0108*height,),
                      Container(
                        width: width,
                        height: height/3,
                        child: Image(image: AssetImage("images/foundation-page-photo.jpg"),fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 0.0067*height,),
                      Padding(
                        padding: EdgeInsets.all(0.0444*width),
                        child: Column(
                          children: [
                            Container(
                              child: Image(image: AssetImage("images/saidattavikas-foundation.png"),fit: BoxFit.cover,),
                            ),
                            SizedBox(height: 0.0408*height,),
                            Text(
                              "Sai Datta Vikas Meditation & Charitable Trust provides necessities to the needy. We also distribute authentic herbal medication from Kavita's Liniment and Kavita's Balm among patients. We persevere to spread Baba's vision of peace and humanity to all with utmost love and dedication. With the guidance of Sai Baba we consult and guide all the problems & healing for patients. Our aim is to spread the grace of Saibaba to one and all by spreading peace and love. Our mission is to reach humanity and help the ailing and needy people. The divine eyes of Sai Baba are beckoning us to unite ourselves to carry this work of dedication & perseverance so as to forward and fulfil Baba's vision of peace to mankind.\n\nEvery action and feeling is preceeded by our thoughts. Quotes and thoughts can change our lives, health, wealth and faith. One small positive thought in the morning can change our whole day. We can read motivational quotes but until we embody them and put them into action, they are nothing but words.\n\nThe purpose of this app is to make it easy for us to apply these thoughts into action. If we try to apply these thoughts at-least for 2 hours daily, it will work as an endeavor towards self-transformation. It can change us from human-being to being human.",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Lexend",
                                fontWeight: FontWeight.w500,
                                fontSize: 0.0444*width,
                                color: Style.Colors.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height: 10,),
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
