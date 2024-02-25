import 'package:flutter/material.dart';
import 'package:myapp/Screens/AidDistribution/AidDistributionManagementPage.dart';
import 'package:myapp/Screens/Cultivation/CultivationManagementPage.dart';
import 'package:myapp/Screens/Disaster/DisasterRecordReportingPage.dart';
import 'package:myapp/Screens/Farms/FarmManagementPage.dart';
import 'package:myapp/Screens/Farmer/FarmerMgtPage.dart';
import '../Disaster/DisasterHome.dart';
import '../Home/HomePage.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AgriData DashBoard",
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Vertical space between buttons
              Image.asset(
                "lib/assets/logo.png",
                // Replace with your logo asset path
                width: 200, // Adjust width as needed
                height: 100, // Adjust height as needed
              ),

              const Text(
                  "Empowering Agriculture, \n     \t \t \t \t \t \t \t One byte at a time...",
                  style: TextStyle(fontSize: 20.0, color: Colors.brown)),
              const SizedBox(height: 50),
              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FarmerManagement()),
                    );
                  },
                  child: const Text(
                    'Farmer Manager',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Vertical space between buttons

              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FarmManagement()),
                    );
                  },
                  child: const Text(
                    'Farm Manager',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Vertical space between buttons

              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CultivationManagement()),
                    );
                  },
                  child: const Text(
                    'Cultivation Manager',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Vertical space between buttons

              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AidDistribution()),
                    );
                  },
                  child: const Text(
                    'Aid Distribution Manager',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
              const SizedBox(height: 30), // Vertical space between buttons

              SizedBox(
                width: 300,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DisasterHome()),
                    );
                  },
                  child: const Text(
                    'Disaster Records Manager',
                    style: TextStyle(fontSize: 20.0, color: Colors.green),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
