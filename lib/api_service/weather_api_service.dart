// weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String apiKey = 'bd39523944cd477bbbe95343240506';
  static const String baseUrl = 'http://api.weatherapi.com/v1';

  static Future<Map<String, dynamic>> getCurrentWeather(String location) async {
    final response = await http.get(Uri.parse('$baseUrl/current.json?key=$apiKey&q=$location'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static Future<Map<String, dynamic>> getForecast(String location, int days) async {
    final response = await http.get(Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$location&days=$days'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
