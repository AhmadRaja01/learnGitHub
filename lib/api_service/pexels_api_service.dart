import 'dart:convert';
import 'package:http/http.dart' as http;

class PexelsApiService {
  final String _apiKey = 'A0eK8KmzoS9zWIxn5OSSdurlTr3sNRvbI1tbleal6exoeIgHidvRp4Lw';
  final String _baseUrl = 'https://api.pexels.com/videos';

  Future<Map<String, dynamic>> getPopularVideos({int perPage = 15, int page = 1}) async {
    final String url = '$_baseUrl/popular?per_page=$perPage&page=$page';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': _apiKey,
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load videos');
    }
  }
  Future<Map<String, dynamic>> searchVideos(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search?query=$query'),
      headers: {'Authorization': _apiKey},
    );
    return json.decode(response.body);
  }
}
