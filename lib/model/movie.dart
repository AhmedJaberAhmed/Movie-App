class Movie {
  final int? id;
  final String title;
  final String backDropPath;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  bool isFavorite;

  Movie({
    this.id,
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    this.isFavorite = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? "some title",
      backDropPath: json['backdrop_path'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'backDropPath': backDropPath,
      'originalTitle': originalTitle,
      'overview': overview,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      backDropPath: map['backDropPath'],
      originalTitle: map['originalTitle'],
      overview: map['overview'],
      posterPath: map['posterPath'],
      releaseDate: map['releaseDate'],
      voteAverage: map['voteAverage'],
      isFavorite: map['isFavorite'] == 1,
    );
  }
}
