import 'package:flutter/material.dart';
import 'forecast_api_screen.dart';
import 'current_weather_api_screen.dart';
import 'history_api_screen.dart';

// Main List Page
class ApiList_Page extends StatefulWidget {
  const ApiList_Page({super.key});

  @override
  State<ApiList_Page> createState() => _ApiList_PageState();
}

class _ApiList_PageState extends State<ApiList_Page> {
  final List<Map<String, String>> apiInfo = [
    {'title': 'Current Weather', 'subtitle': 'Get current weather updates'},
    {'title': 'Forecast', 'subtitle': 'View weather forecast'},
    {'title': 'History', 'subtitle': 'Check past weather data'},
  ];

  void _navigateToDetail(String title) {
    if (title == 'Forecast') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForecastPage(location: title),
        ),
      );
    } else if (title == 'History') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HistoryPage(location: title),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(name: title),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.purple,
        title: Text(
          'Weather API',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: apiInfo.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              leading: Icon(
                Icons.wb_sunny,
                color: Colors.amber,
              ),
              title: Text(
                apiInfo[index]['title']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(apiInfo[index]['subtitle']!),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.purple),
              onTap: () {
                _navigateToDetail(apiInfo[index]['title']!);
              },
            ),
          );
        },
      ),
    );
  }
}
