import 'dart:convert';

import 'package:corso_rest_api/model.dart';
import 'package:http/http.dart' as http;

class NasaRepository {
  String apiKey = 'eWfSTys5KEjkipjJ2AfRQxq6PjhQzcfG3aiptS4Y';

  Future<List<Photo>> getCuriosityPhotos(String day) async {
    String apiUrl =
        'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=$day&api_key=$apiKey';

    // Effettua la richiesta HTTP
    final response = await http.get(Uri.parse(apiUrl));

    // Controlla lo stato della risposta
    if (response.statusCode == 200) {
      // Converti la risposta JSON in una mappa Dart
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

      // Estrai le foto dalla risposta
      final photosData = jsonData['photos'] as List<dynamic>;

      // Mappa ogni foto JSON in un oggetto Photo
      final photos =
          photosData.map((photoData) => Photo.fromJson(photoData)).toList();

      // Restituisci la lista di foto
      return photos;
    } else {
      // Se si verifica un errore, stampa un messaggio
      print('Errore durante il recupero delle foto: ${response.statusCode}');
      return [];
    }
  }
}
