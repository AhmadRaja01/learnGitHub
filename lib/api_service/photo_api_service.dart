import 'dart:convert';
import 'package:api/api_models/photos_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$_baseUrl/photos'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Photo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}
