import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes/bloc/get_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_english_quotes_bloc.dart';
import 'package:quotes/bloc/get_hindi_quotes_bloc.dart';
import 'package:quotes/bloc/search_both_quotes_bloc.dart';
import 'package:quotes/bloc/search_english_quotes_bloc.dart';
import 'package:quotes/bloc/search_hindi_quotes_bloc.dart';
import 'package:quotes/screens/splash_screen.dart';


String lang = "en";
String genre = "TodaysQuote";
double height = 0;
double width = 0;
int ind = 0;
int year = 2021;
String footer1 = "SAI DATTA VIKAS\nMEDITATION AND CHARTITABLE TRUST";
String footer2 = "By Vikas Runwal";
String number = "+91";
bool validate = false;
int cal=0;

void setQuote(){
  if(lang=="en" ){
    quoteHindiBloc..dispose();
    quoteBothBloc..dispose();
    quoteEnglishBloc..getQuotes(lang, genre);

  }
  else if(lang=="hi"){
    quoteEnglishBloc..dispose();
    quoteBothBloc..dispose();
    quoteHindiBloc..getQuotes(lang, genre);
  }
  else{
    quoteHindiBloc..dispose();
    quoteEnglishBloc..dispose();
    quoteBothBloc..getQuotes(lang, genre);
  }
}

void searchQuote(String keyword){
  if(lang=="en" ){
    searchHindiBloc..dispose();
    searchBothBloc..dispose();
    searchEnglishBloc..getQuotes(lang, genre,keyword);

  }
  else if(lang=="hi"){
    searchEnglishBloc..dispose();
    searchBothBloc..dispose();
    searchHindiBloc..getQuotes(lang, genre,keyword);
  }
  else{
    searchHindiBloc..dispose();
    searchEnglishBloc..dispose();
    searchBothBloc..getQuotes(lang, genre,keyword);
  }
}



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
