import 'package:clipboard/clipboard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
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
import 'package:quotes/main.dart';
import 'package:share/share.dart';
import 'dart:math';

import 'package:swipedetector/swipedetector.dart';

class GenreQuotes extends StatefulWidget {

  @override
  _GenreQuotesState createState() => _GenreQuotesState();
}

class _GenreQuotesState extends State<GenreQuotes> {

  bool onCLicked = false;

  void share(BuildContext context, String text) {
    // final RenderBox box = context.findRenderObject();
    Share.share(text, sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0));
  }

  String date(String date) {
    DateTime dt = DateTime.parse(date);
    var d = DateFormat.yMMMMd().format(dt);
    d.replaceFirst(",", "");
    return d.toString();
  }

  _GenreQuotesState();


  @override
  void initState() {
    setQuote();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    if (genre == "TodaysQuote" || genre == "RandomsQuote") {
      if (lang == "hi") {
        return StreamBuilder<QuoteHindiResponse>(
            stream: quoteHindiBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteHindiResponse> snapshot) {
              if (snapshot.hasData) {
                return _TodayBoxHindi(snapshot.data);
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
      else if (lang == "en") {
        return StreamBuilder<QuoteEnglishResponse>(
            stream: quoteEnglishBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteEnglishResponse> snapshot) {
              if (snapshot.hasData) {
                return _TodayBoxEnglish(snapshot.data);
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
      else {
        return StreamBuilder<QuoteBothResponse>(
            stream: quoteBothBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteBothResponse> snapshot) {
              if (snapshot.hasData) {
                return _TodayBoxBoth(snapshot.data);
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
    }
    else if (genre == "YearQuote") {
      if (lang == "hi") {
        return StreamBuilder<QuoteHindiResponse>(
            stream: quoteHindiBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteHindiResponse> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    SizedBox(child: Padding(
                      padding: EdgeInsets.only(top: 0.0271 * height),
                      child: _QuoteBoxHindi(snapshot.data),
                    ), height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.402,),
                    Positioned(
                      top: -(0.0163 * height),
                      right: 0,
                      child: Theme(
                        data: ThemeData(
                          canvasColor: Colors.white,
                        ),
                        child: DropdownButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Style.Colors.secondary,
                            ),
                            isExpanded: false,
                            underline: Container(
                            ),
                            value: year,
                            onChanged: (value) {
                              setState(() {
                                year = value;
                              });
                              setQuote();
                            },
                            items: years.map((item) {
                              return DropdownMenuItem<int>(
                                value: item,
                                child: Row(
                                  children: [
                                    Text(
                                      "${item}",
                                      style: GoogleFonts.portLligatSans(
                                        textStyle: Theme
                                            .of(context)
                                            .textTheme
                                            .display1,
                                        fontSize: 0.038 * width,
                                        fontWeight: FontWeight.w700,
                                        color: Style.Colors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                        ),
                      ),
                    ),
                  ],
                );
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
      else if (lang == "en") {
        return StreamBuilder<QuoteEnglishResponse>(
            stream: quoteEnglishBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteEnglishResponse> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    SizedBox(child: Padding(
                      padding: EdgeInsets.only(top: 0.0271 * height),
                      child: _QuoteBoxEnglish(snapshot.data),
                    ), height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.402,),
                    Positioned(
                      top: -(0.0163 * height),
                      right: 0,
                      child: Theme(
                        data: ThemeData(
                          canvasColor: Colors.white,
                        ),
                        child: DropdownButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Style.Colors.secondary,
                            ),
                            isExpanded: false,
                            underline: Container(
                            ),
                            value: year,
                            onChanged: (value) {
                              setState(() {
                                year = value;
                              });
                              setQuote();
                            },
                            items: years.map((item) {
                              return DropdownMenuItem<int>(
                                value: item,
                                child: Row(
                                  children: [
                                    Text(
                                      "${item}",
                                      style: GoogleFonts.portLligatSans(
                                        textStyle: Theme
                                            .of(context)
                                            .textTheme
                                            .display1,
                                        fontSize: 0.038 * width,
                                        fontWeight: FontWeight.w700,
                                        color: Style.Colors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                        ),
                      ),
                    ),
                  ],
                );
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
      else {
        return StreamBuilder<QuoteBothResponse>(
            stream: quoteBothBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteBothResponse> snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: [
                    SizedBox(child: Padding(
                      padding: EdgeInsets.only(top: 0.0271 * height),
                      child: _QuoteBoxBoth(snapshot.data),
                    ), height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.402,),
                    Positioned(
                      top: -(0.0163 * height),
                      right: 0,
                      child: Theme(
                        data: ThemeData(
                          canvasColor: Colors.white,
                        ),
                        child: DropdownButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Style.Colors.secondary,
                            ),
                            isExpanded: false,
                            underline: Container(
                            ),
                            value: year,
                            onChanged: (value) {
                              setState(() {
                                year = value;
                              });
                              setQuote();
                            },
                            items: years.map((item) {
                              return DropdownMenuItem<int>(
                                value: item,
                                child: Row(
                                  children: [
                                    Text(
                                      "${item}",
                                      style: GoogleFonts.portLligatSans(
                                        textStyle: Theme
                                            .of(context)
                                            .textTheme
                                            .display1,
                                        fontSize: 0.038 * width,
                                        fontWeight: FontWeight.w700,
                                        color: Style.Colors.secondary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList()
                        ),
                      ),
                    ),
                  ],
                );
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
    }
    else {
      if (lang == "hi") {
        return StreamBuilder<QuoteHindiResponse>(
            stream: quoteHindiBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteHindiResponse> snapshot) {
              if (snapshot.hasData) {
                return _QuoteBoxHindi(snapshot.data);
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
      else if (lang == "en") {
        return StreamBuilder<QuoteEnglishResponse>(
            stream: quoteEnglishBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteEnglishResponse> snapshot) {
              if (snapshot.hasData) {
                return _QuoteBoxEnglish(snapshot.data);
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
      else {
        return StreamBuilder<QuoteBothResponse>(
            stream: quoteBothBloc.subject.stream,
            builder: (context, AsyncSnapshot<QuoteBothResponse> snapshot) {
              if (snapshot.hasData) {
                return _QuoteBoxBoth(snapshot.data);
              }
              else if (snapshot.hasError) {
                return buildError(snapshot.error);
              }
              else {
                return buildLoading();
              }
            }
        );
      }
    }
  }

  Widget _QuoteBoxHindi(QuoteHindiResponse data) {
    bool clicked = false;
    Color color = Style.Colors.primary;
    List<QuotesHindi> quotes = data.quotes;
    if (quotes.length == 0) {
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
    else {
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            Random random = new Random();
            int imgno = random.nextInt(17);
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    QuotesOnePage(quotes[index].date, imgno)));
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
                      top: 0.0027 * height,
                      right: 0.0138 * width,
                      child: Text(
                        date(quotes[index].date),
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.033 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0271 * height,
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
                          quotes[index].quote,
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
                                FlutterClipboard.copy(quotes[index].quote +
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
                                    share(context, "${quotes[index]
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
            );
          }
      );
    }
  }

  Widget _QuoteBoxEnglish(QuoteEnglishResponse data) {
    List<QuotesEnglish> quotes = data.quotes;
    if (quotes.length == 0) {
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
    else {
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            Random random = new Random();
            int imgno = random.nextInt(images.length);
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    QuotesOnePage(quotes[index].date, imgno)));
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
                      top: 0.0027 * height,
                      right: 0.0138 * width,
                      child: Text(
                        date(quotes[index].date),
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.033 * width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0271 * height,
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
                          quotes[index].quote,
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
                                FlutterClipboard.copy(quotes[index].quote +
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
                                    share(context, "${quotes[index]
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
            );
          }
      );
    }
  }

  Widget _QuoteBoxBoth(QuoteBothResponse data) {
    List<QuotesBoth> quotes = data.quotes;
    if (quotes.length == 0) {
      return Container(
        width: 0.555 * width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("NO Quotes"),
          ],
        ),
      );
    }
    else {
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            Random random = new Random();
            int imgno = random.nextInt(images.length);
            return Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          QuotesOnePage(quotes[index].date, imgno)));
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
                        top: 0.0027 * height,
                        right: 0.0138 * width,
                        child: Text(
                          date(quotes[index].date),
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 0.0333 * width,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0271 * height,
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
                                quotes[index].quoteHin,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 0.0458 * width,
                                  color: Style.Colors.secondary,
                                  fontFamily: "Lexend",
                                ),
                              ),
                              SizedBox(height: 0.0095 * height,),
                              Text(
                                quotes[index].quoteEng,
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
                                  FlutterClipboard.copy("${quotes[index]
                                      .quoteHin}\n\n${quotes[index]
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
                                      share(context, "${quotes[index]
                                          .quoteHin}\n\n${quotes[index]
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
          }
      );
    }
  }

  Widget _TodayBoxHindi(QuoteHindiResponse data) {
    List<QuotesHindi> quotes = data.quotes;
    Random random = new Random();
    int imgno = random.nextInt(17);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    ScrollController scrollController = new ScrollController();
    String time = "T00:00:00";

    String getDate(String date) {
      DateTime dt = DateTime.parse(date);
      var d = DateFormat.yMMMMd().format(dt);
      d.replaceFirst(",", "");
      return d.toString();
    }

    void share(BuildContext context, String text) {
      Share.share(text, sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0));
    }
    if (quotes.length == 0) {
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
    else {
      // return Column(
      //   children: [
      //     GestureDetector(
      //       onTap: (){
      //         Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[0].date,random.nextInt(images.length))));
      //       },
      //       child: Container(
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             boxShadow: [
      //               BoxShadow(color: Colors.black.withOpacity(0.3),offset: Offset(0.0083*width,0.0083*width),blurRadius: 0.0055*width,spreadRadius:0.0083*width),
      //             ]
      //         ),
      //         width: double.infinity,
      //         height: MediaQuery.of(context).size.height/1.51,
      //         margin: EdgeInsets.only(top: 0.0135*height,bottom: 0.0135*height,right: 0.0194*width,left:0.0138*width,),
      //         padding: EdgeInsets.only(right: 0.0277*width,top: 0.0135*height),
      //         child: Stack(
      //           children: <Widget>[
      //             Positioned(
      //               top: 0.0027*height,
      //               right: 0.0138*width,
      //               child: Text(
      //                 date(quotes[0].date),
      //                 style: GoogleFonts.libreBaskerville(
      //                   fontSize: 0.033*width,
      //                   color: Color(0xFF666666),
      //                   fontWeight: FontWeight.w400,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               bottom: 0,
      //               left: 0.0055*width,
      //               child: Container(
      //                 width: 0.6388*width,
      //                 height:0.3804*height,
      //                 child: Image(
      //                   image: AssetImage('images/homequote-bg.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               top: 0.054*height,
      //               left: 0.4166*width,
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     width: MediaQuery.of(context).size.width/2.3,
      //                     height: (MediaQuery.of(context).size.width/1)+15,
      //                     child: SingleChildScrollView(
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                               quotes[0].quote,
      //                               style: TextStyle(
      //                                 fontSize: 0.0472*width,
      //                                 color: Style.Colors.secondary,
      //                                 fontFamily: "Lexend",
      //                               ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Positioned(
      //               bottom: -(0.0054*height),
      //               right: 0.016*width,
      //               child: Row(
      //                 children: [
      //                   Container(
      //                     child: IconButton(
      //                       icon: Icon(EvaIcons.clipboard,color: Colors.deepOrange,),
      //                       iconSize: 0.0611*width,
      //                       onPressed: (){
      //                         FlutterClipboard.copy(quotes[0].quote);
      //                         final snackbar = SnackBar(
      //                           padding: EdgeInsets.only(bottom: 0.0679*height),
      //                           elevation: 0.0067*height,
      //                           content: Text('Message Copied'),
      //                           duration: Duration(seconds: 3),
      //                           action: SnackBarAction(
      //                             label: 'Undo',
      //                             onPressed: () {
      //                               FlutterClipboard.paste().then((value) {});
      //                             },
      //                           ),
      //                         );
      //                         ScaffoldMessenger.of(context).showSnackBar(snackbar);
      //                       },
      //                     ),
      //                   ),
      //                   Container(
      //                     child: InkWell(
      //                       child: Padding(
      //                         padding: const EdgeInsets.all(15.0),
      //                         child: GestureDetector(
      //                           onTap: (){
      //                             share(context, "${quotes[0].quote}");
      //                           },
      //                           child: Image(image: AssetImage('images/share-icon.png'),),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // );
      return Padding(
        padding: EdgeInsets.only(top: 0.0135 * height),
        child: Container(
          width: double.infinity,
          height: MediaQuery
              .of(context)
              .size
              .height / 1.402,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(left: 0.0277*width,top: 0.0135*height),
                      //   child: IconButton(
                      //     onPressed: (){
                      //       var dt = formatter.format(DateTime.parse(date).subtract(Duration(days: 1)));
                      //       String next = "$dt$time";
                      //       Random random = new Random();
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                      //     },
                      //     icon: Icon(FontAwesomeIcons.backward,color: Style.Colors.secondary,),
                      //     iconSize: 0.0722*width,
                      //   )
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.0271 * height),
                        child: Container(
                          child: IconButton(
                            icon: Icon(EvaIcons.clipboard,
                              color: Colors.deepOrange,),
                            iconSize: 0.0611 * width,
                            onPressed: () {
                              FlutterClipboard.copy("${quotes[0]
                                  .quote}\n\n~${footer1}\n${footer2}");
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0.034 * width),
                        child: Container(
                          padding: EdgeInsets.only(top: 0.0271 * height),
                          child: Text(
                            getDate(quotes[0].date),
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 0.0472 * width,
                              color: Style.Colors.secondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.0271 * height),
                        child: Container(
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(0.0416 * width),
                              child: GestureDetector(
                                onTap: () {
                                  share(context, "${quotes[0]
                                      .quote}\n\n~${footer1}\n${footer2}");
                                },
                                child: Image(image: AssetImage(
                                    'images/share-icon.png'),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.027*width,top: 0.0135*height),
                      //   child: IconButton(
                      //     onPressed: (){
                      //       var dt = formatter.format(DateTime.parse(date).add(Duration(days: 1)));
                      //       String next = "$dt$time";
                      //       Random random = new Random();
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                      //     },
                      //     icon: Icon(FontAwesomeIcons.forward,color: Style.Colors.secondary,),
                      //     iconSize: 0.0722*width,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 0.0407 * height,),
                  Container(
                    width: double.infinity,
                    height: 0.339 * height,
                    child: Image(
                      image: AssetImage("images/baba-pic${imgno + 1}-big.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 0.0135 * height,),
                  Column(
                    children: [
                      Container(
                        width: 0.138 * width,
                        height: 0.0679 * height,
                        child: Image(image: AssetImage('images/quotation.png'),
                          fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 0.0135 * height,),
                      Container(
                        height: 0.4076 * height,
                        width: 0.7777*width,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: scrollController,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0135 * height),
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 0.0135 * height,
                                        horizontal: 0.0277 * width),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.0135 * height,
                                        horizontal: 0.0277 * width),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          // width: 300,
                                          child: Text(
                                            quotes[0].quote,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 0.05 * width,
                                              color: Style.Colors.secondary,
                                              fontFamily: "Lexend",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
                      Container(
                        width: 0.777 * width,
                        height: 0.2717 * height,
                        // decoration: BoxDecoration(color: Colors.black),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0.0271 * height,
                              child: Container(
                                // decoration: BoxDecoration(color: Colors.white),
                                width: 0.277 * width,
                                height: 0.135 * height,
                                child: Image(image: AssetImage(
                                    "images/saidattavikas-foundation.png"),),
                              ),
                            ),
                            // Positioned(
                            //   left:0.0138*width,
                            //   bottom: 0.0407*height,
                            //   child: GestureDetector(
                            //     onTap: (){
                            //       var dt = formatter.format(DateTime.parse(quotes[0].date).subtract(Duration(days: 1)));
                            //       String next = "$dt$time";
                            //       Random random = new Random();
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                            //     },
                            //     child: Text(
                            //       "Previous",
                            //       style: GoogleFonts.lobster(
                            //         fontSize: 0.066*width,
                            //         fontWeight: FontWeight.bold,
                            //         color: Style.Colors.secondary,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   right: 0.102*width,
                            //   bottom: 0.0407*height,
                            //   child: GestureDetector(
                            //     onTap: (){
                            //       var dt = formatter.format(DateTime.parse().add(Duration(days: 1)));
                            //       String next = "$dt$time";
                            //       Random random = new Random();
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                            //     },
                            //     child: Text(
                            //       "Next",
                            //       style: GoogleFonts.lobster(
                            //         fontSize: 0.066*width,
                            //         fontWeight: FontWeight.bold,
                            //         color: Style.Colors.secondary,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _TodayBoxEnglish(QuoteEnglishResponse data) {
    List<QuotesEnglish> quotes = data.quotes;
    Random random = new Random();
    int imgno = random.nextInt(17);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    ScrollController scrollController = new ScrollController();
    String time = "T00:00:00";

    String getDate(String date) {
      DateTime dt = DateTime.parse(date);
      var d = DateFormat.yMMMMd().format(dt);
      d.replaceFirst(",", "");
      return d.toString();
    }

    void share(BuildContext context, String text) {
      Share.share(text, sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0));
    }
    if (quotes.length == 0) {
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
    else {
      // return Column(
      //   children: [
      //     GestureDetector(
      //       onTap: (){
      //         Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[0].date,random.nextInt(images.length))));
      //       },
      //       child: Container(
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             boxShadow: [
      //               BoxShadow(color: Colors.black.withOpacity(0.3),offset: Offset(0.0083*width,0.0083*width),blurRadius: 0.0055*width,spreadRadius:0.0083*width),
      //             ]
      //         ),
      //         width: double.infinity,
      //         height: MediaQuery.of(context).size.height/1.51,
      //         margin: EdgeInsets.only(top: 0.0135*height,bottom: 0.0135*height,right: 0.0194*width,left:0.0138*width,),
      //         padding: EdgeInsets.only(right: 0.0277*width,top: 0.0135*height),
      //         child: Stack(
      //           children: <Widget>[
      //             Positioned(
      //               top: 0.0027*height,
      //               right: 0.0138*width,
      //               child: Text(
      //                 date(quotes[0].date),
      //                 style: GoogleFonts.libreBaskerville(
      //                   fontSize: 0.033*width,
      //                   color: Color(0xFF666666),
      //                   fontWeight: FontWeight.w400,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               bottom: 0,
      //               left: 0.0055*width,
      //               child: Container(
      //                 width: 0.6388*width,
      //                 height:0.3804*height,
      //                 child: Image(
      //                   image: AssetImage('images/homequote-bg.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               top: 0.054*height,
      //               left: 0.4166*width,
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     width: MediaQuery.of(context).size.width/2.3,
      //                     height: (MediaQuery.of(context).size.width/1)+15,
      //                     child: SingleChildScrollView(
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                               quotes[0].quote,
      //                               style: TextStyle(
      //                                 fontSize: 0.0472*width,
      //                                 color: Style.Colors.secondary,
      //                                 fontFamily: "Lexend",
      //                               ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Positioned(
      //               bottom: -(0.0054*height),
      //               right: 0.016*width,
      //               child: Row(
      //                 children: [
      //                   Container(
      //                     child: IconButton(
      //                       icon: Icon(EvaIcons.clipboard,color: Colors.deepOrange,),
      //                       iconSize: 0.0611*width,
      //                       onPressed: (){
      //                         FlutterClipboard.copy(quotes[0].quote);
      //                         final snackbar = SnackBar(
      //                           padding: EdgeInsets.only(bottom: 0.0679*height),
      //                           elevation: 0.0067*height,
      //                           content: Text('Message Copied'),
      //                           duration: Duration(seconds: 3),
      //                           action: SnackBarAction(
      //                             label: 'Undo',
      //                             onPressed: () {
      //                               FlutterClipboard.paste().then((value) {});
      //                             },
      //                           ),
      //                         );
      //                         ScaffoldMessenger.of(context).showSnackBar(snackbar);
      //                       },
      //                     ),
      //                   ),
      //                   Container(
      //                     child: InkWell(
      //                       child: Padding(
      //                         padding: const EdgeInsets.all(15.0),
      //                         child: GestureDetector(
      //                           onTap: (){
      //                             share(context, "${quotes[0].quote}");
      //                           },
      //                           child: Image(image: AssetImage('images/share-icon.png'),),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // );
      return Padding(
        padding: EdgeInsets.only(top: 0.0135 * height),
        child: Container(
          width: double.infinity,
          height: MediaQuery
              .of(context)
              .size
              .height / 1.402,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(left: 0.0277*width,top: 0.0135*height),
                      //   child: IconButton(
                      //     onPressed: (){
                      //       var dt = formatter.format(DateTime.parse(date).subtract(Duration(days: 1)));
                      //       String next = "$dt$time";
                      //       Random random = new Random();
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                      //     },
                      //     icon: Icon(FontAwesomeIcons.backward,color: Style.Colors.secondary,),
                      //     iconSize: 0.0722*width,
                      //   )
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.0271 * height),
                        child: Container(
                          child: IconButton(
                            icon: Icon(EvaIcons.clipboard,
                              color: Colors.deepOrange,),
                            iconSize: 0.0611 * width,
                            onPressed: () {
                              FlutterClipboard.copy("${quotes[0]
                                  .quote}\n\n~${footer1}\n${footer2}");
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0.034 * width),
                        child: Container(
                          padding: EdgeInsets.only(top: 0.0271 * height),
                          child: Text(
                            getDate(quotes[0].date),
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 0.0472 * width,
                              color: Style.Colors.secondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.0271 * height),
                        child: Container(
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(0.0416 * width),
                              child: GestureDetector(
                                onTap: () {
                                  share(context, "${quotes[0]
                                      .quote}\n\n~${footer1}\n${footer2}");
                                },
                                child: Image(image: AssetImage(
                                    'images/share-icon.png'),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.027*width,top: 0.0135*height),
                      //   child: IconButton(
                      //     onPressed: (){
                      //       var dt = formatter.format(DateTime.parse(date).add(Duration(days: 1)));
                      //       String next = "$dt$time";
                      //       Random random = new Random();
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                      //     },
                      //     icon: Icon(FontAwesomeIcons.forward,color: Style.Colors.secondary,),
                      //     iconSize: 0.0722*width,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 0.0407 * height,),
                  Container(
                    width: double.infinity,
                    height: 0.339 * height,
                    child: Image(
                      image: AssetImage("images/baba-pic${imgno + 1}-big.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 0.0135 * height,),
                  Column(
                    children: [
                      Container(
                        width: 0.138 * width,
                        height: 0.0679 * height,
                        child: Image(
                          image: AssetImage('images/quotation.png'),
                          fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 0.0135 * height,),
                      Container(
                        height: 0.4076 * height,
                        width: 0.7777*width,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: scrollController,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0135 * height),
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 0.0135 * height,
                                        horizontal: 0.0277 * width),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.0135 * height,
                                        horizontal: 0.0277 * width),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 0.833*width,
                                          child: Text(
                                            quotes[0].quote,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 0.0472*width,
                                              color: Style.Colors.secondary,
                                              fontFamily: "Lexend",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
                      Container(
                        width: 0.777 * width,
                        height: 0.2717 * height,
                        // decoration: BoxDecoration(color: Colors.black),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0.0271 * height,
                              child: Container(
                                // decoration: BoxDecoration(color: Colors.white),
                                width: 0.277 * width,
                                height: 0.135 * height,
                                child: Image(image: AssetImage(
                                    "images/saidattavikas-foundation.png"),),
                              ),
                            ),
                            // Positioned(
                            //   left:0.0138*width,
                            //   bottom: 0.0407*height,
                            //   child: GestureDetector(
                            //     onTap: (){
                            //       var dt = formatter.format(DateTime.parse(quotes[0].date).subtract(Duration(days: 1)));
                            //       String next = "$dt$time";
                            //       Random random = new Random();
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                            //     },
                            //     child: Text(
                            //       "Previous",
                            //       style: GoogleFonts.lobster(
                            //         fontSize: 0.066*width,
                            //         fontWeight: FontWeight.bold,
                            //         color: Style.Colors.secondary,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   right: 0.102*width,
                            //   bottom: 0.0407*height,
                            //   child: GestureDetector(
                            //     onTap: (){
                            //       var dt = formatter.format(DateTime.parse().add(Duration(days: 1)));
                            //       String next = "$dt$time";
                            //       Random random = new Random();
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                            //     },
                            //     child: Text(
                            //       "Next",
                            //       style: GoogleFonts.lobster(
                            //         fontSize: 0.066*width,
                            //         fontWeight: FontWeight.bold,
                            //         color: Style.Colors.secondary,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _TodayBoxBoth(QuoteBothResponse data) {
    List<QuotesBoth> quotes = data.quotes;
    Random random = new Random();
    int imgno = random.nextInt(17);
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    ScrollController scrollController = new ScrollController();
    String time = "T00:00:00";

    String getDate(String date) {
      DateTime dt = DateTime.parse(date);
      var d = DateFormat.yMMMMd().format(dt);
      d.replaceFirst(",", "");
      return d.toString();
    }

    void share(BuildContext context, String text) {
      Share.share(text, sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0));
    }
    if (quotes.length == 0) {
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
    else {
      // return Column(
      //   children: [
      //     GestureDetector(
      //       onTap: (){
      //         Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[0].date,random.nextInt(images.length))));
      //       },
      //       child: Container(
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             boxShadow: [
      //               BoxShadow(color: Colors.black.withOpacity(0.3),offset: Offset(0.0083*width,0.0083*width),blurRadius: 0.0055*width,spreadRadius:0.0083*width),
      //             ]
      //         ),
      //         width: double.infinity,
      //         height: MediaQuery.of(context).size.height/1.51,
      //         margin: EdgeInsets.only(top: 0.0135*height,bottom: 0.0135*height,right: 0.0194*width,left:0.0138*width,),
      //         padding: EdgeInsets.only(right: 0.0277*width,top: 0.0135*height),
      //         child: Stack(
      //           children: <Widget>[
      //             Positioned(
      //               top: 0.0027*height,
      //               right: 0.0138*width,
      //               child: Text(
      //                 date(quotes[0].date),
      //                 style: GoogleFonts.libreBaskerville(
      //                   fontSize: 0.033*width,
      //                   color: Color(0xFF666666),
      //                   fontWeight: FontWeight.w400,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               bottom: 0,
      //               left: 0.0055*width,
      //               child: Container(
      //                 width: 0.6388*width,
      //                 height:0.3804*height,
      //                 child: Image(
      //                   image: AssetImage('images/homequote-bg.jpg'),
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             Positioned(
      //               top: 0.054*height,
      //               left: 0.4166*width,
      //               child: Column(
      //                 children: [
      //                   Container(
      //                     width: MediaQuery.of(context).size.width/2.3,
      //                     height: (MediaQuery.of(context).size.width/1)+15,
      //                     child: SingleChildScrollView(
      //                       child: Column(
      //                         children: [
      //                           Text(
      //                               quotes[0].quote,
      //                               style: TextStyle(
      //                                 fontSize: 0.0472*width,
      //                                 color: Style.Colors.secondary,
      //                                 fontFamily: "Lexend",
      //                               ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Positioned(
      //               bottom: -(0.0054*height),
      //               right: 0.016*width,
      //               child: Row(
      //                 children: [
      //                   Container(
      //                     child: IconButton(
      //                       icon: Icon(EvaIcons.clipboard,color: Colors.deepOrange,),
      //                       iconSize: 0.0611*width,
      //                       onPressed: (){
      //                         FlutterClipboard.copy(quotes[0].quote);
      //                         final snackbar = SnackBar(
      //                           padding: EdgeInsets.only(bottom: 0.0679*height),
      //                           elevation: 0.0067*height,
      //                           content: Text('Message Copied'),
      //                           duration: Duration(seconds: 3),
      //                           action: SnackBarAction(
      //                             label: 'Undo',
      //                             onPressed: () {
      //                               FlutterClipboard.paste().then((value) {});
      //                             },
      //                           ),
      //                         );
      //                         ScaffoldMessenger.of(context).showSnackBar(snackbar);
      //                       },
      //                     ),
      //                   ),
      //                   Container(
      //                     child: InkWell(
      //                       child: Padding(
      //                         padding: const EdgeInsets.all(15.0),
      //                         child: GestureDetector(
      //                           onTap: (){
      //                             share(context, "${quotes[0].quote}");
      //                           },
      //                           child: Image(image: AssetImage('images/share-icon.png'),),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // );
      return Padding(
        padding: EdgeInsets.only(top: 0.0135 * height),
        child: Container(
          width: double.infinity,
          height: MediaQuery
              .of(context)
              .size
              .height / 1.402,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(left: 0.0277*width,top: 0.0135*height),
                      //   child: IconButton(
                      //     onPressed: (){
                      //       var dt = formatter.format(DateTime.parse(date).subtract(Duration(days: 1)));
                      //       String next = "$dt$time";
                      //       Random random = new Random();
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                      //     },
                      //     icon: Icon(FontAwesomeIcons.backward,color: Style.Colors.secondary,),
                      //     iconSize: 0.0722*width,
                      //   )
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.0271 * height),
                        child: Container(
                          child: IconButton(
                            icon: Icon(EvaIcons.clipboard,
                              color: Colors.deepOrange,),
                            iconSize: 0.0611 * width,
                            onPressed: () {
                              FlutterClipboard.copy("${quotes[0]
                                  .quoteHin}\n\n${quotes[0]
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 0.034 * width),
                        child: Container(
                          padding: EdgeInsets.only(top: 0.0271 * height),
                          child: Text(
                            getDate(quotes[0].date),
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 0.0472 * width,
                              color: Style.Colors.secondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0.0271 * height),
                        child: Container(
                          child: InkWell(
                            child: Padding(
                              padding: EdgeInsets.all(0.0416 * width),
                              child: GestureDetector(
                                onTap: () {
                                  share(context, "${quotes[0]
                                      .quoteHin}\n\n${quotes[0]
                                      .quoteEng}\n\n~${footer1}\n${footer2}");
                                },
                                child: Image(image: AssetImage(
                                    'images/share-icon.png'),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 0.027*width,top: 0.0135*height),
                      //   child: IconButton(
                      //     onPressed: (){
                      //       var dt = formatter.format(DateTime.parse(date).add(Duration(days: 1)));
                      //       String next = "$dt$time";
                      //       Random random = new Random();
                      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                      //     },
                      //     icon: Icon(FontAwesomeIcons.forward,color: Style.Colors.secondary,),
                      //     iconSize: 0.0722*width,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 0.0407 * height,),
                  Container(
                    width: double.infinity,
                    height: 0.339 * height,
                    child: Image(
                      image: AssetImage("images/baba-pic${imgno + 1}-big.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 0.0135 * height,),
                  Column(
                    children: [
                      Container(
                        width: 0.138 * width,
                        height: 0.0679 * height,
                        child: Image(
                          image: AssetImage('images/quotation.png'),
                          fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 0.0135 * height,),
                      Container(
                        height: 0.4076 * height,
                        width: 0.7777*width,
                        child: Scrollbar(
                          isAlwaysShown: true,
                          controller: scrollController,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 0.0135 * height),
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 0.0135 * height,
                                        horizontal: 0.0277 * width),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.0135 * height,
                                        horizontal: 0.0277 * width),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          width: 0.833*width,
                                          child: Text(
                                            quotes[0].quoteHin,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 0.05 * width,
                                              color: Style.Colors.secondary,
                                              fontFamily: "Lexend",
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 0.0081 * height,),
                                        Container(
                                          width: 0.833*width,
                                          child: Text(
                                            quotes[0].quoteEng,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 0.0472*width,
                                              color: Style.Colors.secondary,
                                              fontFamily: "Lexend",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 0,),
                      Container(
                        width: 0.777 * width,
                        height: 0.2717 * height,
                        // decoration: BoxDecoration(color: Colors.black),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0.0271 * height,
                              child: Container(
                                // decoration: BoxDecoration(color: Colors.white),
                                width: 0.277 * width,
                                height: 0.135 * height,
                                child: Image(image: AssetImage(
                                    "images/saidattavikas-foundation.png"),),
                              ),
                            ),
                            // Positioned(
                            //   left:0.0138*width,
                            //   bottom: 0.0407*height,
                            //   child: GestureDetector(
                            //     onTap: (){
                            //       var dt = formatter.format(DateTime.parse(quotes[0].date).subtract(Duration(days: 1)));
                            //       String next = "$dt$time";
                            //       Random random = new Random();
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                            //     },
                            //     child: Text(
                            //       "Previous",
                            //       style: GoogleFonts.lobster(
                            //         fontSize: 0.066*width,
                            //         fontWeight: FontWeight.bold,
                            //         color: Style.Colors.secondary,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   right: 0.102*width,
                            //   bottom: 0.0407*height,
                            //   child: GestureDetector(
                            //     onTap: (){
                            //       var dt = formatter.format(DateTime.parse().add(Duration(days: 1)));
                            //       String next = "$dt$time";
                            //       Random random = new Random();
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(next,random.nextInt(images.length))));
                            //     },
                            //     child: Text(
                            //       "Next",
                            //       style: GoogleFonts.lobster(
                            //         fontSize: 0.066*width,
                            //         fontWeight: FontWeight.bold,
                            //         color: Style.Colors.secondary,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

}