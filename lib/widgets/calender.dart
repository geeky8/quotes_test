import 'dart:math';

import 'package:clipboard/clipboard.dart';
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
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/quote_screen.dart';
import 'package:quotes/style/theme.dart' as Style;
import 'package:share/share.dart';

import '../main.dart';

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
  int quote;

  final Map<DateTime, List> events = {
    DateTime(2020, 12, 12): [
      {'Name': 'Your event Name', 'isDone': true},
      {'Name': 'Your event Name 2', 'isDone': true},
      {'Name': 'Your event Name 3', 'isDone': false},
    ],
    DateTime(2020, 12, 2): [
      {'Name': 'Your event Name', 'isDone': false},
      {'Name': 'Your event Name 2', 'isDone': true},
      {'Name': 'Your event Name 3', 'isDone': false},
    ]
  };

  void _handleData(date) {
    quoteHindiBloc..drainStream();
    quoteEnglishBloc..drainStream();
    quoteBothBloc..drainStream();
    setState(() {
      selectedDay = date;
      selectedEvent = events[selectedDay] ?? [];
    });
  }

  void share(BuildContext context, String text) {
    // final RenderBox box = context.findRenderObject();
    Share.share(text, sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0));
  }

  @override
  void initState() {
    today = DateTime.now();
    // TODO: implement initState
    if (lang == "en") {
      quoteHindiBloc..dispose();
      quoteBothBloc..dispose();
      quoteEnglishBloc..getQuotes(lang, "ThisYear");
    } else if (lang == "hi") {
      quoteEnglishBloc..dispose();
      quoteBothBloc..dispose();
      quoteHindiBloc..getQuotes(lang, "ThisYear");
    } else {
      quoteHindiBloc..dispose();
      quoteEnglishBloc..dispose();
      quoteBothBloc..getQuotes(lang, "ThisYear");
    }
    selectedEvent = events[selectedDay] ?? [];
    super.initState();
  }

  @override
  void dispose() {
    setQuote();
    super.dispose();
  }

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

  String date(String date) {
    DateTime dt = DateTime.parse(date);
    var d = DateFormat.yMMMMd().format(dt);
    d.replaceFirst(",", "");
    return d.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          title: Padding(
              padding: EdgeInsets.only(left: 0.0972*width, top: 0.0203*height),
              child: Image(
                image: AssetImage('images/vikasrunwalquotes.png'),
              )),
          backgroundColor: Style.Colors.primary,
          leading: Padding(
            padding:EdgeInsets.only(top: 0.020*height,left: 0),
            child: IconButton(
              icon: Icon(EvaIcons.arrowBack,color: Colors.white,),
              iconSize: 0.077*width,
              onPressed: (){
                setState(() {
                  genre = "TodaysQuote";
                  ind = 0;
                });
                setQuote();
                Navigator.of(context).pop(true);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              },
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: _onwillPop,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.18,
                child: Container(
                  child: Calendar(
                    startOnMonday: true,
                    selectedColor: Style.Colors.primary,
                    todayColor: Colors.red,
                    eventColor: Colors.green,
                    eventDoneColor: Colors.amber,
                    bottomBarColor: Colors.deepOrange,
                    onRangeSelected: (range) {
                      print('Selected Day ${range.from}, ${range.to}');
                    },
                    initialDate: today,
                    onDateSelected: (date) {
                      setState(() {
                        today = date;
                      });
                      return _handleData(date);
                    },
                    events: events,
                    isExpanded: true,
                    dayOfWeekStyle: TextStyle(
                      fontSize: 0.0361*width,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                    bottomBarTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hideBottomBar: false,
                    isExpandable: true,
                    hideArrows: false,
                    weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                  ),
                ),
              ),
              // Text(today.toString()),
              SizedBox(
                height: 0.0543*height,
              ),
              Column(
                children: [
                  if (lang == "hi")
                    Container(
                      height: 0.3125*height,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<QuoteHindiResponse>(
                          stream: quoteHindiBloc.subject.stream,
                          builder: (context,
                              AsyncSnapshot<QuoteHindiResponse> snapshot) {
                            if (snapshot.hasData) {
                              // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                              //   return buildError(snapshot.data.error);
                              // }
                              if (_QuoteBoxHindi(snapshot.data) == null) {
                                return Container(
                                  width: 0.1388*width,
                                  height: 0.0679*height,
                                );
                              } else {
                                return _QuoteBoxHindi(snapshot.data);
                              }
                            } else if (snapshot.hasError) {
                              return buildError(snapshot.error);
                            } else {
                              return buildLoading();
                            }
                          }),
                    )
                  else if (lang == "en")
                    Container(
                        height: 0.3125*height,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<QuoteEnglishResponse>(
                            stream: quoteEnglishBloc.subject.stream,
                            builder: (context,
                                AsyncSnapshot<QuoteEnglishResponse> snapshot) {
                              if (snapshot.hasData) {
                                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                                //   return buildError(snapshot.data.error);
                                // }
                                if (_QuoteBoxEnglish(snapshot.data) == null) {
                                  return Container(
                                    width: 50,
                                    height: 50,
                                  );
                                } else {
                                  return _QuoteBoxEnglish(snapshot.data);
                                }
                              } else if (snapshot.hasError) {
                                return buildError(snapshot.error);
                              } else {
                                return buildLoading();
                              }
                            }))
                  else
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<QuoteBothResponse>(
                          stream: quoteBothBloc.subject.stream,
                          builder: (context,
                              AsyncSnapshot<QuoteBothResponse> snapshot) {
                            if (snapshot.hasData) {
                              // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                              //   return buildError(snapshot.data.error);
                              // }
                              if (_QuoteBoxBoth(snapshot.data) == null) {
                                return Container(
                                  width: 0.1388*width,
                                  height: 0.0679*height,
                                );
                              } else {
                                return _QuoteBoxBoth(snapshot.data);
                              }
                            } else if (snapshot.hasError) {
                              return buildError(snapshot.error);
                            } else {
                              return buildLoading();
                            }
                          }),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _QuoteBoxHindi(QuoteHindiResponse data) {
    List<QuotesHindi> quotes = data.quotes;
    if (quotes.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Quotes"),
          ],
        ),
      );
    } else {
      for (int i = 0; i < quotes.length; i++) {
        if ((quotes[i].date).substring(0, 10) == formatter.format(today)) {
          Random random = new Random();
          int imgno = random.nextInt(images.length);
          return Padding(
            padding: EdgeInsets.only(top: 0.0135*height),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    QuotesOnePage(quotes[i].date, imgno)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),
                          offset: Offset(0.0055 * width, 0.0055 * width),
                          blurRadius: 0.0027 * width,
                          spreadRadius: 0.0055 * width),
                    ]
                ),
                width: double.infinity,
                height: 0.2717 * height,
                margin: EdgeInsets.symmetric(
                    vertical: 0.0135 * height, horizontal: 0.027 * width),
                padding: EdgeInsets.symmetric(
                    vertical: 0.0135 * height, horizontal: 0.027 * width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0022 * height,
                      left: 0.031 * width,
                      child: Text(
                        quotes[i].day,
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.042 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0027 * height,
                      right: 0.0138 * width,
                      child: Text(
                        date(quotes[i].date),
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.033 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0371 * height,
                      left: 0.027 * width,
                      child: Container(
                        width: 0.163 * height,
                        height: 0.333 * width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.5),
                                blurRadius: 0.0027 * width,
                                spreadRadius: 0.0055 * width,
                                offset: Offset(
                                    0.0027 * width, 0.0027 * width),),
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(7),),
                          child: Image(
                            image: AssetImage('images/${images[imgno]}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0483 * height,
                      left: 0.416 * width,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.3,
                        child: Text(
                          quotes[i].quote,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 0.0458 * width,
                            color: Style.Colors.secondary,
                            fontFamily: "Lexend",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.1390 * height,
                        left: 0.416 * width,
                        child: Text("...", style: TextStyle(
                          fontSize: 0.1000 * width, color: Colors.black54,),)
                    ),
                    Positioned(
                      top: 0.1470 * height,
                      left: 0.490 * width,
                      child: Text("...", style: TextStyle(
                        fontSize: 0.0804 * width, color: Colors.black45,),),
                    ),
                    Positioned(
                      top: 0.1538 * height,
                      left: 0.550 * width,
                      child: Text("...", style: TextStyle(
                        fontSize: 0.0653 * width, color: Colors.black26,),),
                    ),
                    Positioned(
                      bottom: -4,
                      right: 6,
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                EvaIcons.clipboard, color: Colors.deepOrange,),
                              iconSize: 22,
                              onPressed: () {
                                FlutterClipboard.copy(quotes[i].quote +
                                    "\n\n~${footer1}\n${footer2}");
                                final snackbar = SnackBar(
                                  padding: EdgeInsets.only(bottom: 50),
                                  elevation: 5,
                                  content: Text('Message Copied'),
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      FlutterClipboard.paste().then((value) {});
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackbar);
                              },
                            ),
                          ),
                          Container(
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    share(context, "${quotes[i]
                                        .quote}\n\n~${footer1}\n${footer2}");
                                  },
                                  child: Image(image: AssetImage(
                                      'images/share-icon.png'),),
                                ),
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
          );
        } else {
          continue;
        }
      }
    }
  }

  Widget _QuoteBoxEnglish(QuoteEnglishResponse data) {
    List<QuotesEnglish> quotes = data.quotes;
    if (quotes.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Quotes"),
          ],
        ),
      );
    } else {
      for (int i = 0; i < quotes.length; i++) {
        if ((quotes[i].date).substring(0, 10) == formatter.format(today)) {
          Random random = new Random();
          int imgno = random.nextInt(images.length);
          return Padding(
            padding: EdgeInsets.only(top: 0.0135*height),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    QuotesOnePage(quotes[i].date, imgno)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),
                          offset: Offset(0.0055 * width, 0.0055 * width),
                          blurRadius: 0.0027 * width,
                          spreadRadius: 0.0055 * width),
                    ]
                ),
                width: double.infinity,
                height: 0.2717 * height,
                margin: EdgeInsets.symmetric(
                    vertical: 0.0135 * height, horizontal: 0.0277 * width),
                padding: EdgeInsets.symmetric(
                    vertical: 0.0135 * height, horizontal: 0.0277 * width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0022 * height,
                      left: 0.031 * width,
                      child: Text(
                        quotes[i].day,
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.035 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0027 * height,
                      right: 0.0138 * width,
                      child: Text(
                        date(quotes[i].date),
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.033 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0371 * height,
                      left: 0.0277 * width,
                      child: Container(
                        width: 0.333 * width,
                        height: 0.163 * height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            boxShadow: [
                              BoxShadow(color: Colors.black26,
                                blurRadius: 0.0027 * width,
                                spreadRadius: 0.0055 * width,
                                offset: Offset(
                                    0.0027 * width, 0.0027 * width),),
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(7),),
                          child: Image(
                            image: AssetImage('images/${images[imgno]}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.054 * height,
                      left: 0.416 * width,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.3,
                        child: Text(
                          quotes[i].quote,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 0.0402 * width,
                            color: Style.Colors.secondary,
                            fontFamily: "Lexend",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.1290 * height,
                        left: 0.416 * width,
                        child: Text("...", style: TextStyle(
                          fontSize: 0.1000 * width, color: Colors.black54,),)
                    ),
                    Positioned(
                      top: 0.1370 * height,
                      left: 0.490 * width,
                      child: Text("...", style: TextStyle(
                        fontSize: 0.0804 * width, color: Colors.black45,),),
                    ),
                    Positioned(
                      top: 0.1438 * height,
                      left: 0.550 * width,
                      child: Text("...", style: TextStyle(
                        fontSize: 0.0653 * width, color: Colors.black26,),),
                    ),
                    Positioned(
                      bottom: -(0.0054 * height),
                      right: 0.016 * width,
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                EvaIcons.clipboard, color: Colors.deepOrange,),
                              iconSize: 0.0611 * width,
                              onPressed: () {
                                FlutterClipboard.copy(quotes[i].quote +
                                    "\n\n~${footer1}\n${footer2}");
                                final snackbar = SnackBar(
                                  padding: EdgeInsets.only(
                                      bottom: 0.067 * height),
                                  elevation: 0.0067 * height,
                                  content: Text('Message Copied'),
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      FlutterClipboard.paste().then((value) {});
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackbar);
                              },
                            ),
                          ),
                          Container(
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(0.0416 * width),
                                child: GestureDetector(
                                  onTap: () {
                                    share(context, "${quotes[i]
                                        .quote}\n\n~${footer1}\n${footer2}");
                                  },
                                  child: Image(image: AssetImage(
                                      'images/share-icon.png'),),
                                ),
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
          );
        } else {
          continue;
        }
      }
    }
  }

  Widget _QuoteBoxBoth(QuoteBothResponse data) {
    List<QuotesBoth> quotes = data.quotes;
    if (quotes.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Quotes"),
          ],
        ),
      );
    } else {
      for (int i = 0; i < quotes.length; i++) {
        if ((quotes[i].date).substring(0, 10) == formatter.format(today)) {
          Random random = new Random();
          int imgno = random.nextInt(images.length);
          return Padding(
            padding: EdgeInsets.only(top: 0.0135*height),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        QuotesOnePage(quotes[i].date, imgno)));
              },
              child: Container(
                width: double.infinity,
                height: 0.2717 * height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),
                          offset: Offset(0.0055 * width, 0.0055 * width),
                          blurRadius: 0.0027 * width,
                          spreadRadius: 0.0055 * width),
                    ]
                ),
                margin: EdgeInsets.symmetric(
                    vertical: 0.0135 * height, horizontal: 0.027 * width),
                padding: EdgeInsets.symmetric(
                    vertical: 0.0135 * height, horizontal: 0.027 * width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0022 * height,
                      left: 0.031 * width,
                      child: Text(
                        quotes[i].day,
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.037 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0027 * height,
                      right: 0.0138 * width,
                      child: Text(
                        date(quotes[i].date),
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.0333 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0371 * height,
                      left: 0.0277 * width,
                      child: Container(
                        width: 0.333 * width,
                        height: 0.163 * height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),),
                            boxShadow: [
                              BoxShadow(color: Colors.black26,
                                blurRadius: 0.0027 * width,
                                spreadRadius: 0.0055 * width,
                                offset: Offset(
                                    0.0027 * width, 0.0027 * width),),
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(7),),
                          child: Image(
                            image: AssetImage('images/${images[imgno]}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.044 * height,
                      left: 0.416 * width,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2.3,
                        child: Column(
                          children: [
                            Text(
                              quotes[i].quoteHin,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 0.0458 * width,
                                color: Style.Colors.secondary,
                                fontFamily: "Lexend",
                              ),
                            ),
                            SizedBox(height: 0.0095 * height,),
                            Text(
                              quotes[i].quoteEng,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 0.0402 * width,
                                color: Style.Colors.secondary,
                                fontFamily: "Lexend",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.1470 * height,
                        left: 0.416 * width,
                        child: Text("...", style: TextStyle(fontSize: 0.1000 *
                            width, color: Colors.black54,),)
                    ),
                    Positioned(
                      top: 0.1550 * height,
                      left: 0.490 * width,
                      child: Text("...", style: TextStyle(fontSize: 0.0804 *
                          width, color: Colors.black45,),),
                    ),
                    Positioned(
                      top: 0.1615 * height,
                      left: 0.550 * width,
                      child: Text("...", style: TextStyle(fontSize: 0.0653 *
                          width, color: Colors.black26,),),
                    ),
                    Positioned(
                      bottom: -(0.0054 * height),
                      right: 0.0166 * width,
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(EvaIcons.clipboard,
                                color: Colors.deepOrange,),
                              iconSize: 0.0611 * width,
                              onPressed: () {
                                FlutterClipboard.copy("${quotes[i]
                                    .quoteHin}\n\n${quotes[i]
                                    .quoteEng}\n\n~${footer1}\n${footer2}");
                                final snackbar = SnackBar(
                                  padding: EdgeInsets.only(
                                      bottom: 0.0679 * height),
                                  elevation: 0.0067 * height,
                                  content: Text('Message Copied'),
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      FlutterClipboard.paste().then((
                                          value) {});
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                    snackbar);
                              },
                              // onPressed: (){
                              //   FlutterClipboard.copy("${quotes[index].quoteHin}\n\n${quotes[index].quoteEng}");
                              // },
                            ),
                          ),
                          Container(
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(0.0416 * width),
                                child: GestureDetector(
                                  onTap: () {
                                    share(context, "${quotes[i]
                                        .quoteHin}\n\n${quotes[i]
                                        .quoteEng}\n\n~${footer1}\n${footer2}");
                                  },
                                  child: Image(image: AssetImage(
                                      'images/share-icon.png'),),
                                ),
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
          );
        } else {
          continue;
        }
      }
    }
  }
}
