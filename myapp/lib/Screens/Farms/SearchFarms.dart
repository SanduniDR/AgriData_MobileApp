import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Home/HomePage.dart';
import '../AgriOfficer/LoginPage.dart';

class SearchFarmsPage extends StatefulWidget {
  const SearchFarmsPage({Key? key}) : super(key: key);

  @override
  State<SearchFarmsPage> createState() => _SearchFarmsPageState();
}

class _SearchFarmsPageState extends State<SearchFarmsPage> {

  TextEditingController farmId = TextEditingController();
  TextEditingController farmName = TextEditingController();
  TextEditingController ownerNic = TextEditingController();
  TextEditingController type = TextEditingController();
  List<dynamic> _farmRecords = [];
  // List<Map<String, dynamic>> _farmRecords = [];


  //Add address of the farmer
  Future<void> searchFarms(String endpoint) async {
    final Uri uri = Uri.parse(endpoint);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body.toString());

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['farms'];
      if (data.isEmpty) {

        setState(() {
          _farmRecords = []; // Set _farmRecords to an empty list
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
            'farm_name': item['farm_name'],
            'farmer_id': item['farmer_id'],
            'owner_name': item['owner_name'],
            'owner_nic': item['owner_nic'],
            'type': item['type'],
            // Include any other fields you need from the response
          };
        }).toList();

        setState(() {
          _farmRecords = formattedData;
        });
      }
    }else{
      Fluttertoast.showToast(
        msg: response.body.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black12,
        textColor: Colors.green,
        fontSize: 16.0,);
    }
  }

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Farms",
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
              controller: farmName,
              decoration: const InputDecoration(labelText: 'Farm Name',prefixIcon: Icon(Icons.landscape)),
            ),
            TextFormField(
              controller: ownerNic,
              decoration: const InputDecoration(labelText: 'Owner NIC',prefixIcon: Icon(Icons.person)),
            ),
            TextFormField(
              controller: type,
              decoration: const InputDecoration(labelText: 'Type',prefixIcon: Icon(Icons.category)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
              children: [
                // Clear Results Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _farmRecords = [];
                      farmId.clear();
                      farmName.clear();
                      ownerNic.clear();
                      type.clear();
                    });
                  },
                  child: const Text('Clear Results', style: TextStyle(fontSize: 20.0, color: Colors.red)),
                ),
                // Search Button
                ElevatedButton(
                  onPressed: () {
                    String endpoint =
                        'https://bluebird-balanced-drum.ngrok-free.app/farm/search?';
                    if (farmId.text.isNotEmpty) {
                      endpoint += 'farm_id=${farmId.text}&';
                    }
                    if (farmName.text.isNotEmpty) {
                      endpoint += 'farm_name=${farmName.text}&';
                    }
                    if (ownerNic.text.isNotEmpty) {
                      endpoint +=
                      'owner_nic=${ownerNic.text}&';
                    }
                    if (type.text.isNotEmpty) {
                      endpoint += 'type=${type.text}&';
                    }
                    endpoint += 'page=1&per_page=10';
                    searchFarms(endpoint);
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
                      DataColumn(label: Text('Farmer Id')),
                      DataColumn(label: Text('Farm Id')),
                      DataColumn(label: Text('Farm Name')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Owner NIC')),
                      DataColumn(label: Text('Owner Name')),
                      DataColumn(label: Text('Area of Farm')),
                      DataColumn(label: Text('Farm Address')),

                    ],
                    rows: _farmRecords.map((record) {
                      return DataRow(cells: [
                        DataCell(Text('${record['farmer_id']}')),
                        DataCell(Text('${record['farm_id']}')),
                        DataCell(Text('${record['farm_name']}')),
                        DataCell(Text('${record['type']}')),
                        DataCell(Text('${record['owner_nic']}')),
                        DataCell(Text('${record['owner_name']}')),
                        DataCell(Text('${record['area_of_field']}')),
                        DataCell(Text('${record['address']}')),
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
