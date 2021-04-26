import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/bloc/get_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_quotes_bloc.dart';
import 'package:quotes/elements/error.dart';
import 'package:quotes/elements/loading.dart';
import 'package:quotes/elements/quotes.dart';
import 'package:quotes/models/quote_hindi_response.dart';
import 'package:quotes/models/quotes_both.dart';
import 'package:quotes/models/quotes_both_response.dart';
import 'package:quotes/models/quotes_english.dart';
import 'package:quotes/models/quotes_english_response.dart';
import 'package:quotes/models/quotes_hindi.dart';
import 'package:quotes/screens/quote_screen.dart';
import 'package:quotes/style/theme.dart' as Style;
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  final String lang;
  CalendarScreen(this.lang);
  @override
  _CalendarScreenState createState() => _CalendarScreenState(lang);
}

class _CalendarScreenState extends State<CalendarScreen> {
  final String lang;

  _CalendarScreenState(this.lang);

  DateTime selectedDay;
  DateTime today;
  List selectedEvent;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  bool date = false;
  int quote;

  final Map<DateTime, List> events = {
    DateTime(2020,12,12): [
      {'Name': 'Your event Name', 'isDone' : true},
      {'Name': 'Your event Name 2', 'isDone' : true},
      {'Name': 'Your event Name 3', 'isDone' : false},
    ],
    DateTime(2020,12,2): [
      {'Name': 'Your event Name', 'isDone' : false},
      {'Name': 'Your event Name 2', 'isDone' : true},
      {'Name': 'Your event Name 3', 'isDone' : false},
    ]
  };

  void _handleData(date){
    quoteHindiBloc..drainStream();
    quoteEnglishBloc..drainStream();
    quoteBothBloc..drainStream();
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
    print(selectedDay);
  }

  @override
  void initState() {
    today = DateTime.now();
    // TODO: implement initState
    if(lang=="hi"){
      quoteHindiBloc..getQuotes(lang, "ThisYear");
    }
    else if(lang=="en"){
      quoteEnglishBloc..getQuotes(lang, "ThisYear");
    }
    else{
      quoteBothBloc..getQuotes(lang, "ThisYear");
    }
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
        centerTitle: true,
        backgroundColor: Style.Colors.secondColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height/2.42,
              child: Container(
                child: Calendar(
                  startOnMonday: true,
                  selectedColor: Style.Colors.secondColor,
                  todayColor: Colors.red,
                  eventColor: Colors.green,
                  eventDoneColor: Colors.amber,
                  bottomBarColor: Colors.deepOrange,
                  onRangeSelected: (range){
                    print('Selected Day ${range.from}, ${range.to}');
                  },
                  initialDate: today,
                  onDateSelected: (date){
                    setState(() {
                      today = date;
                    });
                    return _handleData(date);
                  },
                  events: events,
                  isExpanded: true,
                  dayOfWeekStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  bottomBarTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hideBottomBar: false,
                  isExpandable: true,
                  hideArrows: false,
                  weekDays: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
                ),
              ),
            ),
            // Text(today.toString()),
            SizedBox(height: 60,),
            Column(
              children: [
                if(lang=="hi")
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuoteHindiResponse>(
                        stream: quoteHindiBloc.subject.stream,
                        builder: (context,AsyncSnapshot<QuoteHindiResponse> snapshot){
                          if(snapshot.hasData){
                            // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                            //   return buildError(snapshot.data.error);
                            // }
                            if(_QuoteBoxHindi(snapshot.data)==null){
                              return Container(width: 50,height: 50,);
                            }
                            else{
                              return _QuoteBoxHindi(snapshot.data);
                            }
                          }
                          else if(snapshot.hasError){
                            return buildError(snapshot.error);
                          }
                          else{
                            return buildLoading();
                          }
                        }
                    ),
                  )
                else if(lang=="en")
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuoteEnglishResponse>(
                        stream: quoteEnglishBloc.subject.stream,
                        builder: (context,AsyncSnapshot<QuoteEnglishResponse> snapshot){
                          if(snapshot.hasData){
                            // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                            //   return buildError(snapshot.data.error);
                            // }
                            if(_QuoteBoxEnglish(snapshot.data)==null){
                              return Container(width: 50,height: 50,);
                            }
                            else{
                              return _QuoteBoxEnglish(snapshot.data);
                            }
                          }
                          else if(snapshot.hasError){
                            return buildError(snapshot.error);
                          }
                          else{
                            return buildLoading();
                          }
                        }
                    )
                  )
                else
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child:StreamBuilder<QuoteBothResponse>(
                        stream: quoteBothBloc.subject.stream,
                        builder: (context,AsyncSnapshot<QuoteBothResponse> snapshot){
                          if(snapshot.hasData){
                            // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                            //   return buildError(snapshot.data.error);
                            // }
                            if(_QuoteBoxBoth(snapshot.data)==null){
                              return Container(width: 50,height: 50,);
                            }
                            else{
                              return _QuoteBoxBoth(snapshot.data);
                            }
                          }
                          else if(snapshot.hasError){
                            return buildError(snapshot.error);
                          }
                          else{
                            return buildLoading();
                          }
                        }
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _QuoteBoxHindi(QuoteHindiResponse data) {
    List<QuotesHindi> quotes = data.quotes;
    if(quotes.length==0) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Quotes"),
          ],
        ),
      );
    }
    else{
      for(int i=0;i<quotes.length;i++){
        if((quotes[i].date).substring(0,10)==formatter.format(today)){
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[i].quote,"")));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(2,2),blurRadius: 1,spreadRadius: 2),
                    ]
                ),
                width: double.infinity,
                height: 160,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 20,
                      child: Container(
                        width: 250,
                        child: Text(
                          quotes[i].quote,
                          maxLines: 2,
                          style: TextStyle(
                            //color: primary,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Container(
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.share, color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.navigation2, color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.copy,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  FontAwesomeIcons.grin,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  FontAwesomeIcons.trophy,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        }
        else{
          // print(quotes[i].date);
          // print((formatter.format(today)).runtimeType);
          // Text("Not Found",style: TextStyle(fontSize: 20),);
          continue;
        }
      }
    }
  }
  Widget _QuoteBoxEnglish(QuoteEnglishResponse data) {
    List<QuotesEnglish> quotes = data.quotes;
    if(quotes.length==0) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Quotes"),
          ],
        ),
      );
    }
    else{
      for(int i=0;i<quotes.length;i++){
        if((quotes[i].date).substring(0,10)==formatter.format(today)){
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage("",quotes[i].quote)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(2,2),blurRadius: 1,spreadRadius: 2),
                    ]
                ),
                width: double.infinity,
                height: 160,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 20,
                      child: Container(
                        width: 250,
                        child: Text(
                          quotes[i].quote,
                          maxLines: 2,
                          style: TextStyle(
                            //color: primary,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Container(
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.share, color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.navigation2, color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.copy,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  FontAwesomeIcons.grin,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  FontAwesomeIcons.trophy,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

        }
        else{
          // print(quotes[i].date);
          // print((formatter.format(today)).runtimeType);
          // Text("Not Found",style: TextStyle(fontSize: 20),);
          continue;
        }
      }
    }
  }
  Widget _QuoteBoxBoth(QuoteBothResponse data){
    List<QuotesBoth> quotes = data.quotes;
    if(quotes.length==0) {
      return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Quotes"),
          ],
        ),
      );
    }
    else{
      for(int i=0;i<quotes.length;i++){
        if((quotes[i].date).substring(0,10)==formatter.format(today)){
          print(1);
          print(quotes[i].quoteEng);
          print(quotes[i].quoteHin);
          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[i].quoteHin,quotes[i].quoteEng)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(2,2),blurRadius: 1,spreadRadius: 2),
                    ]
                ),
                width: double.infinity,
                height: 210,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 20,
                      child: Container(
                        width: 250,
                        child: Text(
                          quotes[i].quoteHin,
                          maxLines: 2,
                          style: TextStyle(
                            //color: primary,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      child: Container(
                        width: 250,
                        child: Text(
                          quotes[i].quoteEng,
                          maxLines: 2,
                          style: TextStyle(
                            //color: primary,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Container(
                        child: InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.share, color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.navigation2, color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  EvaIcons.copy,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  FontAwesomeIcons.grin,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Icon(
                                  FontAwesomeIcons.trophy,color: Style.Colors.secondColor,
                                  size: 20,

                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        else{
          // print(quotes[i].date);
          // print((formatter.format(today)).runtimeType);
          // Text("Not Found",style: TextStyle(fontSize: 20),);
          continue;
        }
      }
    }
  }
}
