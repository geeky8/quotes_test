class QuotesEnglish{
  final int id;
  final String quote;
  final String date;
  final String genre;

  QuotesEnglish(this.id,this.quote,this.date,this.genre);

  QuotesEnglish.fromJSON(Map<String,dynamic> json):
        id = json["ID"],
        quote = json["QuoteEn"],
        date = json["QuoteDate"],
        genre = "en";
}