import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'api/api.dart';

//App level widget
class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //movie listing stateful widget
      home: MoviesListing(),
    );
  }
}

class MoviesProvider {
  static final String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  //Returns JSON formatted response as Map
  static Future<Map> getJson() async {
    const apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc";
    final apiResponse = await http.get(Uri.parse(apiEndPoint));
    return json.decode(apiResponse.body);
  }
}

class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  var movies;

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    //Updating data and requesting to rebuild widget
    setState(() {
      //storing movie list in `movies` variable
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    //Request to fetch movies
    fetchMovies();

    return Scaffold(
      //NEW CODE: Rendering movies in ListView
      body: ListView.builder(
        itemCount: movies == null ? 0 : movies.length,
        itemBuilder: (context, index) {
          return Padding(
            //Adding padding around the list row
            padding: const EdgeInsets.all(8.0),

            //Displaying title of the movie only for now
            child: Text(movies[index]["title"]),
          );
        },
      ),
      //ENDS
    );
  }
}
