import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//MovieApp stateless widget at app level
class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //Adding movie listing widget as app's home screen
      home: MoviesListing(),
    );
  }
}



//Movie listing widget
class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

//State object
class _MoviesListingState extends State<MoviesListing> {
  var movies;
  static const String imagePathPrefix = 'https://image.tmdb.org/t/p/w500/';

  //REPLACE: Replace YOUR_API_KEY with your API key
  // static const apiKey = "YOUR_API_KEY";

  //Returning JSON data as Map
  static Future<Map> getJson() async {
    const apiEndPoint =
        "http://api.themoviedb.org/3/discover/movie?api_key=$apiKey&sort_by=popularity.desc";
    final apiResponse = await http.get(apiEndPoint);
    return json.decode(apiResponse.body);
  }
  fetchMovies() async {
    var data = await getJson();

    //Updating movies variable with fresh data
    setState(() {
      movies = data['results'];
    });
  }

  //Building main screen
  @override
  Widget build(BuildContext context) {
    //Calling method to fetch movies
    fetchMovies();

    return Scaffold(
      body: SingleChildScrollView(
        //Displaying JSON response data in plain text on main screen
        child: movies != null
            ? Text("Challenge Completed!🤩")
            : const Text("Loading api response"),
      ),
    );
  }
}
