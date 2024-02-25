import 'package:flutter/material.dart';
import 'package:myapp/Screens/Disaster/CropDiseaseReportingPage.dart';
import 'package:myapp/Screens/Disaster/DisasterRecordReportingPage.dart';
import 'package:myapp/Screens/Farms/AddFarms.dart';
import 'package:myapp/Screens/Farms/SearchFarms.dart';

import '../Home/HomePage.dart';

class DisasterHome extends StatefulWidget {
  const DisasterHome({super.key});

  @override
  State<DisasterHome> createState() => _DisasterHomeState();
}

class _DisasterHomeState extends State<DisasterHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Disaster Records Manager",
          style: TextStyle(fontSize: 30.0),
        ),
        backgroundColor: Colors.teal.shade200,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "lib/assets/Disaster.jpg",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CropDiseaseRecords()),
                    );
                  },
                  child: const Text(
                    'Crop Diseases Issues Reporting',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DisasterRecords()),
                    );
                  },
                  child: const Text(
                    'Disaster Issues Reporting',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(
                height: 140,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
