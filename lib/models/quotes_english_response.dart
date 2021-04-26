import 'package:quotes/models/quotes_english.dart';

class QuoteEnglishResponse{
  final List<QuotesEnglish> quotes;
  final String error;

  QuoteEnglishResponse(this.quotes,this.error);

  QuoteEnglishResponse.fromJSON(List<dynamic> json):
        quotes = json.map((e) => QuotesEnglish.fromJSON(e)).toList(),
        error = ' ';
  QuoteEnglishResponse.withError(String errorValue):
        quotes = [],
        error = errorValue;

}