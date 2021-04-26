import 'package:animator/animator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

class GenreQuotes extends StatefulWidget {
  final String lang;
  final String genre;

  GenreQuotes({Key key,@required this.lang,this.genre}):super(key: key);

  @override
  _GenreQuotesState createState() => _GenreQuotesState(lang,genre);
}

class _GenreQuotesState extends State<GenreQuotes> {
  final String lang;
  final String genre;

  _GenreQuotesState(this.lang,this.genre);

  @override
  void initState() {
    if(lang=="hi"){
      quoteHindiBloc..getQuotes(lang, genre);
    }
    else if(lang=="en"){
      quoteEnglishBloc..getQuotes(lang, genre);
    }
    else{
      quoteBothBloc..getQuotes(lang, genre);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(genre=="TodaysQuote"){
      if(lang=="hi"){
        return StreamBuilder<QuoteHindiResponse>(
            stream: quoteHindiBloc.subject.stream,
            builder: (context,AsyncSnapshot<QuoteHindiResponse> snapshot){
              if(snapshot.hasData){
                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                //   return buildError(snapshot.data.error);
                // }
                return _TodayBoxHindi(snapshot.data);
              }
              else if(snapshot.hasError){
                return buildError(snapshot.error);
              }
              else{
                return buildLoading();
              }
            }
        );
      }
      else if(lang=="en"){
        return StreamBuilder<QuoteEnglishResponse>(
            stream: quoteEnglishBloc.subject.stream,
            builder: (context,AsyncSnapshot<QuoteEnglishResponse> snapshot){
              if(snapshot.hasData){
                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                //   return buildError(snapshot.data.error);
                // }
                return _TodayBoxEnglish(snapshot.data);
              }
              else if(snapshot.hasError){
                return buildError(snapshot.error);
              }
              else{
                return buildLoading();
              }
            }
        );
      }
      else{
      return StreamBuilder<QuoteBothResponse>(
          stream: quoteBothBloc.subject.stream,
          builder: (context,AsyncSnapshot<QuoteBothResponse> snapshot){
            if(snapshot.hasData){
              // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
              //   return buildError(snapshot.data.error);
              // }
              return _TodayBoxBoth(snapshot.data);
            }
            else if(snapshot.hasError){
              return buildError(snapshot.error);
            }
            else{
              return buildLoading();
            }
          }
      );
    }
    }
    else{
      if(lang=="hi"){
        return StreamBuilder<QuoteHindiResponse>(
            stream: quoteHindiBloc.subject.stream,
            builder: (context,AsyncSnapshot<QuoteHindiResponse> snapshot){
              if(snapshot.hasData){
                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                //   return buildError(snapshot.data.error);
                // }
                return _QuoteBoxHindi(snapshot.data);
              }
              else if(snapshot.hasError){
                return buildError(snapshot.error);
              }
              else{
                return buildLoading();
              }
            }
        );
      }
      else if(lang=="en"){
        return StreamBuilder<QuoteEnglishResponse>(
            stream: quoteEnglishBloc.subject.stream,
            builder: (context,AsyncSnapshot<QuoteEnglishResponse> snapshot){
              if(snapshot.hasData){
                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                //   return buildError(snapshot.data.error);
                // }
                return _QuoteBoxEnglish(snapshot.data);
              }
              else if(snapshot.hasError){
                return buildError(snapshot.error);
              }
              else{
                return buildLoading();
              }
            }
        );
      }
      else{
        return StreamBuilder<QuoteBothResponse>(
            stream: quoteBothBloc.subject.stream,
            builder: (context,AsyncSnapshot<QuoteBothResponse> snapshot){
              if(snapshot.hasData){
                // if(snapshot.data.error!=0 && snapshot.data.error.length>0){
                //   return buildError(snapshot.data.error);
                // }
                return _QuoteBoxBoth(snapshot.data);
              }
              else if(snapshot.hasError){
                return buildError(snapshot.error);
              }
              else{
                return buildLoading();
              }
            }
        );
      }
    }
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
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index) {
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[index].quote,"")));
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
                            quotes[index].quote,
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
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage("",quotes[index].quote)));
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
                            quotes[index].quote,
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
      );
    }
  }

  Widget _TodayBoxHindi(QuoteHindiResponse data){
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
      return Center(
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
            child: Container(
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
                      quotes[0].quote,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _TodayBoxEnglish(QuoteEnglishResponse data){
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
      return Center(
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
            child: Container(
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
                      quotes[0].quote,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
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
      return ListView.builder(
          itemCount: quotes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index) {
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotesOnePage(quotes[index].quoteHin,quotes[index].quoteEng)));
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
                            quotes[index].quoteHin,
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
                              quotes[index].quoteEng,
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
      );
    }
  }

  Widget _TodayBoxBoth(QuoteBothResponse data){
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
      return Center(
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
                          quotes[0].quoteHin,
                          style: TextStyle(
                            fontSize: 22,
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
                          quotes[0].quoteEng,
                          style: TextStyle(
                            fontSize: 22,
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
      );
    }
  }
}
