import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ForecastPage extends StatefulWidget {
  final String location;

  const ForecastPage({Key? key, this.location = 'Bihar'}) : super(key: key);

  @override
  _ForecastPageState createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  late Future<Map<String, dynamic>> forecastData;
  DateTime _selectedDate = DateTime.now();
  String _query = 'Bihar';
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    forecastData = fetchForecastData(_query);
  }

  Future<Map<String, dynamic>> fetchForecastData(String query) async {
    const String apiKey = 'bd39523944cd477bbbe95343240506'; // Replace with your actual API key
    final url = Uri.parse('http://api.weatherapi.com/v1/forecast.json?key=$apiKey&q=${Uri.encodeComponent(query.toLowerCase())}&days=7');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {'error': 'Failed to load forecast data for $query'};
      }
    } catch (e) {
      return {'error': 'Error: $e'};
    }
  }

  void _onDateSelected(DateTime selectedDate) {
    if (selectedDate.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        selectedDate.isBefore(DateTime.now().add(Duration(days: 7)))) {
      setState(() {
        _selectedDate = selectedDate;
        forecastData = fetchForecastData(_query);
      });
    }
  }

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _onDateSelected(pickedDate);
    }
  }

  void _clearSearch() {
    setState(() {
      _textEditingController.clear();
      _selectedDate = DateTime.now();
      forecastData = fetchForecastData(_query);
    });
  }

  void _cancelSelection() {
    setState(() {
      _selectedDate = DateTime.now();
      forecastData = fetchForecastData(_query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Forecast',
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
              readOnly: true,
              onTap: _showDatePicker,
              decoration: InputDecoration(
                hintText: 'Select date...',
                prefixIcon: Icon(Icons.calendar_today),
                suffixIcon: _selectedDate != DateTime.now()
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: _cancelSelection,
                    ),
                  ],
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              controller: _textEditingController,
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: forecastData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final forecastResult = snapshot.data!;
                      if (forecastResult.containsKey('error')) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Error: ${forecastResult['error']}',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        final forecastDays = forecastResult['forecast']['forecastday'] as List<dynamic>;

                        // Find selected date's forecast and move it to the top
                        forecastDays.sort((a, b) {
                          final aDate = DateTime.parse(a['date']);
                          final bDate = DateTime.parse(b['date']);
                          if (aDate == _selectedDate) return -1;
                          if (bDate == _selectedDate) return 1;
                          return aDate.compareTo(bDate);
                        });

                        return ListView.builder(
                          itemCount: forecastDays.length,
                          itemBuilder: (context, index) {
                            final day = forecastDays[index];
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              color: DateTime.parse(day['date']).isAtSameMomentAs(_selectedDate) ? Colors.yellow[100] : null,
                              child: ListTile(
                                title: Text('Date: ${day['date']}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Max Temp: ${day['day']['maxtemp_c']}°C'),
                                    Text('Min Temp: ${day['day']['mintemp_c']}°C'),
                                    Text('Condition: ${day['day']['condition']['text']}'),
                                  ],
                                ),
                                leading: Image.network('https:${day['day']['condition']['icon']}'),
                              ),
                            );
                          },
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
