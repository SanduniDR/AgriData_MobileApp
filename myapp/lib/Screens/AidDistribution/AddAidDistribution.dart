import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Screens/Cultivation/SearchCultivation.dart';
import 'package:myapp/Screens/Home/HomePage.dart';
import '../../globals.dart';
import '../AgriOfficer/LoginPage.dart';
import '../Farmer/SearchFarmer.dart';
import 'package:http/http.dart' as http;

class AddAidDistributionRecords extends StatefulWidget {
  const AddAidDistributionRecords({super.key});

  @override
  State<AddAidDistributionRecords> createState() => _AddAidDistributionRecordsState();
}

class _AddAidDistributionRecordsState extends State<AddAidDistributionRecords> {

  String? _selectedAidValue;

  TextEditingController aidId = TextEditingController(); //int
  TextEditingController agriOfficeId = TextEditingController(); //int
  TextEditingController inchargedOfficerId = TextEditingController();
  TextEditingController cultivationInfoId = TextEditingController(); //int
  TextEditingController farmerId = TextEditingController();
  TextEditingController amountReceived = TextEditingController();
  TextEditingController amountApproved = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController date = TextEditingController(); //date
//date

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Fertilizer"), value: "Fertilizer"),
      DropdownMenuItem(child: Text("Fuel"), value: "Fuel"),
      DropdownMenuItem(child: Text("Pesticides"), value: "Pesticides"),
      DropdownMenuItem(child: Text("Monetary"), value: "Monetary"),
      DropdownMenuItem(child: Text("Miscellaneous"), value: "Miscellaneous"),

      // Add as many options as you need
    ];
    return menuItems;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null) {

      setState(() {
        date.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _performFarmerIdSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchFarmersPage()),
    );
  }

  void _performCultivationInfoIdSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchCultivationPage()),
    );
  }

  Future<void> _performAddAidDistribution() async {
    const String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/aid/aid-distribution';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',

        },
        body: jsonEncode(<String, dynamic>{
          'aid_id': int.parse(aidId.text),
          'agri_office_id': int.parse(agriOfficeId.text),
          'date': DateFormat('yyyy-MM-dd')
              .format(DateTime.parse(date.text)),
          'in_charged_officer_id': int.parse(inchargedOfficerId.text),
          'cultivation_info_id': int.parse(cultivationInfoId.text),
          'farmer_id': int.parse(farmerId.text),
          'amount_received': int.parse(amountReceived.text),
          'amount_approved': int.parse(amountApproved.text),
          "description": discription.text
        }),
      );
      print('Response body: ${response.body}');
      if (!mounted) return;
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        Fluttertoast.showToast(
          msg: "Successfully added a new AidDistribution",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black12,
          textColor: Colors.green,
          fontSize: 16.0,);
        // print(response.body.toString());
      } else {
        Fluttertoast.showToast(
          msg: "Failed to add AidDistribution. Status code: ${response
              .statusCode}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,);
      }
    } catch (e) {
// Handling any exceptions during the request
      Fluttertoast.showToast(
        msg: "An error occurred: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New Aid Distribution",
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.teal.shade200,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            TextFormField(
              controller: aidId,
              decoration: const InputDecoration(
                  labelText: "Aid Id",
                  prefixIcon: Icon(Icons.support),
                  hintText: " Eg: Id:03 related [Indian Trust]"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Aid Id';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: agriOfficeId,
              decoration: const InputDecoration(
                  labelText: "Agri-Office Id",
                  prefixIcon: Icon(Icons.business),
                  hintText: 'Eg:100 [Dodangoda] ',
                  hintStyle: TextStyle(color: Colors.black12)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Fill';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: inchargedOfficerId,
              decoration: const InputDecoration(
                labelText: "Agri Officer Id (incharged)",
                prefixIcon: Icon(Icons.person),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Fill';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.search), // Add the search icon here
                  label: const Text(
                    'Farmer Id             ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () {
                     _performFarmerIdSearch(context);
                  },
                ),
              ],
            ),
            TextFormField(
              controller: farmerId,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: "Farmer Id",
                  prefixIcon: Icon(Icons.person),
                  hintText: "Eg:05 [User Id]",
                  hintStyle: TextStyle(color: Colors.black12)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Fill';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const SizedBox(width: 15),
                const Icon(Icons.eco_outlined),
                const Text(
                  "Aid Type",
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(width: 50),
                DropdownButton<String>(
                  value: _selectedAidValue,
                  items: dropdownItems,
                  onChanged: (String? choice) {
                    setState(() {
                      _selectedAidValue = choice;
                    });
                  },
                  hint: const Text("Select an Aid"),
                ),
              ],
            ),const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.search), // Add the search icon here
                      label: const Text(
                        'Cultivation Info Id',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                         _performCultivationInfoIdSearch(context);
                      },
                    ),
                  ],
                ),
            TextFormField(
              controller: cultivationInfoId,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: "Cultivation Info Id",
                  prefixIcon: Icon(Icons.landscape),
                  hintText: "Eg: 05",
                  hintStyle: TextStyle(color: Colors.black12)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Fill';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: amountApproved,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: "Amount Approved",
                  prefixIcon: Icon(Icons.handshake_outlined),
                  hintText: "in Liters, Kg, Lkr",
                  hintStyle: TextStyle(color: Colors.black12)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Fill';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: amountReceived,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: "Amount Received",
                  prefixIcon: Icon(Icons.handshake),
                  hintText: "in Liters, Kg, Lkr",
                  hintStyle: TextStyle(color: Colors.black12)),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Fill';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              controller: date,
              decoration: InputDecoration(
                labelText: "Aid Received Date",
                prefixIcon: const Icon(Icons.calendar_month),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.edit_calendar_rounded),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _performAddAidDistribution();
                },
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

