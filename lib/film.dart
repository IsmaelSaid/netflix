class Film {
  String title, overview;
  DateTime date;
  String imageUrl;
  double ratings;

  Film(
      {required this.title,
      required this.overview,
      required this.imageUrl,
      required this.date,
      required this.ratings});

  String getTitle() {
    return title;
  }

  String getOverview() {
    return overview;
  }

  DateTime getDate() {
    return date;
  }

  String getImageUrl() {
    return 'https://image.tmdb.org/t/p/w500/${imageUrl}';
  }

  double getRatings() {
    return ratings;
  }
}
