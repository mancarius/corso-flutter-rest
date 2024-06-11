import 'package:corso_rest_api/model.dart';
import 'package:corso_rest_api/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  MovieList({super.key});
  List<Movie> movies = [];

  @override
  State<StatefulWidget> createState() {
    return _MovieListState();
  }
}

class _MovieListState extends State<MovieList> {

  @override
  void initState() {
    super.initState();

    MovieRepository().getAllMovies().then((value) {
      setState(() {
        widget.movies = value as List<Movie>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child:
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(widget.movies[index].imageUrl ?? ""),
                title: Text(widget.movies[index].name ?? ""),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // edit movie
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await MovieRepository().deleteMovie(widget.movies[index], "movies");

                        setState(() {
                          widget.movies.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
      ),
    );
  }
}