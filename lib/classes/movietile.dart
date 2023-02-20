import 'package:flutter/material.dart';
import 'moviemodel.dart';
import 'moviesprovider.dart';


//NEW CODE: MovieTile object to render visually appealing movie information
class MovieTile extends StatelessWidget {
  final List<MovieModel> movies;
  final index;

  const MovieTile(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          //Resizing image poster based on the screen size whenever image's path is not null.
//Resizing image poster based on the screen size whenever the image's path is not null.
          movies[index].poster_path != null
              ? Container(
            //Making image's width to half of the given screen size
            width: MediaQuery.of(context).size.width / 2,

            //Making image's height to one fourth of the given screen size
            height: MediaQuery.of(context).size.height / 4,

            //Making image box visually appealing by dropping shadow
            decoration: BoxDecoration(
              //Making image box slightly curved
              borderRadius: BorderRadius.circular(10.0),
              //Setting box's color to grey
              color: Colors.grey,

              //Decorating image
              image: DecorationImage(
                  image: NetworkImage(MoviesProvider.imagePathPrefix +
                      movies[index].poster_path),
                  //Image getting all the available space
                  fit: BoxFit.cover),

              //Dropping shadow
              boxShadow: const [
                BoxShadow(
                  //grey colored shadow
                    color: Colors.grey,
                    //Applying softening effect
                    blurRadius: 3.0,
                    //move 1.0 to right (horizontal), and 3.0 to down (vertical)
                    offset: Offset(1.0, 3.0)),
              ],
            ),
          )
              : Container(), //Empty container when image is not available
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
          ),
          //Styling movie's description text
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movies[index].overview,
            ),
          ),
          Divider(color: Colors.grey.shade500),
        ],
      ),
    );
  }
}