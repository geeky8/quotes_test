import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:quotes/models/quote_hindi_response.dart';
import 'package:quotes/models/quotes_both_response.dart';
import 'package:quotes/models/quotes_english_response.dart';

class QuoteRepository{
  static String mainUrl = "http://swiftinit.net:813";
  final Dio _dio = Dio();

  Future<QuoteHindiResponse> getHindiQuotes(String lang,String genre) async {
    var params = {
      "type": "hi"
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params);
      // print(response.extra);
      List map1 = json.decode(response.data);
      print(map1[0]["QuoteHindi"]);
      return QuoteHindiResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteHindiResponse.withError(error);
    }
  }
  Future<QuoteEnglishResponse> getEnglishQuotes(String lang,String genre) async {
    var params = {
      "type": "en"
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params);
      // print(response.extra);
      List map1 = json.decode(response.data);
      print(map1[0]["QuoteEn"]);
      return QuoteEnglishResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteEnglishResponse.withError(error);
    }
  }

  Future<QuoteBothResponse> getBothQuotes(String lang,String genre) async {
    var params = {
      "type": "both"
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params);
      // print(response.extra);
      List map1 = json.decode(response.data);
      print(map1[0]["QuoteHindi"]);
      print(map1[0]["QuoteEn"]);
      return QuoteBothResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteBothResponse.withError(error);
    }
  }

}