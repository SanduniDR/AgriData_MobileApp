import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Home/HomePage.dart';
import '../AgriOfficer/LoginPage.dart';

class SearchAidDistributionPage extends StatefulWidget {
  const SearchAidDistributionPage({Key? key}) : super(key: key);

  @override
  State<SearchAidDistributionPage> createState() => _SearchAidDistributionPageState();
}

class _SearchAidDistributionPageState extends State<SearchAidDistributionPage> {

  TextEditingController aidId = TextEditingController();
  TextEditingController aidType = TextEditingController();
  TextEditingController farmerId = TextEditingController();
  TextEditingController  agriOfficeId = TextEditingController();
  TextEditingController inChargedOfficerId = TextEditingController();
  List<dynamic> _aidDistributionRecords = [];
  // List<Map<String, dynamic>> _farmRecords = [];


  Future<void> searchAidDstributions(String endpoint) async {
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
          _aidDistributionRecords = []; // Set _farmRecords to an empty list
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
            'aid_id': item['aid_id'],
            'description': item['description'],
            'distribution_id': item['distribution_id'],
            'farmer_id': item['farmer_id'],
            'agri_office_id': item['agri_office_id'],
            'in_charged_officer_id': item['in_charged_officer_id'],
            'amount_approved': item['amount_approved'],
            'amount_received': item['amount_received'],
            'cultivation_info_id': item['cultivation_info_id'],
            'date': item['date'],

          };
        }).toList();

        setState(() {
          _aidDistributionRecords = formattedData;
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
          "Search Aid Distribution Records",
          style: TextStyle(fontSize: 25.0),
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
              controller: aidId,
              decoration: const InputDecoration(labelText: 'Aid Id',prefixIcon: Icon(Icons.confirmation_number),),
            ),
            TextFormField(
              controller: aidType,
              decoration: const InputDecoration(labelText: 'Aid Type',prefixIcon: Icon(Icons.eco)),
            ),
            TextFormField(
              controller: farmerId,
              decoration: const InputDecoration(labelText: 'Farmer Id',prefixIcon: Icon(Icons.person)),
            ),
            TextFormField(
              controller: agriOfficeId,
              decoration: const InputDecoration(labelText: 'Agri-Office Id',prefixIcon: Icon(Icons.business)),
            ),
            TextFormField(
              controller: inChargedOfficerId,
              decoration: const InputDecoration(labelText: 'In Charged AgriOfficer Id',prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
              children: [
                // Clear Results Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _aidDistributionRecords = [];
                      aidId.clear();
                      aidType.clear();
                      agriOfficeId.clear();
                      farmerId.clear();
                      inChargedOfficerId.clear();
                    });
                  },
                  child: const Text('Clear Results', style: TextStyle(fontSize: 20.0, color: Colors.red)),
                ),
                // Search Button
                ElevatedButton(
                  onPressed: () {
                    String endpoint =
                        'https://bluebird-balanced-drum.ngrok-free.app/aid/aid-distribution/search?';
                    if (aidId.text.isNotEmpty) {
                      endpoint += 'aid_id=${aidId.text}&';
                    }
                    if (farmerId.text.isNotEmpty) {
                      endpoint += 'farmer_id=${farmerId.text}&';
                    }
                    if (aidType.text.isNotEmpty) {
                      endpoint +=
                      'description=${aidType.text}&';
                    }
                    if (agriOfficeId.text.isNotEmpty) {
                      endpoint += 'agri_office_id=${agriOfficeId.text}&';
                    }
                    if (inChargedOfficerId.text.isNotEmpty) {
                      endpoint += 'in_charged_officer_id=${inChargedOfficerId.text}&';
                    }
                    endpoint += 'page=1&per_page=100';
                    searchAidDstributions(endpoint);
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
                      DataColumn(label: Text('Aid Id')),
                      DataColumn(label: Text('Aid Type')),
                      DataColumn(label: Text('Farmer Id')),
                      DataColumn(label: Text('Distribution Id')),
                      DataColumn(label: Text('Amount Approved')),
                      DataColumn(label: Text('Amount Received')),
                      DataColumn(label: Text('Cultivation Record No')),
                      DataColumn(label: Text('Agri-office Id')),
                      DataColumn(label: Text('In Charged Agri-Officer Id')),
                      DataColumn(label: Text('Received Date')),
                    ],

                    rows: _aidDistributionRecords.map((record) {
                      return DataRow(cells: [
                        DataCell(Text('${record['aid_id']}')),
                        DataCell(Text('${record['description']}')),
                        DataCell(Text('${record['farmer_id']}')),
                        DataCell(Text('${record['distribution_id']}')),
                        DataCell(Text('${record['amount_approved']}')),
                        DataCell(Text('${record['amount_received']}')),
                        DataCell(Text('${record['cultivation_info_id']}')),
                        DataCell(Text('${record['agri_office_id']}')),
                        DataCell(Text('${record['in_charged_officer_id']}')),
                        DataCell(Text('${record['date']}')),
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
