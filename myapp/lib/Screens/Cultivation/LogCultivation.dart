import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/Screens/Farms/SearchFarms.dart';
import 'package:http/http.dart' as http;

import '../Home/HomePage.dart';

int currentyear=2024;
int lastnearyear=2023;
int nearfutureyear=2026;

class AddCultivation extends StatefulWidget {
  const AddCultivation({super.key});

  @override
  State<AddCultivation> createState() => _AddCultivationState();
}

class _AddCultivationState extends State<AddCultivation> {
  int? _selectedValue,_selectedValueQuartile;

  TextEditingController farmId = TextEditingController(); //int
  TextEditingController cropId = TextEditingController(); //int
  TextEditingController displayName = TextEditingController();
  TextEditingController cultivationAreaInAcre = TextEditingController(); //int
  TextEditingController startedDate = TextEditingController();
  TextEditingController estimatedHarvestingDate = TextEditingController();
  TextEditingController estimatedHarvest = TextEditingController(); //int
  TextEditingController harvestedAmount = TextEditingController(); //int
  TextEditingController agriYear = TextEditingController(); //int
  TextEditingController quarter = TextEditingController(); //int
  TextEditingController cultivationStartedDate = TextEditingController(); //date

//longitude //lattitude

  void _performFarmIdSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchFarmsPage()),
    );
  }

//select data for dob
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(lastnearyear),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        cultivationStartedDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectEstimateDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(currentyear),
      lastDate: DateTime(nearfutureyear),
    );
    if (picked != null) {
      setState(() {
        estimatedHarvestingDate.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  List<DropdownMenuItem<int>> get dropdownItems {
    List<DropdownMenuItem<int>> menuItems = [
      const DropdownMenuItem(child: Text(" Yala Season "), value: 1),
      const DropdownMenuItem(child: Text(" Maha Season "), value: 2),
      const DropdownMenuItem(child: Text("Throughout the Year "), value: 3),
      // Add as many options as you need
    ];
    return menuItems;
  }
  List<DropdownMenuItem<int>> get dropdownItemsQuartile {
    List<DropdownMenuItem<int>> menuItems = [
      const DropdownMenuItem(child: Text(" 1st Quartile "), value: 1),
      const DropdownMenuItem(child: Text(" 2nd Quartile  "), value: 2),
      const DropdownMenuItem(child: Text("3rd Quartile  "), value: 3),
      // Add as many options as you need
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Cultivation Details",
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.search), // Add the search icon here
                  label: const Text(
                    'Farm Id',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () {
                    _performFarmIdSearch(context);
                  },
                ),
              ],
            ),

            TextFormField(
              controller: farmId,
              decoration: const InputDecoration(
                labelText: "Farm Id",
                prefixIcon: Icon(Icons.business),
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
              controller: displayName,
              decoration: const InputDecoration(
                  labelText: "Farm Display Name",
                  prefixIcon: Icon(Icons.account_circle),
                  hintText: 'Eg: F-3-rice ', //([F]-[FarmID]-[cropName])
                  hintStyle: TextStyle(color: Colors.black12)),
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
              controller: cropId,
              decoration: const InputDecoration(
                labelText: "Crop Id",
                prefixIcon: Icon(Icons.grass),
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
              controller: cultivationAreaInAcre,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: "Cultivated Area in Acre",
                  prefixIcon: Icon(Icons.landscape),
                  hintText: "Enter area in acres",
                  hintStyle: TextStyle(color: Colors.black12)),
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
              controller: estimatedHarvest,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                  labelText: "Estimated Harvest Amount",
                  prefixIcon: Icon(Icons.date_range),
                  hintText: "Enter in Kg",
                  hintStyle: TextStyle(color: Colors.black12)),
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
                  controller: harvestedAmount,
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: "Yield",
                      prefixIcon: Icon(Icons.date_range),
                      hintText: "Enter in Kg",
                      hintStyle: TextStyle(color: Colors.black12)),
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
              readOnly: true,
              controller: cultivationStartedDate,
              decoration: InputDecoration(
                labelText: "Cultivation Started Date",
                prefixIcon: const Icon(Icons.calendar_month),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.edit_calendar_rounded),
                  onPressed: () => _selectDate(context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              controller: estimatedHarvestingDate,
              decoration: InputDecoration(
                labelText: "Estimated Harvesting Date",
                prefixIcon: const Icon(Icons.calendar_month_outlined),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.edit_calendar_rounded),
                  onPressed: () => _selectEstimateDate(context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 15),
                const Icon(Icons.eco_outlined),
                const Text(
                  "Agri Year",
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(width: 50),
                DropdownButton<int>(
                  value: _selectedValue,
                  items: dropdownItems,
                  onChanged: (int? newvalue) {
                    setState(() {
                      _selectedValue = newvalue;
                    });
                  },
                  hint: Text("Select an Option"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 15),
                const Icon(Icons.equalizer),
                const Text(
                  "Quartile",
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(width: 50),
                DropdownButton<int>(
                  value: _selectedValueQuartile,
                  items: dropdownItemsQuartile,
                  onChanged: (int? newvalue) {
                    setState(() {
                      _selectedValueQuartile = newvalue;
                    });
                  },
                  hint: Text("Select an Option"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
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
