import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/bloc/get_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_quotes_bloc.dart';
import 'package:quotes/elements/quotes.dart';
import 'package:quotes/screens/search_screen.dart';
import 'package:quotes/style/theme.dart' as Style;
import 'package:quotes/widgets/calender.dart';
import 'package:quotes/widgets/genre_quotes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  int index = 0;
  String lang;
  TabController _controller;

  @override
  void initState() {
    lang = 'hi';
    _controller = TabController(length: quotesDay.length, vsync: this);
    print(lang);
    _controller.addListener(() {
      if(lang=="en" || _controller.indexIsChanging){
        quoteHindiBloc..drainStream();
        quoteBothBloc..drainStream();
      }
      else if(lang=="hi"){
        quoteEnglishBloc..drainStream();
        quoteBothBloc..drainStream();
      }
      else{
        quoteHindiBloc..drainStream();
        quoteEnglishBloc..drainStream();
      }
    });
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

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          title: Center(child: Text('Quotes',style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ))),
          leading: IconButton(icon: Icon(EvaIcons.calendar,color: Colors.white,), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CalendarScreen(lang)));
          }),
          actions: [
            Container(
              padding: EdgeInsets.only(left: 5,),
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Style.Colors.secondColor,width: 1,),
              ),
              child: Theme(
                data: ThemeData(
                  canvasColor: Style.Colors.secondColor,
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
                        lang = value.toString();
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: 'hi',
                        onTap: (){
                          quoteEnglishBloc..drainStream();
                          quoteBothBloc..drainStream();
                        },
                        child: Row(
                          children: [
                            Text(
                              "Hindi",
                              style: GoogleFonts.portLligatSans(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'en',
                        onTap: (){
                          quoteBothBloc..drainStream();
                          quoteHindiBloc..drainStream();
                        },
                        child: Row(
                          children: [
                            Text(
                              "English",
                              style: GoogleFonts.portLligatSans(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'both',
                        onTap: (){
                          quoteHindiBloc..drainStream();
                          quoteEnglishBloc..drainStream();
                        },
                        child: Row(
                          children: [
                            Text(
                              "Both",
                              style: GoogleFonts.portLligatSans(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
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
          ],
          backgroundColor: Style.Colors.secondColor,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Text(lang),
            Container(
              height: MediaQuery.of(context).size.height/1.22,
              child: DefaultTabController(
                length: quotesList.length,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: AppBar(
                      backgroundColor: Style.Colors.secondColor,
                      bottom: TabBar(
                        controller: _controller,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3,
                        unselectedLabelColor: Colors.white.withOpacity(0.7),
                        labelColor: Colors.white,
                        isScrollable: true,
                        tabs: quotesDay.map((item){
                          return Container(
                            padding: EdgeInsets.only(top: 10,bottom: 15,left: 15,right: 7),
                            child: Text(
                              item['title1'],
                              style: GoogleFonts.portLligatSans(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: quotesDay.map((item){
                      print(lang);
                      return GenreQuotes(lang: lang,genre: item["title"]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
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
                activeIcon: Icon(EvaIcons.home,color: Style.Colors.secondColor,),
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
