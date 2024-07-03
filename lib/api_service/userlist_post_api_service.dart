import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api/api_models/userlist_post_model.dart';

Future<UserPost> createUser(String name, String job) async {
  final response = await http.post(
    Uri.parse('https://reqres.in/api/users'), // Replace with your API endpoint
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(UserPost(name: name, job: job).toJson()),
  );

  if (response.statusCode == 201) {
    return UserPost.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user');
  }
}
