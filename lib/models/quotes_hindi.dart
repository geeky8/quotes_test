class QuotesHindi{
  final int id;
  final String quote;
  final String date;
  final String genre;

  QuotesHindi(this.id,this.quote,this.date,this.genre);

  QuotesHindi.fromJSON( json):
      id = json["ID"],
      quote = json["QuoteHindi"],
      date = json["QuoteDate"],
      genre =  "hi";
}