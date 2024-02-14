import 'dart:collection';

class Film {
  String title, overview;
  DateTime date;
  String imageUrl;
  double ratings;
  List<int> genres;
  Map<int, String> map = HashMap<int, String>();

  Film(
      {required this.title,
      required this.overview,
      required this.imageUrl,
      required this.date,
      required this.ratings,
      required this.genres}) {
    map.addAll({
      28: 'action',
      12: 'adventure',
      16: 'animation',
      35: 'comedy',
      80: 'crime',
      99: 'documentary',
      18: 'drama',
      10751: 'family',
      14: 'fantasy',
      36: 'history',
      27: 'horror',
      10402: 'music',
      9648: 'mystery',
      10749: 'romance',
      878: 'science-fiction',
      10770: 'TV-movie',
      53: 'thriller',
      10752: 'war',
      37: 'western'
    });
  }

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

  List<String?> getGenres() {
    return genres
        .map((key) => map.containsKey(key) ? map[key] : 'unknown')
        .toList();
  }
}
