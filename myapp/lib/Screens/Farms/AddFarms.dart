import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Screens/Cultivation/LogCultivation.dart';
import 'package:myapp/Screens/Farmer/SearchFarmer.dart';

import '../Home/HomePage.dart';
import '../AgriOfficer/LoginPage.dart';

class AddFarms extends StatefulWidget {
  const AddFarms({super.key});

  @override
  State<AddFarms> createState() => _AddFarmsState();
}

class _AddFarmsState extends State<AddFarms> {
  TextEditingController farmerId = TextEditingController();
  TextEditingController farmName = TextEditingController();
  TextEditingController farmAddress = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController FieldAreainAcre = TextEditingController();
  TextEditingController ownerName = TextEditingController();
  TextEditingController ownerNic = TextEditingController();


  Future<void> _performAddFarm() async{
    const String apiUrl =
        'https://bluebird-balanced-drum.ngrok-free.app/farm';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',

      },
      body: jsonEncode(<String, dynamic>{
        'farm_name': farmName.text,
        'address': farmAddress.text,
        'type': type.text,
        'farmer_id': int.parse(farmerId.text),
        'area_of_field':double.parse(FieldAreainAcre.text),
        'owner_nic': ownerNic.text,
        'owner_name': ownerName.text,
      }),
    );

    if (!mounted) return;
    if (response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AddCultivation()),
      );
      Fluttertoast.showToast(
          msg: "Successfully added a new farm",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black12,
          textColor: Colors.green,
          fontSize: 16.0,);
    // print(response.body.toString());
  }else if (response.statusCode == 404){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Failed Add Farm '),
            content: const Text('No farmer was found by added \' Farm No \''),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Failed Add Farm '),
            content: const Text('There is already a farm registered by that name'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    }

  void _performSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchFarmersPage()),
    );

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Farm Details",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align items to the start of the row
                  children: [
                    const Expanded(
                      // Use Expanded for the text to ensure it takes up the available space
                      child: Text(
                        "* Hint: \nInsert User_Id as Farmer Id",
                        style: TextStyle(fontSize: 15.0, backgroundColor: Colors.tealAccent),
                      ),
                    ),
                    const SizedBox(width: 10), // Add some spacing between the text and the button
                    ElevatedButton.icon(
                      icon: const Icon(Icons.search), // Add the search icon here
                      label: const Text(
                        'Search User Id',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      onPressed: () {
                        _performSearch(context);
                      },
                    ),
                  ],
                ),

                const Align(
              alignment: Alignment.centerLeft,
              child: Text("Farm Details:", style: TextStyle(fontSize: 20.0)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: farmerId,
              decoration: const InputDecoration(
                labelText: "Farmer Id",
                prefixIcon: Icon(Icons.person),
                  hintText: 'Eg: User_ID ',
                  hintStyle: TextStyle(color: Colors.black12)
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter farmer user Id';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: farmName,
              decoration: const InputDecoration(
                labelText: "Farm Name",
                prefixIcon: Icon(Icons.grain),
                  hintText: 'Eg: Rice-4022-29 ',//([CropName]-[FieldAreaID]-[FarmerID])
                  hintStyle: TextStyle(color: Colors.black12)
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: farmAddress,
              decoration: const InputDecoration(
                labelText: "Farm Address",
                prefixIcon: Icon(Icons.home),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: type,
              decoration: const InputDecoration(
                labelText: "Type",
                prefixIcon: Icon(Icons.eco),
                  hintText: 'Eg: Crop or Animal',
                  hintStyle: TextStyle(color: Colors.black12)
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: FieldAreainAcre,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: "Field Area in Acre",
                prefixIcon: Icon(Icons.landscape),
                  hintText: "Enter area in acres",
                  hintStyle: TextStyle(color: Colors.black12)
            ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this';
                }
                return null;
              },
            ),
            const SizedBox(height: 35),
            const Align(
              alignment: Alignment.centerLeft,
              child:
                  Text("Farm Owner Details:", style: TextStyle(fontSize: 20.0)),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ownerName,
              decoration: const InputDecoration(
                labelText: "Owner Full Name",
                prefixIcon: Icon(Icons.person),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please fill this';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ownerNic,
              decoration: const InputDecoration(
                labelText: "Owner NIC",
                prefixIcon: Icon(Icons.person),
                hintText: 'Eg: 9379*****V',
                  hintStyle: TextStyle(color: Colors.black12)

              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter owner NIC';
                }
                // Regex for NIC validation
                RegExp regExp = RegExp(r'^[0-9]{9}[vVxX]$');

                if (!regExp.hasMatch(value)) {
                  // Means if NIC is invalid
                  return 'Please enter a owner NIC';
                }
                return null;
              },
            ),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    _performAddFarm();
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
