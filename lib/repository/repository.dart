import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:quotes/main.dart';
import 'package:quotes/models/quote_hindi_response.dart';
import 'package:quotes/models/quotes_both_response.dart';
import 'package:quotes/models/quotes_english_response.dart';

class QuoteRepository{
  static String mainUrl = "http://swiftinit.net:813";
  final String apikey  =  "asQwe89Example@345TokenKey14587";
  final Dio _dio = Dio();

  Future<QuoteHindiResponse> getHindiQuotes(String lang,String genre) async {
    var params = (genre!="YearQuote")
        ?{
          "type": "hi"
        }
        :{
          "type":"hi",
          "quoteYear":year
        };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params,options: Options(headers: {
        "X-API-Key": "asQwe89Example@345TokenKey14587"
      },));
      List map1 = json.decode(response.data);
      return QuoteHindiResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteHindiResponse.withError(error);
    }
  }
  Future<QuoteEnglishResponse> getEnglishQuotes(String lang,String genre) async {
    var params = (genre!="YearQuote")
        ?{
      "type": "en"
    }
        :{
      "type":"en",
      "quoteYear":year
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params,options:Options(headers: {
        "X-API-Key": "asQwe89Example@345TokenKey14587"
      },));
      List map1 = json.decode(response.data);
      return QuoteEnglishResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteEnglishResponse.withError(error);
    }
  }

  Future<QuoteBothResponse> getBothQuotes(String lang,String genre) async {
    var params = (genre!="YearQuote")
        ?{
      "type": "both"
    }
        :{
      "type":"both",
      "quoteYear":year
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params,options: Options(headers: {
        "X-API-Key": "asQwe89Example@345TokenKey14587"
      },));
      List map1 = json.decode(response.data);
      return QuoteBothResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteBothResponse.withError(error);
    }
  }

  Future<QuoteHindiResponse> searchHindiQuotes(String lang,String genre,String keyword) async {
    var params = {
      "type": "hi",
      "keyword":keyword,
      "delimiterChar":"%2C"
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params,options: Options(headers: {
        "X-API-Key": "asQwe89Example@345TokenKey14587"
      },));
      List map1 = json.decode(response.data);
      return QuoteHindiResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteHindiResponse.withError(error);
    }
  }

  Future<QuoteEnglishResponse> searchEnglishQuotes(String lang,String genre,String keyword) async {
    var params = {
      "type": "en",
      "keyword":keyword,
      "delimiterChar":"%2C"
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params,options: Options(headers: {
        "X-API-Key": "asQwe89Example@345TokenKey14587"
      },));
      List map1 = json.decode(response.data);
      return QuoteEnglishResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteEnglishResponse.withError(error);
    }
  }

  Future<QuoteBothResponse> searchBothQuotes(String lang,String genre,String keyword) async {
    var params = {
      "type": "both",
      "keyword":keyword,
      "delimiterChar":"%2C"
    };
    try {
      Response response =
      await _dio.get("$mainUrl/$genre", queryParameters: params,options: Options(headers: {
        "X-API-Key": "asQwe89Example@345TokenKey14587"
      },));
      List map1 = json.decode(response.data);
      return QuoteBothResponse.fromJSON(map1);
    } catch (error, stacktrace) {
      print("Exception occured : $error stacktrace: $stacktrace");
      return QuoteBothResponse.withError(error);
    }
  }
}