import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:clipboard/clipboard.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:quotes/bloc/search_both_quotes_bloc.dart';
import 'package:quotes/bloc/search_english_quotes_bloc.dart';
import 'package:quotes/bloc/search_hindi_quotes_bloc.dart';
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

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final _searchController = TextEditingController();

  @override
  void initState() {
    searchQuote("vikas");
    super.initState();
  }

  void share(BuildContext context,String text){
    // final RenderBox box = context.findRenderObject();
    Share.share(text,sharePositionOrigin: Rect.fromLTWH(0, 0, 0, 0));
  }

  String date(String date){
    DateTime dt = DateTime.parse(date);
    var d = DateFormat.yMMMMd().format(dt);
    d.replaceFirst(",", "");
    return d.toString();
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFF3EFDE),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.1086*height),
          child: AppBar(
            title: Padding(padding:EdgeInsets.only(top: 0.020*height,left: 0.083*width),child: Image(image: AssetImage('images/vikasrunwalquotes.png'),)),
            backgroundColor: Style.Colors.primary,
            elevation: 0,
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
        body: Column(
          children: [
            SizedBox(height: 0.0135*height,),
            TextFormField(
              style: TextStyle(
                fontSize: 0.0388*width,
                color: Colors.black,
              ),
              controller: _searchController,
              onChanged: (String value){
                searchQuote(value);
                if(_searchController.text==null){
                  searchQuote("vikas");
                }
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: _searchController.text.length > 0? IconButton(icon: Icon(EvaIcons.backspaceOutline), onPressed: (){
                  setState(() {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _searchController.clear();
                    searchQuote(_searchController.text);
                  });
                },) :
                Icon(EvaIcons.searchOutline,color: Colors.grey[500],size: 0.0444*width,),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[100].withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[100].withOpacity(0.3),
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.only(left: 0.0416*width,right: 0.0277*width),
                labelText: "Search...",
                hintStyle: TextStyle(
                  fontSize: 0.038*width,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 0.038*width,
                  fontWeight: FontWeight.w500,
                ),
              ),
              autocorrect: false,
              autovalidate: true,
            ),
            SizedBox(height: 0.0271*height,),
            Container(
              height: MediaQuery.of(context).size.height/1.402,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (lang == "hi")
                      Container(
                        height: MediaQuery.of(context).size.height/1.402,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<QuoteHindiResponse>(
                            stream: searchHindiBloc.subject.stream,
                            builder: (context,
                                AsyncSnapshot<QuoteHindiResponse> snapshot) {
                              if (snapshot.hasData) {
                                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                                //   return buildError(snapshot.data.error);
                                // }
                                if (_QuoteBoxHindi(snapshot.data) == null || _searchController.text==null) {
                                  return Center(
                                    child: Container(
                                      width: 0.1388*width,
                                      height: 0.0679*height,
                                      child: Text("NO QUOTES"),
                                    ),
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
                          height: MediaQuery.of(context).size.height/1.402,
                          width: MediaQuery.of(context).size.width,
                          child: StreamBuilder<QuoteEnglishResponse>(
                              stream: searchEnglishBloc.subject.stream,
                              builder: (context,
                                  AsyncSnapshot<QuoteEnglishResponse> snapshot) {
                                if (snapshot.hasData) {
                                  // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                                  //   return buildError(snapshot.data.error);
                                  // }
                                  if (_QuoteBoxEnglish(snapshot.data) == null || _searchController.text==null) {
                                    return Center(
                                      child: Container(
                                        width: 0.1388*width,
                                        height: 0.0679*height,
                                        child: Text("NO QUOTES"),
                                      ),
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
                        height: MediaQuery.of(context).size.height/1.402,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<QuoteBothResponse>(
                            stream: searchBothBloc.subject.stream,
                            builder: (context,
                                AsyncSnapshot<QuoteBothResponse> snapshot) {
                              if (snapshot.hasData) {
                                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                                //   return buildError(snapshot.data.error);
                                // }
                                if (_QuoteBoxBoth(snapshot.data) == null || _searchController.text==null) {
                                  return Container(
                                    width: 0.1388*width,
                                    height: 0.0679*height,
                                    child: Text("NO QUOTES"),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _QuoteBoxHindi(QuoteHindiResponse data) {
    bool clicked = false;
    Color color = Style.Colors.primary;
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
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index) {
            Random random = new Random();
            int imgno = random.nextInt(17);
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[index].date,imgno)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(0.0055*width,0.0055*width),blurRadius: 0.0027*width,spreadRadius: 0.0055*width),
                    ]
                ),
                width: double.infinity,
                height: 0.2717*height,
                margin: EdgeInsets.symmetric(vertical:0.0135*height, horizontal: 0.027*width),
                padding: EdgeInsets.symmetric(vertical: 0.0135*height, horizontal: 0.027*width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0027*height,
                      right: 0.0138*width,
                      child: Text(
                        date(quotes[index].date),
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.033*width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0271*height,
                      left: 0.027*width,
                      child: Container(
                        width: 0.163*height,
                        height: 0.333*width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.5),blurRadius: 0.0027*width,spreadRadius: 0.0055*width,offset: Offset(0.0027*width,0.0027*width),),
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
                      top: 0.0483*height,
                      left: 0.416*width,
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.3,
                        child: Text(
                          quotes[index].quote,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 0.0458*width,
                            color: Style.Colors.secondary,
                            fontFamily: "Lexend",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.1390*height,
                        left: 0.416*width,
                        child: Text("...",style: TextStyle(fontSize: 0.1000*width,color: Colors.black54,),)
                    ),
                    Positioned(
                      top: 0.1470*height,
                      left: 0.490*width,
                      child: Text("...",style: TextStyle(fontSize: 0.0804*width,color: Colors.black45,),),
                    ),
                    Positioned(
                      top: 0.1538*height,
                      left: 0.550*width,
                      child: Text("...",style: TextStyle(fontSize: 0.0653*width,color: Colors.black26,),),
                    ),
                    Positioned(
                      bottom: -(0.0054*height),
                      right: 0.0166*width,
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(EvaIcons.clipboard,color: Colors.deepOrange,),
                              iconSize: 0.0611*width,
                              onPressed: (){
                                FlutterClipboard.copy(quotes[index].quote);
                                final snackbar = SnackBar(
                                  padding: EdgeInsets.only(bottom: 0.0679*height),
                                  elevation:0.0067*height,
                                  content: Text('Message Copied'),
                                  duration: Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      FlutterClipboard.paste().then((value) {});
                                    },
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              },
                            ),
                          ),
                          Container(
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(0.04166*width),
                                child: GestureDetector(
                                  onTap: (){
                                    share(context, "${quotes[index].quote}");
                                  },
                                  child: Image(image: AssetImage('images/share-icon.png'),),
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
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index) {
            Random random = new Random();
            int imgno = random.nextInt(images.length);
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[index].date,imgno)));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(0.0055*width,0.0055*width),blurRadius: 0.0027*width,spreadRadius: 0.0055*width),
                    ]
                ),
                width: double.infinity,
                height: 0.2717*height,
                margin: EdgeInsets.symmetric(vertical: 0.0135*height, horizontal: 0.0277*width),
                padding: EdgeInsets.symmetric(vertical: 0.0135*height, horizontal: 0.0277*width),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0.0027*height,
                      right: 0.0138*width,
                      child: Text(
                        date(quotes[index].date),
                        style: GoogleFonts.libreBaskerville(
                          fontSize: 0.033*width,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0271*height,
                      left: 0.0277*width,
                      child: Container(
                        width: 0.333*width,
                        height: 0.163*height,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7),),
                            boxShadow: [
                              BoxShadow(color: Colors.black26,blurRadius: 0.0027*width,spreadRadius: 0.0055*width,offset: Offset(0.0027*width,0.0027*width),),
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
                      top: 0.054*height,
                      left: 0.416*width,
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.3,
                        child: Text(
                          quotes[index].quote,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 0.0402*width,
                            color: Style.Colors.secondary,
                            fontFamily: "Lexend",
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0.1290*height,
                        left: 0.416*width,
                        child: Text("...",style: TextStyle(fontSize: 0.1000*width,color: Colors.black54,),)
                    ),
                    Positioned(
                      top: 0.1370*height,
                      left: 0.490*width,
                      child: Text("...",style: TextStyle(fontSize: 0.0804*width,color: Colors.black45,),),
                    ),
                    Positioned(
                      top: 0.1438*height,
                      left: 0.550*width,
                      child: Text("...",style: TextStyle(fontSize: 0.0653*width,color: Colors.black26,),),
                    ),
                    Positioned(
                      bottom: -(0.0054*height),
                      right: 0.016*width,
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(EvaIcons.clipboard,color: Colors.deepOrange,),
                              iconSize: 0.0611*width,
                              onPressed: (){
                                FlutterClipboard.copy(quotes[index].quote);
                                final snackbar = SnackBar(
                                  padding: EdgeInsets.only(bottom: 0.067*height),
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
                                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                              },
                            ),
                          ),
                          Container(
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(0.0416*width),
                                child: GestureDetector(
                                  onTap: (){
                                    share(context, "${quotes[index].quote}");
                                  },
                                  child: Image(image: AssetImage('images/share-icon.png'),),
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

  Widget _QuoteBoxBoth(QuoteBothResponse data){
    List<QuotesBoth> quotes = data.quotes;
    if(quotes.length==0) {
      return Container(
        width: 0.555*width,
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
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index) {
            Random random = new Random();
            int imgno = random.nextInt(images.length);
            return Container(
              width: double.infinity,
              child: GestureDetector(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[index].date,imgno)));
                },
                child: Container(
                  width: double.infinity,
                  height: 0.2717*height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.5),offset: Offset(0.0055*width,0.0055*width),blurRadius: 0.0027*width,spreadRadius: 0.0055*width),
                      ]
                  ),
                  margin: EdgeInsets.symmetric(vertical:0.0135*height, horizontal: 0.027*width),
                  padding: EdgeInsets.symmetric(vertical: 0.0135*height, horizontal: 0.027*width),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0.0027*height,
                        right: 0.0138*width,
                        child: Text(
                          date(quotes[index].date),
                          style: GoogleFonts.libreBaskerville(
                            fontSize: 0.0333*width,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0271*height,
                        left: 0.0277*width,
                        child: Container(
                          width: 0.333*width,
                          height: 0.163*height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(7),),
                              boxShadow: [
                                BoxShadow(color: Colors.black26,blurRadius: 0.0027*width,spreadRadius: 0.0055*width,offset: Offset(0.0027*width,0.0027*width),),
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
                        top: 0.044*height,
                        left: 0.416*width,
                        child: Container(
                          width: MediaQuery.of(context).size.width/2.3,
                          child: Column(
                            children: [
                              Text(
                                quotes[index].quoteHin,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 0.0458*width,
                                  color: Style.Colors.secondary,
                                  fontFamily: "Lexend",
                                ),
                              ),
                              SizedBox(height: 0.0095*height,),
                              Text(
                                quotes[index].quoteEng,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 0.0402*width,
                                  color: Style.Colors.secondary,
                                  fontFamily: "Lexend",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 0.1470*height,
                          left: 0.416*width,
                          child: Text("...",style: TextStyle(fontSize: 0.1000*width,color: Colors.black54,),)
                      ),
                      Positioned(
                        top: 0.1550*height,
                        left: 0.490*width,
                        child: Text("...",style: TextStyle(fontSize: 0.0804*width,color: Colors.black45,),),
                      ),
                      Positioned(
                        top: 0.1615*height,
                        left: 0.550*width,
                        child: Text("...",style: TextStyle(fontSize: 0.0653*width,color: Colors.black26,),),
                      ),
                      Positioned(
                        bottom: -(0.0054*height),
                        right: 0.0166*width,
                        child: Row(
                          children: [
                            Container(
                              child: IconButton(
                                icon: Icon(EvaIcons.clipboard,color: Colors.deepOrange,),
                                iconSize: 0.0611*width,
                                onPressed: (){
                                  FlutterClipboard.copy("${quotes[index].quoteHin}\n\n${quotes[index].quoteEng}");
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
                                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                },
                                // onPressed: (){
                                //   FlutterClipboard.copy("${quotes[index].quoteHin}\n\n${quotes[index].quoteEng}");
                                // },
                              ),
                            ),
                            Container(
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(0.0416*width),
                                  child: GestureDetector(
                                    onTap: (){
                                      share(context, "${quotes[index].quoteHin}\n\n${quotes[index].quoteEng}");
                                    },
                                    child: Image(image: AssetImage('images/share-icon.png'),),
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
}
