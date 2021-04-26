import 'package:flutter/material.dart';
import 'package:quotes/models/quotes_both_response.dart';
import 'package:quotes/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class BothQuotesListBloc{
  final QuoteRepository _repository = QuoteRepository();
  BehaviorSubject<QuoteBothResponse> _subject = BehaviorSubject<QuoteBothResponse>();

  getQuotes(String lang,String genre) async{
    QuoteBothResponse response = await _repository.getBothQuotes(lang,genre);
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

  BehaviorSubject<QuoteBothResponse> get subject => _subject;
}

final quoteBothBloc = BothQuotesListBloc();