class QuotesEnglish{
  final int id;
  final String quote;
  final String date;
  final String genre;
  final String day;

  QuotesEnglish(this.id,this.quote,this.date,this.genre,this.day);

  QuotesEnglish.fromJSON(Map<String,dynamic> json):
        id = json["Id"],
        quote = json["Quote_en"],
        date = json["QuoteDate"],
        genre = "en",
        day = json["WeekDay"];
}