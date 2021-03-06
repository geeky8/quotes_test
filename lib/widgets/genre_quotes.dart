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

class GenreQuotes extends StatefulWidget {

  @override
  _GenreQuotesState createState() => _GenreQuotesState();
}

class _GenreQuotesState extends State<GenreQuotes> {

  bool onCLicked = false;

  void share(BuildContext context, String text) {
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
                      top: 0.0022 * height,
                      left: 0.031 * width,
                      child: Text(
                        quotes[index].day,
                        style: TextStyle(
                          fontFamily: "Merriweather",
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
                        date(quotes[index].date),
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
                          quotes[index].quote,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 0.0458 * width,
                            color: Style.Colors.secondary,
                            fontFamily: "Merriweather",
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
                      bottom: -(0.0054*height),
                      right: 0.0166*width,
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                EvaIcons.clipboard, color: Colors.deepOrange,),
                              iconSize: 0.0611*width,
                              onPressed: () {
                                FlutterClipboard.copy(quotes[index].quote +
                                    "\n\n~${footer1}\n${footer2}");
                                final snackbar = SnackBar(
                                  padding: EdgeInsets.only(bottom: 0.0679*height),
                                  elevation: 0.0067*height,
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
                                padding: EdgeInsets.all(0.04166*width),
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
                      top: 0.0022 * height,
                      left: 0.031 * width,
                      child: Text(
                        quotes[index].day,
                        style: TextStyle(
                          fontFamily: "Merriweather",
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
                        date(quotes[index].date),
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
                          quotes[index].quote,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 0.0402 * width,
                            color: Style.Colors.secondary,
                            fontFamily: "Merriweather",
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
                        top: 0.0022 * height,
                        left: 0.031 * width,
                        child: Text(
                          quotes[index].day,
                          style: TextStyle(
                            fontFamily: "Merriweather",
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
                          date(quotes[index].date),
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
                                quotes[index].quoteHin,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 0.0458 * width,
                                  color: Style.Colors.secondary,
                                  fontFamily: "Merriweather",
                                ),
                              ),
                              SizedBox(height: 0.0095 * height,),
                              Text(
                                quotes[index].quoteEng,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 0.0402 * width,
                                  color: Style.Colors.secondary,
                                  fontFamily: "Merriweather",
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
      return Container(
        height: height/1.402,
        child: (genre=="RandomsQuote")
            ?ListView.builder(
            itemCount: quotes.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Random random = new Random();
              int imgno = random.nextInt(images.length);
              return Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            QuotesOnePage(quotes[0].date, imgno)));
                  },
                  child: Container(
                    width: double.infinity,
                    height: height/1.502,
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
                              fontSize: 0.0343 * width,
                              color: Style.Colors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0027 * height,
                          left: 0.0138 * width,
                          child: Text(
                            quotes[index].day,
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 0.0443 * width,
                              color: Style.Colors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 0.326 * width,
                            height: 0.336 * height,
                            child: Image(image: AssetImage('images/homequote-bg.jpg'),fit: BoxFit.cover,),
                          ),
                        ),
                        Positioned(
                          top: 0.044 * height,
                          left: 0.326 * width,
                          child: Container(
                            width: width*0.564,
                            height: height*0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    quotes[index].quote,
                                    style: TextStyle(
                                      fontSize: 0.0438 * width,
                                      color: Colors.black,
                                      fontFamily: "Lexend",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -(0.022 * height),
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
                ),
              );
            }
        )
            :SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: quotes.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Random random = new Random();
                    int imgno = random.nextInt(images.length);
                    return Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  QuotesOnePage(quotes[0].date, imgno)));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 0.5617 * height,
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
                          // padding: EdgeInsets.symmetric(
                          //     vertical: 0.0135 * height, horizontal: 0.027 * width),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: 0.0203*height,
                                left: 0.0238 * width,
                                child: Text(
                                  quotes[index].day,
                                  style: TextStyle(
                                    fontFamily: "Merriweather",
                                    fontSize: 0.0463 * width,
                                    color: Style.Colors.primary,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.2337 * height,
                                right: 0.3472*width,
                                child: Text(
                                  date(quotes[index].date),
                                  style: GoogleFonts.libreBaskerville(
                                    fontSize: 0.0393 * width,
                                    color: Style.Colors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  width: width,
                                  height: 0.216 * height,
                                  child: Image(image: AssetImage('images/vikasji.jpg'),fit: BoxFit.cover,),
                                ),
                              ),
                              Positioned(
                                top: 0.284 * height,
                                child: Container(
                                  padding: EdgeInsets.only(right: 0.0833*width,left: 0.0138*width),
                                  width: width,
                                  height: height*0.20,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          quotes[index].quote,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 0.0468 * width,
                                            color: Style.Colors.secondary,
                                            fontFamily: "Merriweather",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
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
                      ),
                    );
                  }
              ),
              SizedBox(height: 0.0135*height,),
              Container(
                width: double.infinity,
                height: 0.256 * height,
                decoration: BoxDecoration(
                    color: Color(0xffE2D0C0),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),
                          offset: Offset(0.0055 * width, 0.0055 * width),
                          blurRadius: 0.0027 * width,
                          spreadRadius: 0.0055 * width),
                    ]
                ),
                margin: EdgeInsets.symmetric(horizontal: 0.027 * width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0611*height,
                      left: 0.0277*width,
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 0.25*width),
                              child: Text("Sai Mantra",style: GoogleFonts.libreBaskerville(fontSize: 0.05*width,fontWeight: FontWeight.w600,color: Style.Colors.secondary,fontStyle: FontStyle.italic),),
                            ),
                            SizedBox(height: 0.0095*height,),
                            Padding(
                              padding: EdgeInsets.only(right: 0.0388*width),
                              child: Text(
                                "Om Sai Namo Namah\nShri Sai Namo Namah\nJai Jai Sai Namo Namah\nSatguru Sai Namo Namah",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 0.0388*width,fontFamily: "Lexend",color: Style.Colors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 0.4 * width,
                        height: 0.256 * height,
                        child: Image(image: AssetImage('images/saibaba-photo.jpg'),fit: BoxFit.cover,),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height:0.0271*height),
              Padding(
                padding: EdgeInsets.only(bottom: 0.0203*height),
                child: Container(
                  width: double.infinity,
                  height: 0.256 * height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5),
                            offset: Offset(0.0055 * width, 0.0055 * width),
                            blurRadius: 0.0027 * width,
                            spreadRadius: 0.0055 * width),
                      ]
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 0.027 * width),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0.0611*height,
                        right: 0.1111*width,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right:0 ),
                                child: Text("Explore",style: GoogleFonts.libreBaskerville(fontSize: 0.05*width,fontWeight: FontWeight.w600,color: Style.Colors.secondary,fontStyle: FontStyle.italic),),
                              ),
                              SizedBox(height: 0.0095*height,),
                              Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Text(
                                  "Sai Dattavikas\nMeditation &\nCharitable Trust",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 0.0388*width,fontFamily: "Lexend",color: Style.Colors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 0.4 * width,
                          height: 0.256 * height,
                          child: Image(image: AssetImage('images/saimandir.jpg'),fit: BoxFit.cover,),
                        ),
                      ),

                    ],
                  ),
                ),
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
      return Container(
        height: height/1.402,
        child: (genre=="RandomsQuote")
          ?ListView.builder(
          itemCount: quotes.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Random random = new Random();
            int imgno = random.nextInt(images.length);
            return Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          QuotesOnePage(quotes[0].date, imgno)));
                },
                child: Container(
                  width: double.infinity,
                  height: height/1.502,
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
                        left: 0.0138 * width,
                        child: Text(
                          quotes[index].day,
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 0.0343 * width,
                            color: Style.Colors.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0027 * height,
                        right: 0.0138 * width,
                        child: Text(
                          date(quotes[index].date),
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 0.0343 * width,
                            color: Style.Colors.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 0.326 * width,
                          height: 0.336 * height,
                          child: Image(image: AssetImage('images/homequote-bg.jpg'),fit: BoxFit.cover,),
                        ),
                      ),
                      Positioned(
                        top: 0.044 * height,
                        left: 0.326 * width,
                        child: Container(
                          width: width*0.564,
                          height: height*0.5,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  quotes[index].quote,
                                  style: TextStyle(
                                    fontSize: 0.0398 * width,
                                    color: Style.Colors.secondary,
                                    fontFamily: "Merriweather",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -(0.022 * height),
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
              ),
            );
          }
      )
          :SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: quotes.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Random random = new Random();
                    int imgno = random.nextInt(images.length);
                    return Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  QuotesOnePage(quotes[0].date, imgno)));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 0.5617 * height,
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
                          // padding: EdgeInsets.symmetric(
                          //     vertical: 0.0135 * height, horizontal: 0.027 * width),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: 0.0230*height,
                                left: 0.0238 * width,
                                child: Text(
                                  quotes[index].day,
                                  style: TextStyle(
                                    fontFamily: "Merriweather",
                                    fontSize: 0.0403 * width,
                                    color: Style.Colors.primary,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.2337 * height,
                                right: 0.3472*width,
                                child: Text(
                                  date(quotes[index].date),
                                  style: GoogleFonts.libreBaskerville(
                                    fontSize: 0.0393 * width,
                                    color: Style.Colors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  width: width,
                                  height: 0.216 * height,
                                  child: Image(image: AssetImage('images/vikasji.jpg'),fit: BoxFit.cover,),
                                ),
                              ),
                              Positioned(
                                top: 0.284 * height,
                                child: Container(
                                  padding: EdgeInsets.only(right: 0.0833*width,left: 0.0138*width),
                                  width: width,
                                  height: height*0.20,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          quotes[index].quote,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 0.0408 * width,
                                            color: Style.Colors.secondary,
                                            fontFamily: "Merriweather",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
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
                      ),
                    );
                  }
              ),
              SizedBox(height: 0.0135*height,),
              Container(
                width: double.infinity,
                height: 0.256 * height,
                decoration: BoxDecoration(
                    color: Color(0xffE2D0C0),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),
                          offset: Offset(0.0055 * width, 0.0055 * width),
                          blurRadius: 0.0027 * width,
                          spreadRadius: 0.0055 * width),
                    ]
                ),
                margin: EdgeInsets.symmetric(horizontal: 0.027 * width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0611*height,
                      left: 0.0277*width,
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 0.25*width),
                              child: Text("Sai Mantra",style: GoogleFonts.libreBaskerville(fontSize: 0.05*width,fontWeight: FontWeight.w600,color: Style.Colors.secondary,fontStyle: FontStyle.italic),),
                            ),
                            SizedBox(height: 0.0095*height,),
                            Padding(
                              padding: EdgeInsets.only(right: 0.0388*width),
                              child: Text(
                                "Om Sai Namo Namah\nShri Sai Namo Namah\nJai Jai Sai Namo Namah\nSatguru Sai Namo Namah",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 0.0388*width,fontFamily: "Lexend",color: Style.Colors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 0.4 * width,
                        height: 0.256 * height,
                        child: Image(image: AssetImage('images/saibaba-photo.jpg'),fit: BoxFit.cover,),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height:0.0271*height),
              Padding(
                padding: EdgeInsets.only(bottom: 0.0203*height),
                child: Container(
                  width: double.infinity,
                  height: 0.256 * height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5),
                            offset: Offset(0.0055 * width, 0.0055 * width),
                            blurRadius: 0.0027 * width,
                            spreadRadius: 0.0055 * width),
                      ]
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 0.027 * width),
                  // padding: EdgeInsets.symmetric(horizontal: 0.027 * width),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0.0611*height,
                        right: 0.1111*width,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right:0 ),
                                child: Text("Explore",style: GoogleFonts.libreBaskerville(fontSize: 0.05*width,fontWeight: FontWeight.w600,color: Style.Colors.secondary,fontStyle: FontStyle.italic),),
                              ),
                              SizedBox(height: 0.0095*height,),
                              Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Text(
                                  "Sai Dattavikas\nMeditation &\nCharitable Trust",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 0.0388*width,fontFamily: "Lexend",color: Style.Colors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 0.4 * width,
                          height: 0.256 * height,
                          child: Image(image: AssetImage('images/saimandir.jpg'),fit: BoxFit.cover,),
                        ),
                      ),

                    ],
                  ),
                ),
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
      return Container(
        height: height/1.402,
        child: (genre=="RandomsQuote")
            ?ListView.builder(
            itemCount: quotes.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              Random random = new Random();
              int imgno = random.nextInt(images.length);
              return Container(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            QuotesOnePage(quotes[0].date, imgno)));
                  },
                  child: Container(
                    width: double.infinity,
                    height: height/1.502,
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
                          left: 0.0138 * width,
                          child: Text(
                            quotes[index].day,
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 0.0343 * width,
                              color: Style.Colors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0027 * height,
                          right: 0.0138 * width,
                          child: Text(
                            date(quotes[index].date),
                            style: GoogleFonts.libreBaskerville(
                              fontSize: 0.0343 * width,
                              color: Style.Colors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 0.326 * width,
                            height: 0.336 * height,
                            child: Image(image: AssetImage('images/homequote-bg.jpg'),fit: BoxFit.cover,),
                          ),
                        ),
                        Positioned(
                          top: 0.044 * height,
                          left: 0.326 * width,
                          child: Container(
                            width: width*0.564,
                            height: height*0.5,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    quotes[index].quoteHin,
                                    style: TextStyle(
                                      fontSize: 0.0438 * width,
                                      color: Style.Colors.secondary,
                                      fontFamily: "Lexend",
                                    ),
                                  ),
                                  SizedBox(height: 6,),
                                  Text(
                                    quotes[index].quoteEng,
                                    style: TextStyle(
                                      fontSize: 0.0438 * width,
                                      color: Style.Colors.secondary,
                                      fontFamily: "Lexend",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -(0.022 * height),
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
                                        .quoteEng}~${footer1}\n${footer2}");
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
                                            .quoteEng}~${footer1}\n${footer2}");
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
        )
            :SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: quotes.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Random random = new Random();
                    int imgno = random.nextInt(images.length);
                    return Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  QuotesOnePage(quotes[0].date, imgno)));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 0.5617 * height,
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
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: 0.0203*height,
                                left: 0.0238 * width,
                                child: Text(
                                  quotes[index].day,
                                  style: TextStyle(
                                    fontFamily: "Merriweather",
                                    fontSize: 0.0403 * width,
                                    color: Style.Colors.primary,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0.2337 * height,
                                right: 0.3472*width,
                                child: Text(
                                  date(quotes[index].date),
                                  style: GoogleFonts.libreBaskerville(
                                    fontSize: 0.0393 * width,
                                    color: Style.Colors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                child: Container(
                                  width: width,
                                  height: 0.216 * height,
                                  child: Image(image: AssetImage('images/vikasji.jpg'),fit: BoxFit.cover,),
                                ),
                              ),
                              Positioned(
                                top: 0.284 * height,
                                child: Container(
                                  padding: EdgeInsets.only(right: 0.0833*width,left: 0.0138*width),
                                  width: width,
                                  height: height*0.20,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          quotes[index].quoteHin,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 0.0468 * width,
                                            color: Style.Colors.secondary,
                                            fontFamily: "Merriweather",
                                          ),
                                        ),
                                        SizedBox(height: 0.0095*height,),
                                        Text(
                                          quotes[index].quoteEng,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 0.0388 * width,
                                            color: Style.Colors.secondary,
                                            fontFamily: "Merriweather",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
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
                                              .quoteHin}\n\n~${footer1}\n${footer2}");
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
                                                  .quoteHin}\n\n~${footer1}\n${footer2}");
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
              ),
              SizedBox(height: 0.0135*height,),
              Container(
                width: double.infinity,
                height: 0.256 * height,
                decoration: BoxDecoration(
                    color: Color(0xffE2D0C0),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),
                          offset: Offset(0.0055 * width, 0.0055 * width),
                          blurRadius: 0.0027 * width,
                          spreadRadius: 0.0055 * width),
                    ]
                ),
                margin: EdgeInsets.symmetric(horizontal: 0.027 * width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0611*height,
                      left: 0.0277*width,
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 0.25*width),
                              child: Text("Sai Mantra",style: GoogleFonts.libreBaskerville(fontSize: 0.05*width,fontWeight: FontWeight.w600,color: Style.Colors.secondary,fontStyle: FontStyle.italic),),
                            ),
                            SizedBox(height: 0.0095*height,),
                            Padding(
                              padding: EdgeInsets.only(right: 0.038*width),
                              child: Text(
                                "Om Sai Namo Namah\nShri Sai Namo Namah\nJai Jai Sai Namo Namah\nSatguru Sai Namo Namah",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 0.038*width,fontFamily: "Lexend",color: Style.Colors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 0.4 * width,
                        height: 0.256 * height,
                        child: Image(image: AssetImage('images/saibaba-photo.jpg'),fit: BoxFit.cover,),
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height:0.0271*height),
              Padding(
                padding: EdgeInsets.only(bottom: 0.0203*height),
                child: Container(
                  width: double.infinity,
                  height: 0.256 * height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5),
                            offset: Offset(0.0055 * width, 0.0055 * width),
                            blurRadius: 0.0027 * width,
                            spreadRadius: 0.0055 * width),
                      ]
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 0.027 * width),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0.0611*height,
                        right: 0.1111*width,
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right:0 ),
                                child: Text("Explore",style: GoogleFonts.libreBaskerville(fontSize: 0.05*width,fontWeight: FontWeight.w600,color: Style.Colors.secondary,fontStyle: FontStyle.italic),),
                              ),
                              SizedBox(height: 0.0095*height,),
                              Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Text(
                                  "Sai Dattavikas\nMeditation &\nCharitable Trust",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 0.038*width,fontFamily: "Lexend",color: Style.Colors.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 0.4 * width,
                          height: 0.256 * height,
                          child: Image(image: AssetImage('images/saimandir.jpg'),fit: BoxFit.cover,),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

}