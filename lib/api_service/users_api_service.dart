import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api/api_models/users_model.dart';

Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<User> users = data.map((json) => User.fromJson(json)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
}
