import 'package:flutter/material.dart';

class AddCultivation extends StatefulWidget {
  const AddCultivation({super.key});

  @override
  State<AddCultivation> createState() => _AddCultivationState();
}

class _AddCultivationState extends State<AddCultivation> {

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
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

            const SizedBox(height: 30),

            const SizedBox(height: 20),
            TextFormField(
              // controller: displayName,
              decoration: const InputDecoration(
                labelText: "DisplayName",
                prefixIcon: Icon(Icons.person),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
               //controller: farmName,
              decoration: const InputDecoration(
                labelText: "Farm Name",
                prefixIcon: Icon(Icons.agriculture),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              //controller: farmAddress,
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
              //controller: type,
              decoration: const InputDecoration(
                labelText: "Type",
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
              //controller: FieldAreainAcre,
              decoration: const InputDecoration(
                labelText: "Field Area in Acre",
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
            const SizedBox(height: 35),

            const SizedBox(height: 20),
            TextFormField(
              //controller: ownerName,
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
              //controller: ownerNic,
              decoration: const InputDecoration(
                labelText: "Owner NIC",
                prefixIcon: Icon(Icons.person),
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
