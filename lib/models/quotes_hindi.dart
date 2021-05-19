class QuotesHindi{
  final int id;
  final String quote;
  final String date;
  final String genre;
  final String day;

  QuotesHindi(this.id,this.quote,this.date,this.genre,this.day);

  QuotesHindi.fromJSON( json):
      id = json["Id"],
      quote = json["Quote_hi"],
      date = json["QuoteDate"],
      genre =  "hi",
      day = json["WeekDay"];
}