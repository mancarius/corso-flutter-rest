import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String? id;
  final String? name;
  final String? imageUrl;

  const Movie({this.id, required this.name, required this.imageUrl});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  factory Movie.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Movie(
      id: snapshot.id,
      name: data?['name'],
      imageUrl: data?['imageUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (imageUrl != null) "imageUrl": imageUrl,
    };
  }
}

class Photo {
  final int id;
  final int sol;
  final String imgUrl;
  final String camera;

  Photo(
      {required this.id,
      required this.sol,
      required this.imgUrl,
      required this.camera});

  // Metodo fromJson per creare un'istanza di Photo da una mappa JSON
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      sol: json['sol'] as int,
      imgUrl: json['img_src'] as String,
      camera: json['camera']['name'] as String,
    );
  }
}
