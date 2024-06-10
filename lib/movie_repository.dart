import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:corso_rest_api/model.dart';
import 'package:flutter/services.dart';

class MovieRepository {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<List<Movie?>?> getAllMovies() async {
    /// Cloud firestore fetch documentation
    /// https://firebase.google.com/docs/firestore/query-data/get-data?hl=it

    List<Movie?>? movie = await instance
        .collection("movies")
        .withConverter(
            fromFirestore: Movie.fromFirestore,
            toFirestore: (Movie movie, _) => movie.toFirestore())
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        List<Movie> result = querySnapshot.docs
            .map((docSnapshot) => docSnapshot.data())
            .toList();
        return result;
      },
      onError: (e) => print("Error completing: $e"),
    );
    return movie;
  }

  Future<void> addMovie(Movie movie, String type) async {
    CollectionReference movies = instance.collection(type);
    // Call the user's CollectionReference to add a new movie
    movies.add({
      'name': movie.name, // John Doe
      'imageUrl': movie.imageUrl // 42
    });
  }

  Future<void> addMovieFromList(List<Movie> moviesList, String type) async {
    CollectionReference movies = instance.collection(type);
    // Call the user's CollectionReference to add a new movie
    for (var movie in moviesList) {
      movies.add({
        'name': movie.name, // John Doe
        'imageUrl': movie.imageUrl // 42
      });
    }
  }

  Future<void> editMovie(Movie movie, String type) async {
    CollectionReference movies = instance.collection(type);
    // Call the user's CollectionReference to add a new movie
    movies.doc(movie.id).set(
      {
        'name': movie.name, // John Doe
        // 'imageUrl': movie.imageUrl // 42
      },
      SetOptions(merge: true),
    );
  }

  Future<void> deleteMovie(Movie movie, String type) async {
    CollectionReference movies = instance.collection(type);
    // Call the user's CollectionReference to add a new movie
    movies.doc(movie.id).delete();
  }

  Future<List<Movie>> loadMovieJsonFromAssets(String filePath) async {
    String jsonString = await rootBundle.loadString(filePath);
    var cosa = jsonDecode(jsonString);
    return List<Movie>.from(
        cosa['catalogItems'].map((model) => Movie.fromJson(model)));
  }
}
