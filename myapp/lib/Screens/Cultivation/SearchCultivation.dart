import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Home/HomePage.dart';
import '../AgriOfficer/LoginPage.dart';

class SearchCultivationPage extends StatefulWidget {
  const SearchCultivationPage({Key? key}) : super(key: key);

  @override
  State<SearchCultivationPage> createState() => _SearchCultivationPageState();
}

class _SearchCultivationPageState extends State<SearchCultivationPage> {

  TextEditingController farmId = TextEditingController();
  TextEditingController cropId = TextEditingController();
  TextEditingController agriYear = TextEditingController();
  TextEditingController quarter = TextEditingController();
  List<dynamic> _cultivationRecords = [];
  // List<Map<String, dynamic>> _farmRecords = [];


  Future<void> searchCultivations(String endpoint) async {
    final Uri uri = Uri.parse(endpoint);

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['data'];
      if (data.isEmpty) {

        setState(() {
          _cultivationRecords = []; // Set _farmRecords to an empty list
        });
        Fluttertoast.showToast(
          msg: "No result found by your search !",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black12,
          textColor: Colors.green,
          fontSize: 16.0,);

      } else {
        List<dynamic> formattedData = data.map((item) {
          return {
            'farm_id': item['farm_id'],
            'crop_id': item['crop_id'],
            'cultivation_info_id': item['cultivation_info_id'],
            'display_name': item['display_name'],
            'agri_year': item['agri_year'],
            'quarter': item['quarter'],
            'started_date': item['started_date'],
            'harvested_date': item['harvested_date'],
            'harvested_amount': item['harvested_amount'],
            'estimated_harvest': item['estimated_harvest'],

          };
        }).toList();

        setState(() {
          _cultivationRecords = formattedData;
        });
      }

    }else{
      Fluttertoast.showToast(
        msg: response.body.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black12,
        textColor: Colors.brown,
        fontSize: 16.0,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Cultivation Records",
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.teal.shade200,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomePage()),
            );          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: farmId,
              decoration: const InputDecoration(labelText: 'Farm Id',prefixIcon: Icon(Icons.confirmation_number),),
            ),
            TextFormField(
              controller: cropId,
              decoration: const InputDecoration(labelText: 'Crop Id',prefixIcon: Icon(Icons.eco)),
            ),
            TextFormField(
              controller: agriYear,
              decoration: const InputDecoration(labelText: 'Agri Year',prefixIcon: Icon(Icons.calendar_today)),
            ),
            TextFormField(
              controller: quarter,
              decoration: const InputDecoration(labelText: 'Quarter',prefixIcon: Icon(Icons.calendar_month_outlined)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
              children: [
                // Clear Results Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _cultivationRecords = [];
                      farmId.clear();
                      cropId.clear();
                      agriYear.clear();
                      quarter.clear();
                    });
                  },
                  child: const Text('Clear Results', style: TextStyle(fontSize: 20.0, color: Colors.red)),
                ),
                // Search Button
                ElevatedButton(
                  onPressed: () {
                    String endpoint =
                        'https://bluebird-balanced-drum.ngrok-free.app/cultivation/search?';
                    if (farmId.text.isNotEmpty) {
                      endpoint += 'farm_id=${farmId.text}&';
                    }
                    if (cropId.text.isNotEmpty) {
                      endpoint += 'crop_id=${cropId.text}&';
                    }
                    if (agriYear.text.isNotEmpty) {
                      endpoint +=
                      'agri_year=${agriYear.text}&';
                    }
                    if (quarter.text.isNotEmpty) {
                      endpoint += 'quarter=${quarter.text}&';
                    }
                    endpoint += 'page=1&per_page=100';
                    searchCultivations(endpoint);
                  },
                  child: const Text('Search', style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.black26),
                    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.black12),

                    columns: const [
                      DataColumn(label: Text('Farm Id')),
                      DataColumn(label: Text('Crop Id')),
                      DataColumn(label: Text('Cultivation Info Id')),
                      DataColumn(label: Text('Display Name')),
                      DataColumn(label: Text('Agri Year')),
                      DataColumn(label: Text('Quartile')),
                      DataColumn(label: Text('Started Date')),
                      DataColumn(label: Text('Harvested Date')),
                      DataColumn(label: Text('Harvested Amount (Kg)')),
                      DataColumn(label: Text('Estimated Harvest (kg)')),
                      ],

                    rows: _cultivationRecords.map((record) {
                      return DataRow(cells: [
                        DataCell(Text('${record['farm_id']}')),
                        DataCell(Text('${record['crop_id']}')),
                        DataCell(Text('${record['cultivation_info_id']}')),
                        DataCell(Text('${record['display_name']}')),
                        DataCell(Text('${record['agri_year']}')),
                        DataCell(Text('${record['quarter']}')),
                        DataCell(Text('${record['started_date']}')),
                        DataCell(Text('${record['harvested_date']}')),
                        DataCell(Text('${record['harvested_amount']}')),
                        DataCell(Text('${record['estimated_harvest']}')),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
