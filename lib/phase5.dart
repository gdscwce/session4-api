import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api/api.dart';
import 'classes/moviesprovider.dart';
import 'classes/moviemodel.dart';
import 'classes/movietile.dart';
class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MoviesListing(),
    );
  }
}



class MoviesListing extends StatefulWidget {
  @override
  _MoviesListingState createState() => _MoviesListingState();
}

class _MoviesListingState extends State<MoviesListing> {
  List<MovieModel> movies = <MovieModel>[];

  fetchMovies() async {
    var data = await MoviesProvider.getJson();

    setState(() {
      List<dynamic> results = data['results'];

      //Creating list of MovieModel objects
      results.forEach((element) {
        movies.add(
          MovieModel.fromJson(element),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchMovies();

    return Scaffold(
      body: ListView.builder(
        //Calculating list size
        itemCount: movies == null ? 0 : movies.length,
        //Building list view entries
        itemBuilder: (context, index) {
          return Padding(
            //Padding around the list item
            padding: const EdgeInsets.all(8.0),
            //UPDATED CODE: Using MovieTile object to render movie's title, description and image


           child:
           // MovieTile(movies,index)
           Card(
              child: ListTile(
                leading: Container(
                  child: Image(
                    image: NetworkImage("https://image.tmdb.org/t/p/w500/${movies[index].poster_path}",scale: 5),
                  ),
                  height:200 ,
                ),
              title: Text(movies[index].title),
              subtitle: Text(movies[index].overview),
              ),

          )
          );
        },
      ),
    );
  }
}




