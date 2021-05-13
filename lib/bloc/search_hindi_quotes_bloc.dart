import 'package:flutter/material.dart';
import 'package:quotes/models/quote_hindi_response.dart';
import 'package:quotes/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchHindiQuotesBloc{
  final QuoteRepository _repository = QuoteRepository();
  BehaviorSubject<QuoteHindiResponse> _subject = BehaviorSubject<QuoteHindiResponse>();

  getQuotes(String lang,String genre,String keyword) async{
    QuoteHindiResponse response = await _repository.searchHindiQuotes(lang,genre,keyword);
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

  BehaviorSubject<QuoteHindiResponse> get subject => _subject;
}

final searchHindiBloc = SearchHindiQuotesBloc();