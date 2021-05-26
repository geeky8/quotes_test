import 'package:flutter/material.dart';
import 'package:quotes/models/quotes_english_response.dart';
import 'package:quotes/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class EnglishQuotesListBloc{
  final QuoteRepository _repository = QuoteRepository();
  BehaviorSubject<QuoteEnglishResponse> _subject = BehaviorSubject<QuoteEnglishResponse>();

  getQuotes(String lang,String genre) async{
    QuoteEnglishResponse response = await _repository.getEnglishQuotes(lang,genre);
    _subject.sink.add(response);
  }
  void drainStream(){
    _subject.value;
  }
  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<QuoteEnglishResponse> get subject => _subject;
}

final quoteEnglishBloc = EnglishQuotesListBloc();