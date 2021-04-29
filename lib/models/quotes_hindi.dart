class QuotesHindi{
  final int id;
  final String quote;
  final String date;
  final String genre;

  QuotesHindi(this.id,this.quote,this.date,this.genre);

  QuotesHindi.fromJSON( json):
      id = json["Id"],
      quote = json["Quote_hi"],
      date = json["QuoteDate"],
      genre =  "hi";
}