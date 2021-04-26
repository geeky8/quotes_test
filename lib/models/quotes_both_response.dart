import 'package:quotes/models/quotes_both.dart';

class QuoteBothResponse{
  final List<QuotesBoth> quotes;
  final String error;

  QuoteBothResponse(this.quotes,this.error);

  QuoteBothResponse.fromJSON(List<dynamic> json):
        quotes = json.map((e) => QuotesBoth.fromJSON(e)).toList(),
        error = ' ';
  QuoteBothResponse.withError(String errorValue):
        quotes = [],
        error = errorValue;
}