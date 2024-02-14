import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix/film.dart';
import 'package:netflix/movies.dart';
import 'package:http/http.dart' as http;

List<Film> films = [];

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void handleSearch(String s) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MGVmNjhmOTM0NDNjOTlmYjVkYWFlMTI5NDNkNDRmNyIsInN1YiI6IjY1Y2IxMzkxODliNTYxMDE4NDY5MWJjMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xpMUEiB46CWZws76Gk224GfU1MZL19upxoGfXqmM9lA'
    };
    var request = http.Request('GET',
        Uri.parse('https://api.themoviedb.org/3/search/movie?query=${s}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      var results = jsonResponse['results'];
      List<Film> film = [];
      for (var result in results) {
        var overview = result['overview'];
        var title = result['title'];
        var posterPath = result['poster_path'];
        var popularity = result['popularity'];
        var releaseDate = result['release_date'];
        var voteAverage = result['vote_average'];
        var genres = result['genre_ids'];
        // @see https://stackoverflow.com/questions/69071090/uncaught-in-promise-error-expected-a-value-of-type-listdynamic-but-got-o
        var convertedGenres = List<int>.from(genres);

        film.add(Film(
            title: title,
            overview: overview,
            date: DateTime.parse(releaseDate),
            ratings: voteAverage,
            imageUrl: posterPath,
            genres: convertedGenres));
      }

      setState(() {
        films = film;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                    "https://image.tmdb.org/t/p/w500/wwemzKWzjKYJFfCeiB57q3r4Bcm.png"),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(borderRadius: BorderRadius.zero),
              child: SearchBar(
                hintText: "Exemple : Pokemon",
                trailing: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ],
                shape:
                    MaterialStateProperty.all(const RoundedRectangleBorder()),
                backgroundColor: MaterialStateProperty.all(Colors.black),
                textStyle:
                    MaterialStateProperty.all(TextStyle(color: Colors.white70)),
                hintStyle:
                    MaterialStateProperty.all(TextStyle(color: Colors.white70)),
                onSubmitted: handleSearch,
              ),
            ),
            Expanded(
              child: Movies(
                films: films,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
