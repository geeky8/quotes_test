import 'package:quotes/models/quotes_hindi.dart';

class QuoteHindiResponse{
  final List<QuotesHindi> quotes;
  final String error;

  QuoteHindiResponse(this.quotes,this.error);

  QuoteHindiResponse.fromJSON(List<dynamic> json):
      quotes = json.map((e) => QuotesHindi.fromJSON(e)).toList(),
      error = ' ';
  QuoteHindiResponse.withError(String errorValue):
      quotes = [],
      error = errorValue;
}