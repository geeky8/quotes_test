import 'dart:math';
import 'package:clipboard/clipboard.dart';
import 'package:intl/intl.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quotes/bloc/get_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_quotes_bloc.dart';
import 'package:quotes/elements/error.dart';
import 'package:quotes/elements/loading.dart';
import 'package:quotes/elements/quotes.dart';
import 'package:quotes/main.dart';
import 'package:quotes/models/quote_hindi_response.dart';
import 'package:quotes/models/quotes_both.dart';
import 'package:quotes/models/quotes_both_response.dart';
import 'package:quotes/models/quotes_english.dart';
import 'package:quotes/models/quotes_english_response.dart';
import 'package:quotes/models/quotes_hindi.dart';
import 'package:quotes/screens/about_screen.dart';
import 'package:quotes/screens/contact_screen.dart';
import 'package:quotes/screens/home_screen.dart';
import 'package:quotes/screens/search_screen.dart';
import 'package:quotes/style/theme.dart' as Style;
import 'package:share/share.dart';
import 'package:swipedetector/swipedetector.dart';

class QuotesOnePage extends StatefulWidget {
  static final String path = "lib/src/pages/quotes/quotes1.dart";
  final String date;
  final int imgno;

  QuotesOnePage(this.date, this.imgno);

  @override
  _QuotesOnePageState createState() => _QuotesOnePageState(date, imgno);
}

class _QuotesOnePageState extends State<QuotesOnePage>
    with SingleTickerProviderStateMixin {
  final String date;
  final int imgno;
  _QuotesOnePageState(this.date, this.imgno);
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String time = "T00:00:00";
  ScrollController scrollController;
  String quote;

  void state(String value){
    setState(() {
      quote=  value;
    });
  }

  String getDate(String date) {
    DateTime dt = DateTime.parse(date);
    var d = DateFormat.yMMMMd().format(dt);
    d.replaceFirst(",", "");
    return d.toString();
  }

  void share(BuildContext context, String text) {
    Share.share(text, sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0));
  }

  @override
  void initState() {
    setState(() {
      genre = "YearQuote";
    });
    setQuote();
    scrollController = new ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _willpop() {
    if(cal!=1){
      setState(() {
        genre = quotesDay[ind]["title"];
      });
      setQuote();
      Navigator.of(context).pop(true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    else{
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(bottom: 30),
            child: Scaffold(
              backgroundColor: Color(0xFFF3EFDE),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(0.1086 * height),
                child: AppBar(
                  title: Padding(
                      padding: EdgeInsets.only(
                          top: 0.018 * height, left: 0.108 * width),
                      child: Image(
                        image: AssetImage('images/vikasrunwalquotes.png'),
                      )),
                  backgroundColor: Style.Colors.primary,
                  elevation: 5,
                  leading: Padding(
                    padding: EdgeInsets.only(top: 0.020 * height, left: 0),
                    child: IconButton(
                      icon: Icon(
                        EvaIcons.arrowBack,
                        color: Colors.white,
                      ),
                      iconSize: 0.077 * width,
                      onPressed: () {
                        setState(() {
                          genre = quotesDay[ind]["title"];
                        });
                        setQuote();
                        Navigator.of(context).pop(true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                    ),
                  ),
                ),
              ),
              body: WillPopScope(
                onWillPop: _willpop,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0135 * height),
                    child: SwipeDetector(
                      onSwipeLeft: () {
                        var dt = formatter.format(
                            DateTime.parse(date).add(Duration(days: 1)));
                        String next = "$dt$time";
                        Random random = new Random();
                        if (formatter.format(DateTime.parse(date)) !=
                            formatter.format(DateTime.now())) {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: QuotesOnePage(
                                      next, random.nextInt(images.length)),
                                  type: PageTransitionType.rightToLeft,
                                  duration: Duration(milliseconds: 400),
                                  alignment: Alignment.centerRight,
                              ));
                        }
                      },
                      onSwipeRight: () {
                        var dt = formatter.format(
                            DateTime.parse(date).subtract(Duration(days: 1)));
                        String next = "$dt$time";
                        Random random = new Random();
                        Navigator.push(
                          context,
                          PageTransition(
                            child: QuotesOnePage(
                                next, random.nextInt(images.length)),
                            type: PageTransitionType.leftToRight,
                            duration: Duration(milliseconds: 400),
                            alignment: Alignment.centerRight,
                          ),);
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 1.312,
                        child: ListView(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 0.057*height,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          child: IconButton(
                                            icon: Icon(EvaIcons.clipboard,
                                              color: Colors.deepOrange,),
                                            iconSize: 0.0611 * width,
                                            onPressed: () {
                                              FlutterClipboard.copy("${quote}\n\n~${footer1}\n${footer2}");
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
                                        padding:
                                            EdgeInsets.only(right: 0),
                                        child: Container(
                                          child: Text(
                                            getDate(date),
                                            style: GoogleFonts.libreBaskerville(
                                              fontSize: 0.0472 * width,
                                              color: Style.Colors.secondary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Container(
                                          child: InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.all(0.0216 * width),
                                              child: GestureDetector(
                                                onTap: () {
                                                  share(context, "${quote}\n\n~${footer1}\n${footer2}");
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
                                ),
                                SizedBox(
                                  height: 0.0107 * height,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 0.269 * height,
                                  child: Image(
                                    image: AssetImage(
                                        "images/baba-pic${imgno + 1}-big.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.0035 * height,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 0.138 * width,
                                      height: 0.0479 * height,
                                      child: Image(
                                        image:
                                            AssetImage('images/quotation.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 0.0135 * height,
                                    // ),
                                    Container(
                                      // height: 0.4076 * height,
                                      width: width,
                                      child: Padding(
                                        padding: EdgeInsets.all(0.0114*width),
                                        child: Column(
                                          children: [
                                            if (lang == "hi")
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: StreamBuilder<
                                                        QuoteHindiResponse>(
                                                    stream: quoteHindiBloc
                                                        .subject.stream,
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuoteHindiResponse>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                                                        //   return buildError(snapshot.data.error);
                                                        // }
                                                        if (_QuoteBoxHindi(
                                                                snapshot
                                                                    .data) ==
                                                            null) {
                                                          return buildLoading();
                                                        } else {
                                                          return _QuoteBoxHindi(
                                                              snapshot.data);
                                                        }
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return buildError(
                                                            snapshot.error);
                                                      } else {
                                                        return buildLoading();
                                                      }
                                                    }),
                                              )
                                            else if (lang == "en")
                                              Container(
                                                  width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  child: StreamBuilder<
                                                          QuoteEnglishResponse>(
                                                      stream: quoteEnglishBloc
                                                          .subject.stream,
                                                      builder: (context,
                                                          AsyncSnapshot<
                                                                  QuoteEnglishResponse>
                                                              snapshot) {
                                                        if (snapshot
                                                            .hasData) {
                                                          // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                                                          //   return buildError(snapshot.data.error);
                                                          // }
                                                          if (_QuoteBoxEnglish(
                                                                  snapshot
                                                                      .data) ==
                                                              null) {
                                                            return buildLoading();
                                                          } else {
                                                            return _QuoteBoxEnglish(
                                                                snapshot
                                                                    .data);
                                                          }
                                                        } else if (snapshot
                                                            .hasError) {
                                                          return buildError(
                                                              snapshot.error);
                                                        } else {
                                                          return buildLoading();
                                                        }
                                                      }))
                                            else
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                // height: 300,
                                                child: StreamBuilder<
                                                        QuoteBothResponse>(
                                                    stream: quoteBothBloc
                                                        .subject.stream,
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                QuoteBothResponse>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                                                        //   return buildError(snapshot.data.error);
                                                        // }
                                                        if (_QuoteBoxBoth(
                                                                snapshot
                                                                    .data) ==
                                                            null) {
                                                          return buildLoading();
                                                        } else {
                                                          return _QuoteBoxBoth(
                                                              snapshot.data);
                                                        }
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return buildError(
                                                            snapshot.error);
                                                      } else {
                                                        return buildLoading();
                                                      }
                                                    }),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    Container(
                                      width: 0.777 * width,
                                      height: 0.1517 * height,
                                      // decoration: BoxDecoration(color: Colors.black),
                                      child: formatter.format(DateTime.parse(date))==formatter.format(DateTime.now())
                                          ?Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0.0271 * height,
                                            child: Container(
                                              // decoration: BoxDecoration(color: Colors.white),
                                              width: 0.227 * width,
                                              height: 0.105 * height,
                                              child: Image(
                                                image: AssetImage(
                                                    "images/saidattavikas-foundation.png"),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 0.0555*width,
                                            right: 0,
                                            bottom: 0.0307 * height,
                                            child: GestureDetector(
                                              onTap: () {
                                                var dt = formatter.format(
                                                    DateTime.parse(date)
                                                        .subtract(
                                                        Duration(days: 1)));
                                                String next = "$dt$time";
                                                Random random = new Random();
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: QuotesOnePage(
                                                        next, random.nextInt(images.length)),
                                                    type: PageTransitionType.leftToRight,
                                                    duration: Duration(milliseconds: 400),
                                                    alignment: Alignment.centerRight,
                                                  ),);
                                              },
                                              child: Text(
                                                "Previous",
                                                style: GoogleFonts.libreBaskerville(
                                                  fontSize: 0.049 * width,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  color: Style.Colors.secondary,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Positioned(
                                          //     right: 0.102 * width,
                                          //     bottom: 0.0407 * height,
                                          //     child: GestureDetector(
                                          //       onTap: () {
                                          //         var dt = formatter.format(
                                          //             DateTime.parse(date).add(
                                          //                 Duration(days: 1)));
                                          //         String next = "$dt$time";
                                          //         Random random = new Random();
                                          //         if (formatter.format(DateTime.parse(date)) !=
                                          //             formatter.format(DateTime.now())) {
                                          //           Navigator.push(
                                          //               context,
                                          //               PageTransition(
                                          //                 child: QuotesOnePage(
                                          //                     next, random.nextInt(images.length)),
                                          //                 type: PageTransitionType.rightToLeft,
                                          //                 duration: Duration(milliseconds: 400),
                                          //                 alignment: Alignment.centerRight,
                                          //               ));
                                          //         }
                                          //       },
                                          //       child: Text(
                                          //         "Next",
                                          //         style: GoogleFonts.lobster(
                                          //           fontSize: 0.066 * width,
                                          //           fontWeight: FontWeight.bold,
                                          //           color: Style.Colors.secondary,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                        ],
                                      )
                                          :Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0.0271 * height,
                                            child: Container(
                                              // decoration: BoxDecoration(color: Colors.white),
                                              width: 0.327 * width,
                                              height: 0.135 * height,
                                              child: Image(
                                                image: AssetImage(
                                                    "images/saidattavikas-foundation.png"),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // left: 0.0138 * width,
                                            // bottom: 0.0407 * height,
                                            left:0.0277*width,
                                            bottom: 0.0407 * height,
                                            child: GestureDetector(
                                              onTap: () {
                                                var dt = formatter.format(
                                                    DateTime.parse(date)
                                                        .subtract(
                                                        Duration(days: 1)));
                                                String next = "$dt$time";
                                                Random random = new Random();
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    child: QuotesOnePage(
                                                        next, random.nextInt(images.length)),
                                                    type: PageTransitionType.leftToRight,
                                                    duration: Duration(milliseconds: 400),
                                                    alignment: Alignment.centerRight,
                                                  ),);
                                              },
                                              child: Text(
                                                "Previous",
                                                style: GoogleFonts.libreBaskerville(
                                                  fontSize: 0.049 * width,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  color: Style.Colors.secondary,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            // right: 0.102 * width,
                                            // bottom: 0.0407 * height,
                                            right: 0.0793*width,
                                            bottom: 0.0407 * height,
                                            child: GestureDetector(
                                              onTap: () {
                                                var dt = formatter.format(
                                                    DateTime.parse(date).add(
                                                        Duration(days: 1)));
                                                String next = "$dt$time";
                                                Random random = new Random();
                                                if (formatter.format(DateTime.parse(date)) !=
                                                    formatter.format(DateTime.now())) {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                        child: QuotesOnePage(
                                                            next, random.nextInt(images.length)),
                                                        type: PageTransitionType.rightToLeft,
                                                        duration: Duration(milliseconds: 400),
                                                        alignment: Alignment.centerRight,
                                                      ));
                                                }
                                              },
                                              child: Text(
                                                "Next",
                                                style: GoogleFonts.libreBaskerville(
                                                  fontSize: 0.049 * width,
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  color: Style.Colors.secondary,
                                                ),
                                              ),
                                            ),
                                          ),
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
        if ((quotes[i].date).substring(0, 10) ==
            formatter.format(DateTime.parse(date))) {
          quote= quotes[i].quote;
          return Padding(
            padding: EdgeInsets.only(top: 0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: 0.0135 * height, horizontal: 0.0277 * width),
              child: Column(
                children: <Widget>[
                  Text(
                    quotes[i].quote,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 0.05 * width,
                      color: Style.Colors.secondary,
                      fontFamily: "Lexend",
                    ),
                  ),
                ],
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
        if ((quotes[i].date).substring(0, 10) ==
            formatter.format(DateTime.parse(date))) {
          quote= quotes[i].quote;
          return Padding(
            padding: EdgeInsets.only(top: 0.0135 * height),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                  vertical: 0.0135 * height),
              padding: EdgeInsets.symmetric(
                  vertical: 0.0135 * height, horizontal: 0.0277 * width),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      quotes[i].quote,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 0.0448 * width,
                        color: Style.Colors.secondary,
                        fontFamily: "Merriweather",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
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
        if ((quotes[i].date).substring(0, 10) ==
            formatter.format(DateTime.parse(date))) {
          quote = "${quotes[i].quoteHin}\n\n${quotes[i].quoteEng}";
          return Padding(
            padding: EdgeInsets.only(top: 0.0135 * height),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 0.903 * width,
                    child: Text(
                      quotes[i].quoteHin,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 0.048 * width,
                        color: Style.Colors.secondary,
                        fontFamily: "Lexend",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.0081 * height,
                  ),
                  Container(
                    width: 0.903 * width,
                    child: Text(
                      quotes[i].quoteEng,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 0.0442 * width,
                        color: Style.Colors.secondary,
                        fontFamily: "Lexend",
                      ),
                    ),
                  ),
                ],
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

