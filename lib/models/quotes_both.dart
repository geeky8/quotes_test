class QuotesBoth{
  final int id;
  final String quoteHin;
  final String quoteEng;
  final String date;
  final String genre;

  QuotesBoth(this.id,this.quoteHin,this.quoteEng,this.date,this.genre);

  QuotesBoth.fromJSON(Map<String,dynamic> json):
      id = json["Id"],
      quoteHin = json["QuoteHindi"],
      quoteEng = json["QuoteEn"],
      date = json["QuoteDate"],
      genre = "both";
}