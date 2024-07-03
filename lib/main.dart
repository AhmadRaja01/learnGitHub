import 'package:api/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service/customer_api_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CustomerApiServices()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  PhotoListPage(),
      theme: ThemeData(primaryColor: Colors.purple),
    );
  }
}
