import 'package:animator/animator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/elements/quotes.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/search_screen.dart';
import 'package:quotes/style/theme.dart' as Style;

class QuotesOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/quotes/quotes1.dart";
  final String quoteHin;
  final String quoteEn;

  QuotesOnePage(this.quoteHin,this.quoteEn);

  @override
  _QuotesOnePageState createState() => _QuotesOnePageState(quoteHin,quoteEn);
}

class _QuotesOnePageState extends State<QuotesOnePage> with SingleTickerProviderStateMixin{
  final String quoteHin;
  final String quoteEn;
  _QuotesOnePageState(this.quoteHin,this.quoteEn);
  TabController _controller;
  int index = 0;

  @override
  void initState() {
    _controller = TabController(length: quotesDay.length, vsync: this);
    _controller.addListener(() {
      if(_controller.indexIsChanging){
        print("drain");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Text('Quotes',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
          backgroundColor: Style.Colors.secondColor,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,bottom: 20,top: 20),
          child: Container(
            padding: const EdgeInsets.all(32.0),
            width: MediaQuery.of(context).size.width,
            height: 520,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    image:NetworkImage('https://www.krishna-images.com/wp-content/uploads/2020/01/Sai-Baba-Images-HD-Wallpapers.jpg')
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [
                      0.1,
                      0.9
                    ],
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.white.withOpacity(0.3),
                    ]
                )
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            FontAwesomeIcons.quoteLeft,
                            size: 20.0,
                            color: Colors.white,
                          )),
                      Animator(
                        triggerOnInit: true,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 500),
                        tween: Tween<double>(begin: -1, end: 0),
                        builder: (context, state, child) {
                          return FractionalTranslation(
                              translation: Offset(state.value, 0), child: child);
                        },
                        child: Text(
                          quoteHin,
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            FontAwesomeIcons.quoteLeft,
                            size: 20.0,
                            color: Colors.white,
                          )),
                      Animator(
                        triggerOnInit: true,
                        curve: Curves.easeIn,
                        duration: Duration(milliseconds: 500),
                        tween: Tween<double>(begin: -1, end: 0),
                        builder: (context, state, child) {
                          return FractionalTranslation(
                              translation: Offset(state.value, 0), child: child);
                        },
                        child: Text(
                          quoteEn,
                          style: GoogleFonts.portLligatSans(
                            textStyle: Theme.of(context).textTheme.display1,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),),
          boxShadow: [
            BoxShadow(color: Colors.grey[100],spreadRadius: 0,blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            iconSize: 20,
            unselectedItemColor: Colors.grey[400],
            selectedFontSize: 9.5,
            unselectedFontSize: 9.5,
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (value){},
            items: [
              BottomNavigationBarItem(
                title: Padding(
                  padding: EdgeInsets.only(top: 5,),
                  child: Text('Home',style: TextStyle(color: Style.Colors.secondColor,),),
                ),
                icon: Icon(EvaIcons.homeOutline),
                activeIcon: GestureDetector(onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));},child: Icon(EvaIcons.home,color: Style.Colors.secondColor,)),
              ),
              BottomNavigationBarItem(
                title: Padding(
                  padding: EdgeInsets.only(top: 5,),
                  child: Text('Sources'),
                ),
                icon: Icon(EvaIcons.gridOutline,),
                activeIcon: Icon(EvaIcons.grid,color: Style.Colors.secondColor,),
              ),
              BottomNavigationBarItem(
                title: Padding(
                  padding: EdgeInsets.only(top: 5,),
                  child: Text('Search'),
                ),
                icon: GestureDetector(
                  child: Icon(EvaIcons.searchOutline),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                  },
                ),
                activeIcon: Icon(EvaIcons.search,color: Style.Colors.secondColor,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
