// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:netflix/film.dart';

class Movies extends StatefulWidget {
  final List<Film> films;
  const Movies({super.key, required this.films});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Wrap(
          children: widget.films
              .map(
                (e) => Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDisplay(
                            currentMovie: e,
                          ),
                        ),
                      )
                    },
                    child: Card(
                      child: Stack(
                        children: [
                          Image.network(e.getImageUrl()),
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                color: Colors.black54,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    e.getTitle(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              child: Wrap(
                                children: [
                                  ...(e.getGenres().whereType<String>().map(
                                        (genre) => Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 1, vertical: 2),
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0xFF000000)
                                                    .withOpacity(1),
                                                offset: Offset(-3, 4),
                                                blurRadius: 14,
                                                spreadRadius: -4,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Text(
                                              genre,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          // Text("photo"),
                          // Text(e.getDate().toString()),
                          // Text(e.getOverview()),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class MovieDisplay extends StatelessWidget {
  final Film currentMovie;
  const MovieDisplay({super.key, required this.currentMovie});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.close,
            size: 30,
            color: Colors.white,
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Image.network(
                currentMovie.getImageUrl(),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black54,
                    Colors.black,
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Image(
                    image: NetworkImage(
                      currentMovie.getImageUrl(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentMovie.getRatings().toString(),
                      style: TextStyle(
                          color: currentMovie.getRatings() > 5.0
                              ? Colors.green
                              : Colors.red),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      currentMovie.getDate().year.toString(),
                      style: TextStyle(color: Colors.white54),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                              EdgeInsets.all(30),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          onPressed: () => {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              Text(
                                "PLAY",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  currentMovie.getTitle(),
                  style: TextStyle(color: Colors.white54),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      currentMovie.getOverview(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
