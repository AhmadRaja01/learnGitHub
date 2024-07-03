import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api_models/it_book_model.dart';

class ApiService {
  final String baseUrl = "https://api.itbook.store/1.0";

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/new'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['books'];
      return jsonResponse.map((book) => Book.fromJson(book)).toList();
    }
    else {
      throw Exception('Failed to load books');
    }
  }

  Future<Book> fetchBookDetail(String isbn13) async {
    final response = await http.get(Uri.parse('$baseUrl/books/$isbn13'));

    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load book');
    }
  }
}
