class Movie {
  final String poster;
  final String title;
  final String year;

  Movie({required this.title, required this.poster, required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        poster: json["Poster"],
        title: json["Title"],
        year: json["Year"]
    );
  }

}