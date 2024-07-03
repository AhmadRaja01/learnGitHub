import 'package:flutter/material.dart';

class ForecastDayPage extends StatefulWidget {
  const ForecastDayPage({super.key});

  @override
  State<ForecastDayPage> createState() => _ForecastDayPageState();
}

class _ForecastDayPageState extends State<ForecastDayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '5-day forecast',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 20), // Space before the list
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDayCard('Yesterday', '10/6', Icons.circle,'40°C',Icons.mode_night_rounded,'13km/h'),
                  _buildDayCard('Today', '11/6', Icons.circle,'40°C',Icons.mode_night_rounded,'13km/h'),
                  _buildDayCard('Tomorrow', '12/6', Icons.circle,'40°C',Icons.mode_night_rounded,'13km/h'),
                  _buildDayCard('Thu', '13/6', Icons.circle,'40°C',Icons.mode_night_rounded,'13km/h'),
                  _buildDayCard('Fri', '14/6', Icons.circle,'40°C',Icons.mode_night_rounded,'13km/h'),
                  _buildDayCard('Sat', '15/6', Icons.circle,'40°C',Icons.mode_night_rounded,'13km/h'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard(String day, String date,IconData icon,String tempecher,IconData icon1,String airSpeed) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5), // Margin between cards
      width: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(44, 65, 160, 1),
            Color.fromRGBO(44, 65, 160, 0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Padding inside the card
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              date,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20,),
            Icon(
              icon, // Weather icon
              color: Colors.orange,
              size: 20,
            ),
            SizedBox(height: 70,),
            Text(
              tempecher,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 50,),
            Icon(
              icon1, // Weather icon
              color: Colors.orange,
              size: 20,
            ),
            SizedBox(height: 50,),
            Row(
              children: [
                Icon(Icons.play_arrow,size: 20,color: Colors.white,),
                Text(
                  airSpeed,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
