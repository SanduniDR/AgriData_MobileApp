import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'LoginPage.dart';

class SearchFarmersPage extends StatefulWidget {
  const SearchFarmersPage({Key? key}) : super(key: key);

  @override
  State<SearchFarmersPage> createState() => _SearchFarmersPageState();
}

class _SearchFarmersPageState extends State<SearchFarmersPage> {
  TextEditingController officeIdController = TextEditingController();
  TextEditingController taxFileNoController = TextEditingController();
  TextEditingController fieldAreaIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  List<dynamic> searchResults = [];

  //Add address of the farmer
  Future<void> searchFarmers(String endpoint) async {
    final Uri uri = Uri.parse(endpoint);
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['farmers'];
      List<dynamic> formattedData = data.map((item) {
        return {
          'FARMERS': {
            'farmer': item['farmer'],
            'user': item['user'],
          },
        };
      }).toList();
      setState(() {
        searchResults = formattedData;
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Farmers'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: officeIdController,
            decoration: const InputDecoration(labelText: 'Office ID'),
          ),
          TextField(
            controller: taxFileNoController,
            decoration: const InputDecoration(labelText: 'Tax File No'),
          ),
          TextField(
            controller: fieldAreaIdController,
            decoration: const InputDecoration(labelText: 'Field Area ID'),
          ),
          TextField(
            controller: userIdController,
            decoration: const InputDecoration(labelText: 'User ID'),
          ),
          ElevatedButton(
            onPressed: () {
              String endpoint = 'https://bluebird-balanced-drum.ngrok-free.app/user/search_farmers?';
              if (officeIdController.text.isNotEmpty) {
                endpoint += 'assigned_office_id=${officeIdController.text}&';
              }
              if (taxFileNoController.text.isNotEmpty) {
                endpoint += 'tax_file_no=${taxFileNoController.text}&';
              }
              if (fieldAreaIdController.text.isNotEmpty) {
                endpoint += 'assigned_field_area_id=${fieldAreaIdController.text}&';
              }
              if (userIdController.text.isNotEmpty) {
                endpoint += 'user_id=${userIdController.text}&';
              }
              endpoint += 'page=1&per_page=10';
              searchFarmers(endpoint);
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('User Id')),
                  DataColumn(label: Text('First Name')),
                  DataColumn(label: Text('Middle Name')),
                  DataColumn(label: Text('Last Name')),
                  DataColumn(label: Text('NIC')),
                  DataColumn(label: Text('DOB')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Registered Date')),
                  DataColumn(label: Text('Assigned Field Area Id')),
                  DataColumn(label: Text('Assigned Office Id')),
                  DataColumn(label: Text('Tax File No')),
                ],
                rows: searchResults.map((record) {
                  var farmerData = record['FARMERS']['farmer'];
                  var userData = record['FARMERS']['user'];
                  return DataRow(cells: [
                    DataCell(Text('${userData['user_id']}')),
                    DataCell(Text('${userData['first_name']}')),
                    DataCell(Text('${userData['middle_name']}')),
                    DataCell(Text('${userData['last_name']}')),
                    DataCell(Text('${userData['nic']}')),
                    DataCell(Text('${userData['dob']}')),
                    DataCell(Text('${userData['email']}')),
                    DataCell(Text('${farmerData['registered_date']}')),
                    DataCell(Text('${farmerData['assigned_field_area_id']}')),
                    DataCell(Text('${farmerData['assigned_office_id']}')),
                    DataCell(Text('${farmerData['tax_file_no']}')),
                  ]);
                }).toList(),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
