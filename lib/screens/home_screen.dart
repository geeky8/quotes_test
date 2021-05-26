import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/elements/quotes.dart';
import 'package:quotes/main.dart';
import 'package:quotes/screens/contact_screen.dart';
import 'package:quotes/screens/search_screen.dart';
import 'package:quotes/style/theme.dart' as Style;
import 'package:quotes/widgets/calender.dart';
import 'package:quotes/widgets/genre_quotes.dart';
import 'package:quotes/screens/about_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  TabController _controller;


  @override
  void initState() {
    setState(() {
      validate = false;
    });
    _controller = TabController(length: quotesDay.length, vsync: this,initialIndex: ind);
    setQuote();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    exit();
    super.dispose();
  }

  Future<void> exit() async{
    await SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      height = MediaQuery.of(context).size.height;
      width =  MediaQuery.of(context).size.width;
    });
    return InteractiveViewer(
      child: Stack(
        children: [
          Container(
            height: height,
            child: Scaffold(
              backgroundColor: Color(0xFFF3EFDE),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(0.1086*height),
                child: AppBar(
                  title: Padding(padding:EdgeInsets.only(top: 0.018 * height, left: 0.10 * width),child: Image(image: AssetImage('images/vikasrunwalquotes.png'),)),
                  leading: Padding(
                    padding: EdgeInsets.only(top: 0.010*height),
                    child: IconButton(icon: Icon(FontAwesomeIcons.calendarAlt,color: Colors.white,),iconSize: 0.083*width, onPressed: (){
                      setState(() {
                        genre = 'YearQuote';
                        cal = 1;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarScreen()));
                    }),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(top: 0.010*height),
                      child: Container(
                        padding: EdgeInsets.only(left: 0.0138*width,),
                        height: 0.040*height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Style.Colors.primary,width: 1,),
                        ),
                        child: Theme(
                          data: ThemeData(
                            canvasColor: Style.Colors.secondary,
                          ),
                          child: DropdownButton(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              isExpanded: false,
                              underline: Container(
                              ),
                              value: lang,
                              onChanged: (value){
                                setState(() {
                                  lang = value;
                                });
                                setQuote();
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'hi',
                                  child: Row(
                                    children: [
                                      Text(
                                        "Hindi",
                                        style: GoogleFonts.portLligatSans(
                                          textStyle: Theme.of(context).textTheme.display1,
                                          fontSize:0.038*width,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'en',
                                  child: Row(
                                    children: [
                                      Text(
                                        "English",
                                        style: GoogleFonts.portLligatSans(
                                          textStyle: Theme.of(context).textTheme.display1,
                                          fontSize: 0.038*width,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'both',
                                  child: Row(
                                    children: [
                                      Text(
                                          "Both",
                                          style: GoogleFonts.portLligatSans(
                                            textStyle: Theme.of(context).textTheme.display1,
                                            fontSize: 0.038*width,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          )
                                      ),
                                    ],
                                  ),
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: Style.Colors.primary,
                  elevation: 0.0067*height,
                ),
              ),
              body: InteractiveViewer(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height/1.293,
                        child: DefaultTabController(
                          length: quotesDay.length,
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            appBar: PreferredSize(
                              preferredSize: Size.fromHeight(0.067*height),
                              child: AppBar(
                                backgroundColor: Style.Colors.secondary,
                                elevation: 0,
                                bottom: TabBar(
                                  controller: _controller,
                                  indicatorColor: Color(0xff9D8A53),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorWeight: 3,
                                  unselectedLabelColor: Colors.white,
                                  labelColor: Color(0xff9D8A53),
                                  isScrollable: true,
                                  tabs: quotesDay.map((item){
                                    return Container(
                                      padding: EdgeInsets.only(top: 0.0135*height,bottom: 0.020*height,left: 0.0416*width,right: 0.0194*width),
                                      child: Text(
                                        item['title1'],
                                        style: TextStyle(
                                          fontSize: 0.038*width,
                                          // color: Colors.white,
                                          fontFamily: "Lexend",
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onTap: (int){
                                    setState(() {
                                      genre = quotesDay[int]["title"];
                                      ind = int;
                                    });
                                    setQuote();
                                  },
                                ),
                              ),
                            ),
                            body: TabBarView(
                              controller: _controller,
                              physics: NeverScrollableScrollPhysics(),
                              children: quotesDay.map((item){
                                  return Padding(
                                    padding: EdgeInsets.only(top: 0.0054*height),
                                    child: GenreQuotes(),
                                  );
                              }).toList(),
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
      ),
    );
  }

}


