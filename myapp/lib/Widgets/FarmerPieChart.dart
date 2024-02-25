import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Screens/AgriOfficer/LoginPage.dart';

class FarmerPieChart extends StatefulWidget {
  const FarmerPieChart({super.key});

  @override
  State<FarmerPieChart> createState() => _FarmerPieChartState();
}

class _FarmerPieChartState extends State<FarmerPieChart> {
  late int registeredFarmers = 0;
  late int totalUsers = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    fetchData(); // Initial fetch
    fetchDataUsers();
    timer = Timer.periodic(const Duration(seconds: 3600), (Timer t) =>
        fetchData()); // Fetch every 30 seconds
  }

  @override
  void dispose() {
    timer
        .cancel(); // Cancel the timer when the widget is disposed to prevent memory leaks
    super.dispose();
  }


  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://bluebird-balanced-drum.ngrok-free.app/user/farmer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          // Replace $token with your JWT token
        },
      );

      if (response.statusCode == 200) {
        // Parse response and update registeredFarmers
        var data = jsonDecode(response.body);
        setState(() {
          registeredFarmers = data['farmers']
              .length; // Replace 'farmers' with the actual key in the response
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle the error here, e.g., display a message to the user
    }
  }

  Future<void> fetchDataUsers() async {
    try {
      final response = await http.get(
        Uri.parse('https://bluebird-balanced-drum.ngrok-free.app/user/all'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
          // Replace $token with your JWT token
        },
      );

      if (response.statusCode == 200) {
        // Parse response and update registeredFarmers
        var data = jsonDecode(response.body);
        setState(() {
          totalUsers = data['allUsers']
              .length; // Replace 'farmers' with the actual key in the response
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle the error here, e.g., display a message to the user
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total AgriData Users: $totalUsers ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.brown),
          ),
          SizedBox(
            width: 300,
            height: 260,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.green.shade600,
                    value: registeredFarmers.toDouble(),
                    title: 'Registered\nFarmers',
                    radius: 80,
                    titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    badgePositionPercentageOffset: 0.9, // Adjust the position of the badge
                    badgeWidget: Text(registeredFarmers.toString(), style: const TextStyle(color: Colors.black38)), // Text widget as the badge
                  ),
                  PieChartSectionData(
                    color: Colors.teal.shade200,
                    value: (totalUsers - registeredFarmers).toDouble(),
                    title: 'Other Users',
                    radius: 80,
                    titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                    badgePositionPercentageOffset: 0.2, // Adjust the position of the badge
                    badgeWidget: Text((totalUsers - registeredFarmers).toString(), style: const TextStyle(color: Colors.black38)), // Text widget as the badge
                  ),
                ],
                sectionsSpace: 2,
                centerSpaceRadius: 50,
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
