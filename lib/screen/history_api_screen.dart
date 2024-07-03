import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  final String location;

  const HistoryPage({Key? key, this.location = 'Bihar'}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late Future<Map<String, dynamic>> historyData;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    historyData = fetchHistoryData(widget.location, _selectedDate);
    _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  Future<Map<String, dynamic>> fetchHistoryData(String location, DateTime date) async {
    final String apiKey = ' bd39523944cd477bbbe95343240506'; // Store your API key securely
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final url = Uri.parse('http://api.weatherapi.com/v1/history.json?key=$apiKey&q=${Uri.encodeComponent(location.toLowerCase())}&dt=$formattedDate');

    try {
      final response = await http.get(url).timeout(Duration(seconds: 30)); // Implement timeout for HTTP request
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load historical data for $location on $formattedDate');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void _onDateSelected(DateTime selectedDate) {
    if (selectedDate.isBefore(DateTime.now().add(Duration(days: 1)))) {
      setState(() {
        _selectedDate = selectedDate;
        historyData = fetchHistoryData(widget.location, _selectedDate);
      });
    }
  }

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000), // Start date for historical data
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      _onDateSelected(pickedDate);
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _selectedDate = DateTime.now();
      historyData = fetchHistoryData(widget.location, _selectedDate);
    });
  }

  void _cancelSelection() {
    setState(() {
      _selectedDate = DateTime.now();
      historyData = fetchHistoryData(widget.location, _selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historical Weather',
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
              readOnly: true,
              onTap: _showDatePicker,
              decoration: InputDecoration(
                hintText: 'Select date...',
                prefixIcon: Icon(Icons.calendar_today),
                suffixIcon: IconButton(
                  icon: _searchController.text.isNotEmpty ? Icon(Icons.clear) : Icon(Icons.cancel),
                  onPressed: _searchController.text.isNotEmpty ? _clearSearch : _cancelSelection,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: FutureBuilder<Map<String, dynamic>>(
                  future: historyData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      final historyResult = snapshot.data!;
                      if (historyResult.containsKey('error')) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Error: ${historyResult['error']}',
                            style: TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        final historicalDay = historyResult['forecast']['forecastday'][0];
                        return ListView(
                          children: [
                            Card(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text('Date: ${historicalDay['date']}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Max Temp: ${historicalDay['day']['maxtemp_c']}°C'),
                                    Text('Min Temp: ${historicalDay['day']['mintemp_c']}°C'),
                                    Text('Condition: ${historicalDay['day']['condition']['text']}'),
                                  ],
                                ),
                                leading: Image.network('https:${historicalDay['day']['condition']['icon']}'),
                              ),
                            ),
                          ],
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
