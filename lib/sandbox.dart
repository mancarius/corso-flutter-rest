import 'package:corso_rest_api/model.dart';
import 'package:corso_rest_api/movie_repository.dart';
import 'package:corso_rest_api/nasa_repository.dart';
import 'package:flutter/material.dart';

class SandBox extends StatelessWidget {
  const SandBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          const Center(
            child: Text(
              'Sandbox',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () async {
              MovieRepository().getAllMovies();
            },
            child: const Text('Get movies'),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () async {
              MovieRepository().editMovie(
                const Movie(
                    id: '0HyYUcCNeFUZTrmSnJct',
                    name: 'Gunshy',
                    imageUrl:
                        'http://cdn0.nflximg.net/images/4478/2254478.jpg'),
                'movies',
              );
            },
            child: const Text('Edit movie'),
          ),
          const SizedBox(
            height: 12,
          ),
          ElevatedButton(
            onPressed: () async {
              final day = DateTime(2015, 6, 3);
              NasaRepository()
                  .getCuriosityPhotos('${day.year}-${day.month}-${day.day}');
            },
            child: const Text('Get Curiosity images of the day'),
          ),
        ],
      ),
    );
  }
}
