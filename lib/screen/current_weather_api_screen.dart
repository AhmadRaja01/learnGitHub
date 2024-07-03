import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final String name;

  const DetailPage({Key? key, this.name = 'Bihar'}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Map<String, dynamic>> searchData;
  final TextEditingController _searchController = TextEditingController();
  String _query = 'Bihar';

  @override
  void initState() {
    super.initState();
    searchData = fetchSearchData(_query);
  }

  Future<Map<String, dynamic>> fetchSearchData(String query) async {
    const String apiKey = 'bd39523944cd477bbbe95343240506';
    final url = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$apiKey&q=${Uri.encodeComponent(query.toLowerCase())}');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Failed to load data for $query'};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  void _onSearchSubmitted(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _query = value;
        searchData = fetchSearchData(_query);
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _query = 'Bihar';
      searchData = fetchSearchData(_query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Information',
          style: TextStyle(color: Colors.white),
        ),
        leading: BackButton(color: Colors.white),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearSearch,
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSubmitted: _onSearchSubmitted,
              onChanged: (text) {
                setState(() {});
              },
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: searchData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final searchResult = snapshot.data!;
                      if (searchResult.containsKey('error')) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Error: ${searchResult['error']}',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Location: ${searchResult['location']['name']}, ${searchResult['location']['region']}',
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Country: ${searchResult['location']['country']}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16),
                              WeatherDetailCard(
                                label: 'Temperature',
                                value: '${searchResult['current']['temp_c']}°C',
                              ),
                              WeatherDetailCard(
                                label: 'Condition',
                                value: searchResult['current']['condition']['text'],
                              ),
                              WeatherDetailCard(
                                label: 'Wind Speed',
                                value: '${searchResult['current']['wind_kph']} kph',
                              ),
                              WeatherDetailCard(
                                label: 'Pressure',
                                value: '${searchResult['current']['pressure_mb']} mb',
                              ),
                              WeatherDetailCard(
                                label: 'Humidity',
                                value: '${searchResult['current']['humidity']}%',
                              ),
                              WeatherDetailCard(
                                label: 'Feels Like',
                                value: '${searchResult['current']['feelslike_c']}°C',
                              ),
                              WeatherDetailCard(
                                label: 'Visibility',
                                value: '${searchResult['current']['vis_km']} km',
                              ),
                              SizedBox(height: 16),
                              Image.network(
                                'https:${searchResult['current']['condition']['icon']}',
                                scale: 1.5,
                              ),
                            ],
                          ),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      );
                    }
                    return Container(); // Placeholder
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherDetailCard extends StatelessWidget {
  final String label;
  final String value;

  const WeatherDetailCard({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
